//
//  main.m
//  DataProcess
//
//  Created by xmeng17 on 1/22/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cities.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString* url = @"/Users/xmeng17/Documents/MapRouting/MapRouting/city2.csv";
        NSString *dataContents = [NSString stringWithContentsOfFile:url encoding:NSUTF8StringEncoding error:nil];
        NSMutableArray *Data=(NSMutableArray*)[dataContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        
         
        NSString* url2 = @"/Users/xmeng17/Documents/MapRouting/MapRouting/city1.csv";
        NSString *dataContents2 = [NSString stringWithContentsOfFile:url2 encoding:NSUTF8StringEncoding error:nil];
        NSMutableArray *Data2=(NSMutableArray*)[dataContents2 componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        [Data2 removeObjectAtIndex:0];
        
        
        NSMutableArray* cities=[[NSMutableArray alloc]init];
        for(int i=0;i<[Data count];i++){
            NSArray* onecity=[[Data objectAtIndex:i]componentsSeparatedByString:@","];
            Cities* onecityobj=[[Cities alloc]initWithValue:nil state:nil county:nil x:[[onecity objectAtIndex:1]doubleValue] y:[[onecity objectAtIndex:2]doubleValue] ind:i];
            [cities addObject:onecityobj];
        }
        
        NSMutableArray* cities2=[[NSMutableArray alloc]init];
        for(int i=0;i<[Data2 count];i++){
            NSArray* onecity2=[[Data2 objectAtIndex:i]componentsSeparatedByString:@","];
            Cities* onecityobj2=[[Cities alloc]initWithValue:[onecity2 objectAtIndex:0] state:[onecity2 objectAtIndex:1] county:[onecity2 objectAtIndex:2] x:[[onecity2 objectAtIndex:3]doubleValue] y:[[onecity2 objectAtIndex:4]doubleValue] ind:-1];
            [cities2 addObject:onecityobj2];
        }
        
        int num=0;
        
        for(int j=0;j<[cities2 count];j++){
            for(int i=0;i<[cities count];i++){
                
                if(fabs([[cities2 objectAtIndex:j]y]-[[cities objectAtIndex:i]y])<=0.005&&fabs([[cities2 objectAtIndex:j]x]-[[cities objectAtIndex:i]x])<=0.005&&[[cities2 objectAtIndex:j]ind]==-1&&[[cities objectAtIndex:i]name]==nil){
                    [[cities2 objectAtIndex:j]setInd:[[cities objectAtIndex:i]ind]];
                    [[cities2 objectAtIndex:j]setX:[[cities objectAtIndex:i]x]];
                    [[cities2 objectAtIndex:j]setY:[[cities objectAtIndex:i]y]];
                    [[cities objectAtIndex:i ] setName:@" "];
                    num++;
                }
            }
        }
        NSLog(@"done:%d, total(cityonly):%d,total(city):%d",num,(int)[cities count],(int)[cities2 count]);
        NSMutableString* hello=[[NSMutableString alloc]init];
        for(int j=0;j<[cities2 count];j++){
            Cities* city=[cities2 objectAtIndex:j];
            
            if([city ind]!=-1){
                
                [hello appendString:[@([city ind]) stringValue] ];
                [hello appendString:@","];
                [hello appendString:[city name]];
                [hello appendString:@","];
                [hello appendString:[city state]];
                [hello appendString:@","];
                [hello appendString:[city county]];
                [hello appendString:@","];
                [hello appendString:[@([city x])stringValue] ];
                [hello appendString:@","];
                [hello appendString:[@([city y])stringValue] ];
                [hello appendString:@"\n"];
                
                
            }
        }
        NSString* Hello=(NSString*)hello;
        [Hello writeToFile:@"/Users/xmeng17/city.txt" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    }
    
    return 0;
}
