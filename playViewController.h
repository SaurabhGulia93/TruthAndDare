//
//  playViewController.h
//  testTruthAndDare
//
//  Created by unibera1 on 8/17/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shakeView.h"

@interface playViewController : UIViewController{

    shakeView *s;
}
@property (retain, nonatomic) IBOutlet UIImageView *shakeImageview;
- (id)initWithNibName:(NSString *)nibNameOrNil numberofPlayers:(int)players bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString *)nibNameOrNil lastPlayedPlayers:(NSDictionary *)players bundle:(NSBundle *)nibBundleOrNil;
-(void)arrangePlayers:(int)num;
@end
