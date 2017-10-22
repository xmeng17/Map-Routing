//
//  cities.m
//  DataProcess
//
//  Created by xmeng17 on 1/24/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import "cities.h"

@implementation Cities

-(instancetype)initWithValue:(NSString*)name state:(NSString*)state county:(NSString*)county x:(double)x y:(double)y ind:(int)ind{
    self=[super init];
    self.name=name;
    self.state=state;
    self.county=county;
    self.x=x;
    self.y=y;
    self.ind=ind;
    return self;
}

@end
