//
//  ViewController.m
//  MapRouting
//
//  Created by xmeng17 on 1/22/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    self.scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [self.skView presentScene:self.scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    //delete default list of combo box
    [self.FromCity removeAllItems];
    [self.ToCity removeAllItems];
    
    //import city name for city combo box
    NSURL* url3  = [[NSBundle mainBundle] URLForResource:@"name" withExtension:@"csv"];
    NSString *citycontent3 = [NSString stringWithContentsOfFile:[url3 path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *origcity3=(NSMutableArray*)[citycontent3 componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for(int i=0;i<[origcity3 count];i++){
        NSString* citydatastr3=[origcity3 objectAtIndex:i];
        NSMutableArray* citydata3=(NSMutableArray*)[citydatastr3 componentsSeparatedByString:@","];
        [self.FromCity addItemWithObjectValue:[[[citydata3 objectAtIndex:1]stringByAppendingString:@","]stringByAppendingString:[citydata3 objectAtIndex:2] ]];
        [self.ToCity addItemWithObjectValue:[[[citydata3 objectAtIndex:1]stringByAppendingString:@","]stringByAppendingString:[citydata3 objectAtIndex:2] ]];
    }

    //set attributes of city combo box
    [self.FromCity setHasVerticalScroller:YES];
    [self.ToCity setHasVerticalScroller:YES];
    
    [self.FromCity setNumberOfVisibleItems:10];
    [self.ToCity setNumberOfVisibleItems:10];
    
    [self.FromCity setStringValue:@"Boston,MA"];
    [self.FromCity selectItemWithObjectValue:@"Boston,MA"];
    [self.ToCity setStringValue:@"San Francisco,CA"];
    [self.ToCity selectItemWithObjectValue:@"San Francisco,CA"];

    [self.FromCity setCompletes:YES];
    [self.ToCity setCompletes:YES];
    
    
    
}

- (IBAction)GetRoute:(NSButton *)sender {
    for(int i=0;i<[self.drawings count];i++){
        [[self.drawings objectAtIndex:i ] removeFromParent ];
    }
    self.scene.fromvert=[self.scene.graph findVertex:self.FromCity.objectValueOfSelectedItem];
    self.scene.tovert=[self.scene.graph findVertex:self.ToCity.objectValueOfSelectedItem ];
    if(self.scene.fromvert&&self.scene.tovert){
        if([self.scene dijkstra]){
            self.drawings=[self.scene drawResult:self.skView];
            [self.Result setString:@"Here is the route!"];
        }else{
            [self.Result setString:@"Sorry! Currently no routes available."];
        }
    }else{
        [self.Result setString:@"Sorry! City not found."];
    }
    
}
@end
