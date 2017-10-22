//
//  GameScene.h
//  MapRouting
//
//  Created by xmeng17 on 1/22/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Graph.h"
#import "Vertex.h"
#import "Heap.h"

@interface GameScene : SKScene

@property NSMutableDictionary* city;
@property NSMutableArray* majorcity;

@property NSMutableArray* connection1;
@property NSMutableArray* connection2;

@property Graph* graph;
@property Vertex* fromvert;
@property Vertex* tovert;

-(BOOL)dijkstra;
-(NSMutableArray*)drawResult:(SKView*)view;

@end
