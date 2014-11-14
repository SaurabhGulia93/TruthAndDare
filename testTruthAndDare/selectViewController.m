//
//  selectViewController.m
//  testTruthAndDare
//
//  Created by unibera1 on 8/19/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import "selectViewController.h"
#import "playViewController.h"
#import "AppDelegate.h"
#import "TruthAndDare.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>

@interface selectViewController ()<UIActionSheetDelegate>

@end

@implementation selectViewController
{
    UIImage *image;
    UIView *TandDview;
    UIView *doneView;
    UITextView * questionview;
    NSArray *questionArray;
    int TAG;
    int frameWidth;
    int frameHeight;
}
- (id)initWithNibName:(NSString *)nibNameOrNil imageData:(NSData*)imageData bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        image = [UIImage imageWithData:imageData];
        [image retain];
    }
    return self;
}

-(BOOL)prefersStatusBarHidden{

    return YES;
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
    
    [_imageView setImage:image];
    TandDview = [[UIView alloc]initWithFrame:CGRectMake(12*frameWidth/320, 248*frameWidth/320, 300*frameWidth/320, 203*frameHeight/480)];
    [self.view addSubview:TandDview];
    for(int i = 0;i<3;i++)
    {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [TandDview addSubview:button];
//        [button setFrame:CGRectMake((15 *frameWidth/320*(i + 1.7) + 95*i*frameHeight/480), 0, 40*frameWidth/320, 140*frameHeight/480)];
//        [button setTag:i+1];
//        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:@"T" forState:UIControlStateNormal];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [TandDview addSubview:button];
        [button setFrame:CGRectMake((15 *frameWidth/320*(i + 1.7) + 70*i*frameHeight/480), 0, 80*frameWidth/320, 60*frameHeight/480)];
        [button setTag:i+1];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"t%d",i+1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImageView *bacgroundTandDview = [[UIImageView alloc]initWithFrame:CGRectMake(30*frameWidth/320, 65*frameHeight/480, 250*frameWidth/320, 20*frameHeight/480)];
    [bacgroundTandDview setImage:[UIImage imageNamed:@"below.png"]];
    [TandDview addSubview:bacgroundTandDview];
    doneView = [[UIView alloc]initWithFrame:CGRectMake(0*frameWidth/320, 247*frameWidth/320, 320*frameWidth/320, 205*frameHeight/480)];
    [self.view addSubview:doneView];
    [doneView setHidden:YES];
    [self GetEntries];
}

-(void)backButtonPressed{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.photoBackground.frame = CGRectMake(self.photoBackground.frame.origin.x, self.photoBackground.frame.origin.y, self.photoBackground.frame.size.width, self.photoBackground.frame.size.width);
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.width);
    self.imageView.center = self.photoBackground.center;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 5.0*self.view.frame.size.width/320;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(void)buttonClicked:(UIButton *)sender{

    NSArray *name = @[@"skeep.png",@"done.png"];
    TruthAndDare *question;
    UIImageView *backGroundQuestionView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320*frameWidth/320, 100*frameHeight/480)];
    [backGroundQuestionView setImage:[UIImage imageNamed:@"text_box.png"]];
    questionview = [[UITextView alloc]initWithFrame:CGRectMake(10*frameWidth/320,3*frameHeight/480, 300*frameWidth/320, 100*frameHeight/480)];
    [questionview setEditable:NO];
    [questionview setBackgroundColor:[UIColor clearColor]];
