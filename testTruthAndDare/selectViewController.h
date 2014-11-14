//
//  selectViewController.h
//  testTruthAndDare
//
//  Created by unibera1 on 8/19/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *photoBackground;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil imageData:(NSData*)imageData bundle:(NSBundle *)nibBundleOrNil;
-(void)animate;
-(void)GetEntries;
@end
