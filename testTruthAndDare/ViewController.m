//
//  ViewController.m
//  testTruthAndDare
//
//  Created by unibera1 on 8/14/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    int frameWidth;
    int frameHeight;
    BOOL infoFlag;
    int originOfInfoView;
    BOOL soundFlag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    infoFlag = YES;
    soundFlag = YES;
    [self soundOnOff];
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    frameWidth = [UIScreen mainScreen].bounds.size.width;
    frameHeight = [UIScreen mainScreen].bounds.size.height;
    UIImage *header = [UIImage imageNamed:@"hader.png"];
    UIImage *barDefault;
    CGFloat navH;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
         navH=self.navigationController.navigationBar.frame.size.height*(frameHeight/480);
        barDefault = [UIImage imageWithCGImage:header.CGImage scale:header.size.width/navH orientation:header.imageOrientation];
    }
    else{
    
        navH=self.navigationController.navigationBar.frame.size.width*(frameWidth/320);
        barDefault = [UIImage imageWithCGImage:header.CGImage scale:header.size.width/navH orientation:header.imageOrientation];
    }
       [self.navigationController.navigationBar setBackgroundImage:barDefault forBarMetrics:UIBarMetricsDefault];
    UIView *titleImageView  = [[UIView alloc]initWithFrame:CGRectMake(0*frameWidth/320, 2*frameHeight/480, 350*frameWidth/320, 40*frameHeight/480)];
    UIImageView *backgroundTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 310*frameWidth/320, 40*frameHeight/480)];
    [backgroundTitleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    [titleImageView addSubview:backgroundTitleImageView];
    self.navigationItem.titleView = titleImageView;
}


-(BOOL)prefersStatusBarHidden{

    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    if(infoFlag)
    {
        originOfInfoView = self.openInfoView.frame.origin.x;
        infoFlag = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_openInfoOutlet release];
    [_infoImageView release];
    [_openInfoView release];
    [super dealloc];
}

- (IBAction)openInfo:(UIButton *)sender {
    
    UIView *view = [sender superview];
    [UIView animateWithDuration:0.5 animations:^{
        if (sender.tag == 0) {
            [view setFrame:CGRectMake(0, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            sender.tag = 1;
            sender.transform = CGAffineTransformConcat(sender.transform,CGAffineTransformMakeRotation(M_PI));
        } else {
            [view setFrame:CGRectMake(originOfInfoView, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            sender.tag = 0;
            sender.transform = CGAffineTransformConcat(sender.transform,CGAffineTransformMakeRotation(M_PI));
        }
    }];
}

- (IBAction)storeConnect:(UIButton *)sender {
    
    [PromotionUtils openStorePage];
}

- (IBAction)all:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"ALL" forKey:@"category"];
    [defaults synchronize];
    choosePlayerViewController *choose = [[[choosePlayerViewController alloc]initWithNibName:@"choosePlayerViewController" bundle:nil]autorelease];
    [UIView transitionFromView:self.view toView:choose.view duration:0.4 options:UIViewAnimationOptionTransitionCurlUp completion:nil];
    [self.navigationController pushViewController:choose animated:NO];
}

- (IBAction)teen:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"TEEN" forKey:@"category"];
    [defaults synchronize];
    choosePlayerViewController *choose = [[[choosePlayerViewController alloc]initWithNibName:@"choosePlayerViewController" bundle:nil]autorelease];
    [UIView transitionFromView:self.view toView:choose.view duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];

    [self.navigationController pushViewController:choose animated:NO];
}

- (IBAction)adults:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"ABOVE_18+" forKey:@"category"];
    [defaults synchronize];
    choosePlayerViewController *choose = [[[choosePlayerViewController alloc]initWithNibName:@"choosePlayerViewController" bundle:nil]autorelease];
    [UIView transitionFromView:self.view toView:choose.view duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];

    [self.navigationController pushViewController:choose animated:NO];
}

-(void)soundOnOff{
    
    NSUserDefaults *sound = [NSUserDefaults standardUserDefaults];
    [sound setBool:soundFlag forKey:@"sound"];
    [sound synchronize];
}

- (IBAction)marketTool:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            [PromotionUtils rateApp];
            break;
        case 1:
            [PromotionUtils openLinkInBrowser:FB_LINK];
            break;
        case 2:
            [PromotionUtils openLinkInBrowser:TWITTER_LINK];
            break;
        case 3:
            if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [PromotionUtils tellAFriendWithMessage:@"Hi, \nI am playing Fun Game \"Truth & Dare\". I think you should try it. It's amazing. You definitely love it. https://itunes.apple.com/us/app/truth-or-dare-spin-the-bottle/id724406705" fromRect:sender.frame inView:sender];
            }
            else
                [PromotionUtils tellAFriendWithMessage:@"Hi, \nI am playing Fun Game \"Truth & Dare\". I think you should try it. It's amazing. You definitely love it. https://itunes.apple.com/us/app/truth-or-dare-spin-the-bottle/id724406705 " fromController:self];
            break;
        case 4:
            [PromotionUtils takeFeedbackFromController:self subject:@"Did you like this app?" body:@"I am loving it..!!"];
            break;
        case 5:
            [PromotionUtils aboutUS];
            break;
        default:
            break;
    }

}
- (IBAction)soundOnOffButton:(UIButton *)sender {
    
    NSUserDefaults *sound = [NSUserDefaults standardUserDefaults];
    if([sound boolForKey:@"sound"])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"sound_2.png"] forState:UIControlStateNormal];
        soundFlag = NO;
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"sound_1.png"] forState:UIControlStateNormal];
        soundFlag = YES;
    }
    [self soundOnOff];

}
@end