//    [questionview setFont:[UIFont boldSystemFontOfSize:18*frameWidth/320]];
    [questionview setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:18*self.view.frame.size.width/320]];
    [questionview setTextAlignment:NSTextAlignmentCenter];
    [questionview setTextColor:[UIColor whiteColor]];
    [doneView addSubview:backGroundQuestionView];
    [doneView  addSubview:questionview];
    
    for(int i=0;i<2;i++)
    {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        [doneView addSubview:button];
        [button setFrame:CGRectMake(((i*80)+ 80)*frameWidth/320 , 120*frameHeight/480, 75*frameWidth/320, 50*frameHeight/480)];
        [button setImage:[UIImage imageNamed:[name objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(skipDone:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
    }
    UIImageView *bacgroundDoneView = [[UIImageView alloc]initWithFrame:CGRectMake(60*frameWidth/320, 180*frameHeight/480, 195*frameWidth/320, 10*frameHeight/480)];
    [bacgroundDoneView setImage:[UIImage imageNamed:@"below.png"]];
    [doneView addSubview:bacgroundDoneView];

    [questionview setHidden:NO];
    UIButton *share     = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *shareImage = [UIImage imageNamed:@"share.png"]  ;
    [share setBackgroundImage:shareImage forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareResult) forControlEvents:UIControlEventTouchUpInside];
    share.frame = CGRectMake(0, 0, 30*frameHeight/480, 25*frameHeight/480);
    UIBarButtonItem *shareButton = [[[UIBarButtonItem alloc]initWithCustomView:share]autorelease];
    
    self.navigationItem.rightBarButtonItem = shareButton;
    switch (sender.tag) {
        case 1:
            TAG = sender.tag;
            [self animate];
            question = (TruthAndDare *)[questionArray objectAtIndex:arc4random_uniform(questionArray.count)];
            //NSLog(@"Category = %@ , sno = %@",question.category ,question.sno);
            [questionview setText:question.truth];
            break;
        case 2:
            TAG = sender.tag;
            [self animate];
            //NSLog(@"count = %d random = %d",questionArray.count,arc4random_uniform(questionArray.count));
            question = (TruthAndDare *)[questionArray objectAtIndex:arc4random_uniform(questionArray.count)];
            [questionview setText:question.dare];
            break;
        case 3:
            TAG = sender.tag;
            [self animate];
            question = (TruthAndDare *)[questionArray objectAtIndex:arc4random_uniform(questionArray.count)];
            [questionview setText:question.both];
            break;
        default:
            break;
    }
}

-(void)animate{

    [UIView animateWithDuration:0.5 animations:^{
        
        TandDview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
        
    } completion:^(BOOL finished){
        
        doneView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);
        [doneView setHidden:NO];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        doneView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        [UIView commitAnimations];
    
    }];
}

-(void)GetEntries
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [defaults objectForKey:@"category"];
    //NSLog(@"Category = %@",str);
    NSManagedObjectContext *context = [AppDelegate getcontext];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    req.entity = [NSEntityDescription entityForName:@"TruthAndDare" inManagedObjectContext:context];
    [req setPredicate: [NSPredicate predicateWithFormat:@"category = %@",str]];

    NSError *err = nil;
    questionArray= [context executeFetchRequest:req error:&err];
    
    if (err) {
        
        //NSLog(@"error occured : %@", err.description);
    }
    //NSLog(@"question array count = %d",questionArray.count);
    [questionArray retain];
    [req release];
    
}

-(void)skipDone:(UIButton *)sender{

    if(sender.tag)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        TruthAndDare *question;
        switch (TAG) {
            case 1:
                //NSLog(@"count = %d random = %d",questionArray.count,arc4random_uniform(questionArray.count));
                question = (TruthAndDare *)[questionArray objectAtIndex:arc4random_uniform(questionArray.count)];
                [questionview setText:question.truth];
                break;
            case 2:
                //NSLog(@"count = %d random = %d",questionArray.count,arc4random_uniform(questionArray.count));
                question = (TruthAndDare *)[questionArray objectAtIndex:arc4random_uniform(questionArray.count)];
                [questionview setText:question.dare];
            default:
                //NSLog(@"count = %d random = %d",questionArray.count,arc4random_uniform(questionArray.count));
                question = (TruthAndDare *)[questionArray objectAtIndex:arc4random_uniform(questionArray.count)];
                [questionview setText:question.both];
                break;
        }
    }

}

-(void)shareResult{

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Facebook" otherButtonTitles:@"Twitter",nil];
    [actionSheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];

    switch (buttonIndex) {
        case 0:
            
            [controller setInitialText:@"Playing Truth & Dare"];
            [controller addURL:[NSURL URLWithString:@"http://www.uniberasoftwaresolutions.com"]];
            [controller addImage:img];
            [self presentViewController:controller animated:YES completion:Nil];
            break;
        case 1:
            [twitterController setInitialText:@"Playing Truth & Dare"];
            [twitterController addURL:[NSURL URLWithString:@"http://www.uniberasoftwaresolutions.com"]];
            [twitterController addImage:img];
            [self presentViewController:twitterController animated:YES completion:Nil];
            break;
        default:
            break;
    }
    
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
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_imageView release];
    [questionArray release];
    [questionview release];
    [TandDview release];
    [doneView release];
    [_photoBackground release];
    [super dealloc];
}
@end
