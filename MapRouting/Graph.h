//
//  Graph.h
//  WordLadder
//
//  Created by xmeng17 on 1/13/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Graph : NSObject

@property NSMutableDictionary* vertList;

@property int numVert;

-(instancetype)init;
-(Vertex*)addVertex:(Vertex*)city forKey:(NSString*)key;
-(Vertex*)findVertex:(NSString*)name;
-(void)addEdgeBetween:(Vertex*)verta and:(Vertex*)vertb;
-(double)distanceBetween:(Vertex*)verta and:(Vertex*)vertb;

@end
