//
//  choosePlayerViewController.m
//  testTruthAndDare
//
//  Created by unibera1 on 8/17/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import "choosePlayerViewController.h"
#import "playViewController.h"

@interface choosePlayerViewController ()

@end

@implementation choosePlayerViewController
{
    NSMutableArray *buttonArrary;
    int TAG;
    NSData *imageData;
    int frameWidth;
    int frameHeight;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        UIView *titleImageView  = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 150, 40)];
//        UIImageView *backgroundTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
//        [backgroundTitleImageView setImage:[UIImage imageNamed:@"choose-players.png"]];
//        [titleImageView addSubview:backgroundTitleImageView];
//        self.navigationItem.titleView = titleImageView;
//
//        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 2, 40, 40)];
//        [button1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//        [button1 addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:button1];
//        self.navigationItem.leftBarButtonItem = back;
//        
//        UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 2, 40, 40)];
//        [button2 setImage:[UIImage imageNamed:@"last-played.png"] forState:UIControlStateNormal];
//        [button2 addTarget:self action:@selector(lastPlayedClicked) forControlEvents:UIControlEventTouchUpInside];
////        UIBarButtonItem *lastPlayed = [[UIBarButtonItem alloc]initWithTitle:@"Last Played" style:UIBarButtonItemStylePlain target:self action:@selector(lastPlayedClicked)];
//        UIBarButtonItem *lastPlayed = [[UIBarButtonItem alloc]initWithCustomView:button2];
//        self.navigationItem.rightBarButtonItem = lastPlayed;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //NSLog(@"called");
    frameWidth = [UIScreen mainScreen].bounds.size.width;
    frameHeight = [UIScreen mainScreen].bounds.size.height;
    //NSLog(@"width = %d ,height = %d",frameWidth,frameHeight);
    
    UIView *titleImageView  = [[UIView alloc]initWithFrame:CGRectMake(0, 6*frameHeight/480, 150*frameWidth/320, 40*frameHeight/480)];
    UIImageView *backgroundTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150*frameWidth/320, 40*frameHeight/480)];
    [backgroundTitleImageView setImage:[UIImage imageNamed:@"choose-players.png"]];
    [titleImageView addSubview:backgroundTitleImageView];
    self.navigationItem.titleView = titleImageView;
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 2*frameHeight/480, 35*frameWidth/320, 35*frameHeight/480)];
    [button1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = back;
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(0, -5*frameHeight/480, 37*frameWidth/320, 25*frameHeight/480)];
    [button2 setImage:[UIImage imageNamed:@"last-played.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(lastPlayedClicked) forControlEvents:UIControlEventTouchUpInside];
    //        UIBarButtonItem *lastPlayed = [[UIBarButtonItem alloc]initWithTitle:@"Last Played" style:UIBarButtonItemStylePlain target:self action:@selector(lastPlayedClicked)];
    UIBarButtonItem *lastPlayed = [[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = lastPlayed;
    
//    self.title = @"Choose Players";
    int j=0;
    int r = 130;
    buttonArrary = [[NSMutableArray alloc]init];
    
    for(int k=0;k<8;k++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        if(k==2 || k==6)
        {
            r= 130;
            if(k==2)
            {
                r=127;
                [button setFrame:CGRectMake(r*frameWidth/320 + (r*frameWidth/320 * sin(j * 0.785398163)), 180*frameHeight/480 - (r*frameHeight/480 * cos(j * 0.785398163)), 55*frameWidth/320, 55*frameHeight/480)];
            }
            else{
                
                [button setFrame:CGRectMake(20, 180*frameHeight/480 - (r*frameHeight/480 * cos(j * 0.785398163)), 55*frameWidth/320, 55*frameHeight/480)];
            }
        }
        else
        {
            [button setFrame:CGRectMake( 140*frameWidth/320 + (r*frameWidth/320 * sin(j * 0.785398163)), 180*frameHeight/480 - (r*frameHeight/480 * cos(j * 0.785398163)), 55*frameWidth/320, 55*frameHeight/480)];
        }
        button.tag = k+2;
//        [button setTitle:[NSString stringWithFormat:@"%d",button.tag] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",j+2]] forState:UIControlStateNormal];
        [buttonArrary addObject:button];
        j++;
    }

}

-(void)suck:(int)num{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        for(UIButton * button in buttonArrary)
        {
            [button setFrame:CGRectMake(168*frameWidth/320 , 220*frameHeight/480, 0, 0)];
        }
    
    } completion:^(BOOL finished){
        
        playViewController *play = [[[playViewController alloc]initWithNibName:@"playViewController" numberofPlayers:num bundle:nil]autorelease];
        [UIView transitionFromView:self.view toView:play.view duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
            
        }];
        [self.navigationController pushViewController:play animated:NO];    
    }];
     
}
     


-(void)buttonClicked:(UIButton *)sender{

    //NSLog(@"tag = %d",sender.tag);
    
    [self suck:sender.tag];

}


-(void)lastPlayedClicked{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * dic = [defaults valueForKey:@"lastPlayedDic"];
    if(dic)
    {
        for(UIButton* button in self.view.subviews)
        {
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
            }
        }
        playViewController *play = [[[playViewController alloc]initWithNibName:@"playViewController" lastPlayedPlayers:dic bundle:nil]autorelease];
        [UIView transitionFromView:self.view toView:play.view duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
            
        }];
        [self.navigationController pushViewController:play animated:NO];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Players Last Played" message:@"You are playing it for the first time" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)backButtonPressed{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
        [_bottle release];
    [super dealloc];
}
@end
