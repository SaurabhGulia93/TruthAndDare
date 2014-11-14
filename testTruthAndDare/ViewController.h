//
//  ViewController.h
//  testTruthAndDare
//
//  Created by unibera1 on 8/14/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "choosePlayerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Flurry.h"
#import "PromotionUtils.h"

@interface ViewController : UIViewController
- (IBAction)soundOnOffButton:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *openInfoView;
- (IBAction)marketTool:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIImageView *infoImageView;
@property (retain, nonatomic) IBOutlet UIButton *openInfoOutlet;
- (IBAction)openInfo:(UIButton *)sender;
- (IBAction)storeConnect:(UIButton *)sender;
- (IBAction)all:(UIButton *)sender;
- (IBAction)teen:(UIButton *)sender;
- (IBAction)adults:(UIButton *)sender;
@end
