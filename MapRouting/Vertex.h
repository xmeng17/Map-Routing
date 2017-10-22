//
//  Vertex.h
//  WordLadder
//
//  Created by xmeng17 on 1/13/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vertex : NSObject

@property NSString* name;
@property double x;
@property double y;
@property NSMutableArray* adjacent;

//for FHeap use only
@property NSMutableArray* child;
@property Vertex* hparent;
@property int degree;
@property BOOL mark;

//for dijkstra only
@property Vertex* parent;
@property double distance;

-(instancetype)initWithValue:(NSString*)name x:(double)x y:(double)y;

@end
