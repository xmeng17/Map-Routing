//
//  GameScene.m
//  MapRouting
//
//  Created by xmeng17 on 1/22/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
}

- (void)didMoveToView:(SKView *)view {
    [self import];
    [self buildgraph];
    [self drawCity:view];
    
}

-(void)drawCity:(SKView*)view{
    //draw the cities
    self.backgroundColor = SKColor.whiteColor;
    SKSpriteNode* sprite=[SKSpriteNode spriteNodeWithImageNamed:@"bg"];
    [sprite setScale:1.7];
    [sprite setPosition:CGPointMake(0,-43)];
    [self addChild:sprite];
    
    for(NSString* key in [self.city allKeys]){
        
        if([key intValue]%40==0){
            Vertex* vertex=[self.city objectForKey:key];
            SKShapeNode *Circle = [SKShapeNode shapeNodeWithCircleOfRadius:1]; // Size of Circle
            Circle.position = CGPointMake(vertex.x*view.frame.size.width,vertex.y*view.frame.size.height-60);
            Circle.strokeColor = SKColor.blackColor;
            Circle.fillColor = SKColor.blackColor;
            [self addChild:Circle];
            
            
        }
    }

}

-(NSMutableArray*)drawResult:(SKView*)view{
    //draw the result
    
    //print begin city name
    SKLabelNode *city = [SKLabelNode labelNodeWithFontNamed:[[[NSFont systemFontOfSize:15]fontName]stringByAppendingString:@"-Bold"]];
    city.text = [NSString stringWithFormat:@"%@",self.fromvert.name];
    city.fontSize = 20;
    city.fontColor = [SKColor brownColor];
    city.position = CGPointMake(self.fromvert.x*view.frame.size.width,self.fromvert.y*view.frame.size.height-45);
    [self addChild:city];
    
    //print end city name
    SKLabelNode *city2 = [SKLabelNode labelNodeWithFontNamed:[[[NSFont systemFontOfSize:15]fontName]stringByAppendingString:@"-Bold"]];
    city2.text = [NSString stringWithFormat:@"%@",self.tovert.name];
    city2.fontSize = 20;
    city2.fontColor = [SKColor brownColor];
    city2.position = CGPointMake(self.tovert.x*view.frame.size.width,self.tovert.y*view.frame.size.height-45);
    [self addChild:city2];
    
    
    //draw route
    SKShapeNode *line = [SKShapeNode node];
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,self.fromvert.x*view.frame.size.width, self.fromvert.y*view.frame.size.height-60);

    Vertex* current=self.fromvert.parent;
    while(current){
        //create rout
        CGPathAddLineToPoint(path, NULL, current.x*view.frame.size.width, current.y*view.frame.size.height-60);
        //iterate next
        current=current.parent;
        
    }
    
   
    [line setPath:path];
    line.lineWidth = 3;
    line.strokeColor = [SKColor redColor];
    [self addChild:line];

    NSMutableArray* arr=[[NSMutableArray alloc]init];
    [arr addObject:city];
    [arr addObject:city2];
    [arr addObject:line];
    return arr;

}

-(void)import{
    //import vertex file
    
    NSURL* url  = [[NSBundle mainBundle] URLForResource:@"city" withExtension:@"csv"];
    NSString *citycontent = [NSString stringWithContentsOfFile:[url path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *origcity=(NSMutableArray*)[citycontent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    self.city=[[NSMutableDictionary alloc]init];
    for(int i=0;i<[origcity count];i++){
        NSString* citydatastr=[origcity objectAtIndex:i];
        NSMutableArray* citydata=(NSMutableArray*)[citydatastr componentsSeparatedByString:@","];
        Vertex* onecity=[[Vertex alloc]initWithValue:nil x:[[citydata objectAtIndex:1]doubleValue] y:[[citydata objectAtIndex:2]doubleValue]];
        [self.city setObject:onecity forKey:[citydata objectAtIndex:0]];
    }
    
    //import city name file
    NSURL* url3  = [[NSBundle mainBundle] URLForResource:@"name" withExtension:@"csv"];
    NSString *citycontent3 = [NSString stringWithContentsOfFile:[url3 path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *origcity3=(NSMutableArray*)[citycontent3 componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for(int i=0;i<[origcity3 count];i++){
        NSString* citydatastr3=[origcity3 objectAtIndex:i];
        NSMutableArray* citydata3=(NSMutableArray*)[citydatastr3 componentsSeparatedByString:@","];
        Vertex* onecity3=[[Vertex alloc]initWithValue:[[[citydata3 objectAtIndex:1]stringByAppendingString:@","]stringByAppendingString:[citydata3 objectAtIndex:2] ] x:[[citydata3 objectAtIndex:4]doubleValue] y:[[citydata3 objectAtIndex:5]doubleValue]];
        [self.city setObject:onecity3 forKey:[citydata3 objectAtIndex:0]];
    }
    
    //import connection file
    NSURL* url4=[[NSBundle mainBundle] URLForResource:@"connection" withExtension:@"csv"];
    NSString* connectioncontent=[NSString stringWithContentsOfFile:[url4 path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray* connection=(NSMutableArray*)[connectioncontent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    self.connection1=[[NSMutableArray alloc]init];
    self.connection2=[[NSMutableArray alloc]init];
    for(int i=0;i<[connection count];i++){
        NSString* connectiondatastr=[connection objectAtIndex:i];
        NSMutableArray* connectiondata=(NSMutableArray*)[connectiondatastr componentsSeparatedByString:@","];
        [self.connection1 addObject:[connectiondata objectAtIndex:0]];
        [self.connection2 addObject:[connectiondata objectAtIndex:1]];
    }

}

-(void)buildgraph{
    
    
    
    //create graph
    self.graph=[[Graph alloc]init];
    
    //add vertex to graph
    self.graph.vertList=self.city;
    //add edges
    for(int i=0;i<[self.connection1 count];i++){
        [self.graph addEdgeBetween:[self.graph.vertList objectForKey:[self.connection1 objectAtIndex:i]] and:[self.graph.vertList objectForKey:[self.connection2 objectAtIndex:i]]];
    }
    
}

-(BOOL)dijkstra{
    
    
    //init, start search from destination to original
    Heap* heap=[[Heap alloc] init];
    for(Vertex* vertex in [self.graph.vertList allValues]){
        [vertex setDistance:DBL_MAX];
        [vertex setParent:nil];
        [heap insert:vertex];
    }
    [self.tovert setDistance:0];
    
    BOOL keeplooping=YES;
    
    int time=0;
    //dijkstra
    while([heap.list count]>0&&keeplooping){
        //get item from stack
        Vertex* current=[heap extractMin];
        for(int i=0;i<[[current adjacent]count];i++){
            //get adjacent
            Vertex* adj=[[current adjacent]objectAtIndex:i];
            //calc new distance
            double alt=[current distance]+[self.graph distanceBetween:current and:adj];
            if(alt<[adj distance]){
                [adj setParent:current];
                [adj setDistance:alt];
                [heap insert:adj];
                
                
            }
        }
        
        time++;
    }
    
    Vertex* current=self.fromvert;
    
    while(current.parent){
        current=current.parent;
    }

    if([current isEqual:self.tovert]){
        return YES;
    }else{
        return NO;
    }
    
    
    
    
}



-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
