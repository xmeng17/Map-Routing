//
//  Heap.h
//  MapRouting
//
//  Created by xmeng17 on 2/5/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Heap : NSObject
@property NSMutableArray* list;

-(instancetype)init;
-(void)insert:(Vertex*)vert;
-(Vertex*)extractMin;
-(void)updateVertex:(Vertex*)vertex;

@end
