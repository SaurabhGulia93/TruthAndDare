//
//  playViewController.m
//  testTruthAndDare
//
//  Created by unibera1 on 8/17/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import "playViewController.h"
#import "selectViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface playViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,shakeviewDelegate>

@end

@implementation playViewController
{
    int number;
    int TAG;
    NSMutableArray *playersImages;
    int frameWidth;
    int frameHeight;
    NSTimer *shakeTimer;
    UIPopoverController *pop;
    int timerValid;
    int viewWillAppear;
}

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (id)initWithNibName:(NSString *)nibNameOrNil numberofPlayers:(int)players bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        number = players;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil lastPlayedPlayers:(NSMutableDictionary *)players bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        number = [[players objectForKey:@"players"] intValue];
        playersImages = [players objectForKey:@"images"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    frameWidth = [UIScreen mainScreen].bounds.size.width;
    frameHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 2*frameHeight/480, 35*frameWidth/320, 35*frameHeight/480)];
    [button1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = back;
    
    UIView *titleImageView  = [[UIView alloc]initWithFrame:CGRectMake(0*frameWidth/320, 2*frameHeight/480, 210*frameWidth/320, 40*frameHeight/480)];
    UIImageView *backgroundTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 210*frameWidth/320, 40*frameHeight/480)];
    [backgroundTitleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    [titleImageView addSubview:backgroundTitleImageView];
    self.navigationItem.titleView = titleImageView;
    
    s = [[shakeView alloc] initWithFrame:CGRectMake(137*frameWidth/320, 125*frameHeight/480, 50*frameWidth/320, 140*frameHeight/480)];
    s.numPlayers = number;
    s.delegate = self;
    [s setBackgroundColor:self.view.backgroundColor];
    [[self view] addSubview:s];
    [s becomeFirstResponder];

    for(int i=0;i<number;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(134*frameWidth/320, 180*frameHeight/480, 1, 1)];

        [self.view addSubview:button];
        if(playersImages)
        {
            [button setImage:[UIImage imageWithData:[playersImages objectAtIndex:i]] forState:UIControlStateNormal];
        }
        else
        {
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] forState:UIControlStateNormal];
        }   
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.tag = i+1;
        
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.0];
    [self arrangePlayers:number];
    [UIView commitAnimations];
    viewWillAppear = 0;
}

-(BOOL)prefersStatusBarHidden{

    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    
    //NSLog(@"in viewWillAppear");
    [s becomeFirstResponder];
    shakeTimer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(shakeMe) userInfo:nil repeats:YES];
    timerValid = 1;
}

-(void)backButtonPressed{

    //NSLog(@"Above If = %d",s.timerStarted);
    if(timerValid)
    {
        [shakeTimer invalidate];
    }
    if(s.timerStarted)
    {
        [s cancelTimer];
        //NSLog(@"In IF");
    }
    //NSLog(@"below If");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillDisappear:(BOOL)animated {
    
//    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
//        // back button was pressed.  We know this is true because self is no longer
//        // in the navigation stack.
//        
//        //NSLog(@"Above If = %d",s.timerStarted);
//        if(timerValid)
//        {
//            [shakeTimer invalidate];
//        }
//        if(s.timerStarted)
//        {
//            [s cancelTimer];
//            //NSLog(@"In IF");
//        }
//        //NSLog(@"below If");
//
//    }
    [super viewWillDisappear:animated];
}

