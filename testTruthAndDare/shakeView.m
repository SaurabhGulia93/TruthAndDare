//  shakeView.m
//  testTruthAndDare
//
//  Created by unibera1 on 8/14/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import "shakeView.h"
#import "playViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface shakeView ()

@end
@implementation shakeView
{
    UIButton *button;
    int i;
    int started;
    NSTimer* stopTimer;
    NSTimer *slowTimer;
    NSTimer *slowestTimer;
    NSTimer *finalTimer;
    CABasicAnimation *rotation;
    CABasicAnimation *rotation1;
    UIImageView *bottleView;
    int angle;
    NSTimer *pauseTimer;
//    NSMutableArray *timerArray;
    int flag1;
    AVAudioPlayer *player;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        i=0;
        flag1 = 0;
        started = 0;
        self.timerStarted = 0;
        button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50*[UIScreen mainScreen].bounds.size.width/320, 140*[UIScreen mainScreen].bounds.size.height/480)];
        [self addSubview:button];
        [button setImage:[UIImage imageNamed:@"bottel.png"] forState:UIControlStateNormal];
//        bottleView = [UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 150);
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    
    //NSLog(@"S BecomeFirstResponder");
    return YES;
}


-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{

    int random;
    static int count,prevRandom;
    //NSLog(@"Shake Begin!");
    if(!flag1)
    {

        while (count !=2) {
            
            if(count == 0)
            {
                random = arc4random_uniform(self.numPlayers);
                prevRandom = random;
                count++;
            }
            else
            {
                random = arc4random_uniform(self.numPlayers);
                if(prevRandom == random)
                {
                    continue;
                }
                else
                {
                    count = 0;
                }
            }
            angle = 360/self.numPlayers * random;
            break;
        }
        stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stopRotation) userInfo:nil repeats:YES];
        pauseTimer = stopTimer;
        [self fastMotion];
        self.diasbleEnable = 1;
        self.timerStarted = 1;
        [self.delegate disableEnableUserInteraction];
        [self playSound];
    }
    flag1 = 1;
}

-(void)playSound{
    
    NSURL *fileURL1 = nil;
    NSUserDefaults *sound = [NSUserDefaults standardUserDefaults];
    BOOL soundFlag = [sound boolForKey:@"sound"];
    if(soundFlag)
    {
        NSString *soundFilePath1 = [[NSBundle mainBundle] pathForResource:@"7sec" ofType: @"m4a"];
        fileURL1 = [[NSURL alloc] initFileURLWithPath:soundFilePath1 ];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL1 error:nil];
        [player play];
        
    }
    [fileURL1 release];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    //NSLog(@"Shake End!");
}


-(void)fastMotion{
    
    //NSLog(@"Fast Motion");
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 1; 
    rotation.speed = 2.0f;

    rotation.repeatCount = HUGE_VALF; 
    [button.layer addAnimation:rotation forKey:@"Spin"];

    i++;
}

-(void)slowMotion{

    //NSLog(@"Slow Motion");
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 0.7;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    //NSLog(@"speed = %f",rotation.speed);
    rotation.repeatCount = HUGE_VALF; 
    [button.layer addAnimation:rotation forKey:@"Spin"];
}

-(void)slowestMotion{

    //NSLog(@"slowest motion");
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 1;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    rotation.repeatCount = HUGE_VALF; 
    [button.layer addAnimation:rotation forKey:@"Spin"];
}

-(void)finalMotion{

     //NSLog(@"Final motion");
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 2.5;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    rotation.repeatCount = HUGE_VALF;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    [button.layer addAnimation:rotation forKey:@"Spin"];

}

-(void)bottleTransformation{
    
     //NSLog(@"Trans motion");
    //NSLog(@"Angle = %d",angle);
    //NSLog(@"in Radian  = %f",(DEGREES_TO_RADIANS(angle)));
    rotation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation1.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(angle))];
    rotation1.duration =1.36 * angle/180;
    rotation1.removedOnCompletion = NO;
    rotation1.fillMode = kCAFillModeForwards;
    rotation1.delegate = self;
    [button.layer addAnimation:rotation1 forKey:@"Spin"];

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    self.timerStarted = 0;
    self.diasbleEnable = 0;
    [self.delegate disableEnableUserInteraction];
    sleep(1);
    //NSLog(@"kdjf = %d",angle);
    flag1 = 0;
    [self.delegate passAngle:angle];
}

-(void)stopRotation{

    
//    [button.layer removeAnimationForKey:@"Spin"];
    
    slowTimer = [NSTimer scheduledTimerWithTimeInterval:1.4 target:self selector:@selector(slowTimer) userInfo:nil repeats:YES];
    pauseTimer = slowTimer;
    [self slowMotion];
    [stopTimer invalidate];
}

-(void)slowTimer{

//    [button.layer removeAnimationForKey:@"Spin"];
    slowestTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(slowestTimer) userInfo:nil repeats:YES];
    pauseTimer = slowestTimer;
    [self slowestMotion];
    [slowTimer invalidate];
}

-(void)slowestTimer{
    
//    [button.layer removeAnimationForKey:@"Spin"];
    finalTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(finalTimer) userInfo:nil repeats:YES];
    pauseTimer = finalTimer;
    [self finalMotion];
    [slowestTimer invalidate];
}

-(void)finalTimer{
//    [button.layer removeAnimationForKey:@"Spin"];
    [self bottleTransformation];
    [finalTimer invalidate];

}

-(void)cancelTimer{
    
    //NSLog(@"Cancel Timer Called");
    [pauseTimer invalidate];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
