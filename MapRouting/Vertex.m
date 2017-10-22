//
//  Vertex.m
//  WordLadder
//
//  Created by xmeng17 on 1/13/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

-(instancetype)initWithValue:(NSString*)name x:(double)x y:(double)y{
    self=[super init];
    self.name=name;
    self.x=x;
    self.y=y;
    self.adjacent=[[NSMutableArray alloc]init];
    self.degree=0;
    self.hparent=nil;
    self.child=[[NSMutableArray alloc]init];
    self.mark=NO;
    self.parent=nil;
    self.distance=DBL_MAX;
    return self;
}

@end
