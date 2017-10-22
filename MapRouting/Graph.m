//
//  Graph.m
//  WordLadder
//
//  Created by xmeng17 on 1/13/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import "Graph.h"

@implementation Graph

-(instancetype)init{
    self=[super init];
    self.vertList=[[NSMutableDictionary alloc]init];
    self.numVert=0;
    return self;
}

-(Vertex*)addVertex:(Vertex*)city forKey:(NSString*)key{
    [self.vertList setObject:city forKey:key];
    return city;
}

-(Vertex*)findVertex:(NSString*)name{
    for(Vertex* vertex in [self.vertList allValues]){
        if([vertex.name isEqualToString:name]){
            return vertex;
        }
    }
    return nil;
}

-(void)addEdgeBetween:(Vertex*)verta and:(Vertex*)vertb{
    [[verta adjacent]addObject:vertb];
    [[vertb adjacent]addObject:verta];
}

-(double)distanceBetween:(Vertex*)verta and:(Vertex*)vertb{
    return sqrt(pow(verta.x-vertb.x,2)+pow(verta.y-vertb.y,2));
}



@end
