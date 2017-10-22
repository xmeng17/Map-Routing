//
//  ViewController.h
//  MapRouting
//
//  Created by xmeng17 on 1/22/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "GameScene.h"

@interface ViewController : NSViewController


@property GameScene *scene;
@property NSMutableArray* drawings;

@property (assign) IBOutlet SKView *skView;
@property (weak) IBOutlet NSComboBox *FromCity;
@property (weak) IBOutlet NSComboBox *ToCity;
@property (unsafe_unretained) IBOutlet NSTextView *Result;


- (IBAction)GetRoute:(NSButton *)sender;


@end