-(void)arrangePlayers:(int)num{
    
    int width,height;
    float angle;
    int r = 150;
    int j;
    j=0;
    switch (num) {
        case 2:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 55;
            height = 55;
            break;
        case 3:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 50;
            height = 50;
            break;
        case 4:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 40;
            height = 40;
            break;
        case 5:
            width = 40;
            height = 40;
            angle = DEGREES_TO_RADIANS(360/num);
            break;
            
        case 6:
            width = 40;
            height = 40;
            angle = DEGREES_TO_RADIANS(360/num);
            break;
            
        case 7:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 40;
            height = 40;
            r = 130;
            break;
            
        case 8:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 40;
            height = 40;
            r = 130;
            break;
            
        case 9:
            width = 40;
            height = 40;
            r = 130;
            angle = DEGREES_TO_RADIANS(360/num);
            break;
        default:
            break;
    }
    
    if(num <= 3)
    {
        for(UIButton *button in self.view.subviews)
        {
            if(button.tag)
            {
                [button setFrame:CGRectMake(140*frameWidth/320 -width/12 + (r*frameWidth/320 * sin(j *angle)), 180*frameHeight/480 - height/12 - (r*frameHeight/480 * cos(j * angle)), width*frameWidth/320, height*frameWidth/320)];
                //NSLog(@"(r*frameWidth/320 * sin(j *angle)) = %f",(r*frameWidth/320 * sin(j *angle)));
                j++;
                [button setHidden:NO];
                button.layer.cornerRadius = button.frame.size.width/2;
                button.layer.masksToBounds = YES;
                button.layer.borderWidth = 2 * frameWidth/320;
                button.layer.borderColor = [UIColor whiteColor].CGColor;
            }
        }
        
    }
    else
    {
        r = 125;
        for(UIButton *button in self.view.subviews)
        {            
            if(button.tag)
            {

                [button setFrame:CGRectMake(140*frameWidth/320 + (r*frameWidth/320 * sin(j *angle)), 180*frameHeight/480 - (r*frameHeight/480 * cos(j * angle)), width*frameWidth/320, height*frameWidth/320)];
                //NSLog(@"(r*frameWidth/320 * sin(j *angle)) = %f",(r*frameWidth/320 * sin(j *angle)));
            j++;
            [button setHidden:NO];
                button.layer.cornerRadius = button.frame.size.width/2;
                button.layer.masksToBounds = YES;
                button.layer.borderWidth = 2 * frameWidth/320;
                button.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        }
        
    }
}

-(void)buttonClicked:(UIButton *)sender{
    
        //NSLog(@"tag = %d",sender.tag);
        TAG = sender.tag;
        NSString *actionSheetTitle = @" "; //Action Sheet Title
        NSString *destructiveTitle = @"Open Photo library"; //Action Sheet Button Titles
        NSString *other1 = @"Open camera";
        NSString *cancelTitle = @"Cancel";
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveTitle otherButtonTitles:other1,nil];
        [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController *picker;
    switch (buttonIndex) {
        case 0:
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [shakeTimer invalidate];
            if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                pop = [[UIPopoverController alloc]initWithContentViewController:picker];
                pop.delegate = self;
                CGRect popRect;
                for(UIButton* button in self.view.subviews)
                {
                    if(button.tag == TAG)
                    {
                        popRect = button.frame;
                        break;
                    }
                }
                [pop presentPopoverFromRect:popRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            else
                [self presentViewController:picker animated:YES completion:NULL];

            break;
        case 1:
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            [shakeTimer invalidate];
            [self presentViewController:picker animated:YES completion:NULL];
            break;
        default:
            break;
    }
    
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    
    [s becomeFirstResponder];
    shakeTimer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(shakeMe) userInfo:nil repeats:YES];
    timerValid = 1;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    for(UIButton* button in self.view.subviews)
    {
        if(button.tag == TAG)
        {
            [button setImage:chosenImage forState:UIControlStateNormal];
        }
    }
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [s becomeFirstResponder];
        shakeTimer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(shakeMe) userInfo:nil repeats:YES];
        timerValid = 1;
        [pop dismissPopoverAnimated:NO];
        [pop release];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"in dismiss");
        [s becomeFirstResponder];
    }];
    
}


-(void)passAngle:(int)angle{

    NSData *imagedata = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *lastPlayedDic = [[NSMutableDictionary alloc]init];
    for(UIButton *button in self.view.subviews)
    {
        if([button isKindOfClass:[UIButton class]])
        {
            //NSLog(@"%@",button.description);
        
            imagedata = UIImagePNGRepresentation([button imageForState:UIControlStateNormal]);
//            [imagedata retain];
            [imageArray addObject:imagedata];
        }
    }
    
    [lastPlayedDic setObject:imageArray forKey:@"images"];
    [lastPlayedDic setObject:[NSNumber numberWithInt:number] forKey:@"players"];
    [defaults setObject:lastPlayedDic forKey:@"lastPlayedDic"];
    [defaults synchronize];
    int rotateAngle = 360/number;
    //NSLog(@"delegate called");
    int tag;
    
    for(int i = 0;i<number ; i++)
    {
        if((angle>= rotateAngle *i) && angle < rotateAngle * (i+1))
        {
            if(angle>=rotateAngle *i && angle < rotateAngle * i + rotateAngle/2)
            {
                tag= i+1;
            }
            else
            {
                if(i == number-1)
                {
                    tag = 1;
                }
                else
                {
                    tag = i+2;
                }
            }
            break;
        }
        
    }
    
    for(UIButton *button in self.view.subviews)
    {
        if(button.tag == tag)
        {
            //NSLog(@"found");
            imagedata = UIImagePNGRepresentation([button imageForState:UIControlStateNormal]);
            [imagedata retain];
            break;
        }
    }
    viewWillAppear  = 0;
    selectViewController *sv = [[[selectViewController alloc]initWithNibName:@"selectViewController" imageData:imagedata bundle:nil]autorelease];
    [UIView transitionFromView:self.view toView:sv.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    [self.navigationController pushViewController:sv animated:YES];
    [imagedata release];
    [imageArray release];
    [lastPlayedDic release];
}

-(void)shakeMe{

    //NSLog(@"ShakeMe called");
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.02];
    [animation setRepeatCount:4];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([_shakeImageview center].x - 9.0f, [_shakeImageview center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([_shakeImageview center].x + 9.0f, [_shakeImageview center].y)]];
    [_shakeImageview.layer addAnimation:animation forKey:@"positions"];
}

-(void)disableEnableUserInteraction{

    
    if(s.diasbleEnable)
    {
        [shakeTimer invalidate];
        [self.view setUserInteractionEnabled:NO];
        timerValid = 0;
        [_shakeImageview setHidden:YES];
    }
    else
    {
        [self.view setUserInteractionEnabled:YES];
        [_shakeImageview setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_shakeImageview release];
    [super dealloc];
}
@end
