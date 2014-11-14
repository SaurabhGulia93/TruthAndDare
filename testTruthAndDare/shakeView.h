//
//  shakeView.h
//  testTruthAndDare
//
//  Created by unibera1 on 8/14/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class shakeView;

@protocol shakeviewDelegate <NSObject>

-(void)passAngle:(int)angle;
-(void)disableEnableUserInteraction;

@end

@interface shakeView : UIView

@property (assign, nonatomic) id<shakeviewDelegate> delegate;
@property (assign , nonatomic) int timerStarted;
@property (assign , nonatomic) int diasbleEnable;
@property (assign , nonatomic) int numPlayers;
-(void)fastMotion;
-(void)slowMotion;
-(void)slowestMotion;
-(void)finalMotion;
-(void)bottleTransformation;
-(void)cancelTimer;
@end
