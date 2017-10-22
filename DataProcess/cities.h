//
//  cities.h
//  DataProcess
//
//  Created by xmeng17 on 1/24/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cities : NSObject

@property NSString* name;
@property NSString* state;
@property NSString* county;
@property int ind;
@property double x;
@property double y;

-(instancetype)initWithValue:(NSString*)name state:(NSString*)state county:(NSString*)county x:(double)x y:(double)y ind:(int)ind;

@end
