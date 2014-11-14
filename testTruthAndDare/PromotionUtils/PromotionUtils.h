//
//  PromotionUtils.h
//  Marketiing
//
//  Created by unibera on 9/3/13.
//  Copyright (c) 2013 Unibera Softwares Solution Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FB_LINK @"https://www.facebook.com/pages/Unibera-Software-Solutions-Pvt-Ltd/220694528062857"
#define TWITTER_LINK @"https://www.twitter.com//UniberaSoft"
#define WEBSITE_LINK @"http://www.uniberasoftwaresolutions.com/"
#define ITUNES_VENDOR_LINK @"https://itunes.apple.com/us/artist/unibera-softwares/id625727343"
#define FEEDBACK_ID @"co@unibera.com"
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define TELL_A_FRIEND_MSG @"Hi, \nI am playing a fun Game \"Truth or Dare\". I think you should try it. It's amazing. You definitely love it. https://itunes.apple.com/us/app/truth-or-dare-spin-the-bottle/id724406705"
#define TYPE_SUBSCRIBE_FOR_OFFER 0
#define TYPE_PATCH_CODE 1

@interface PromotionUtils : NSObject

+(void)rateApp;
+(void)aboutUS;
+(void)askForAllFromRect:(CGRect)rect inView:(UIView*)view fromController:(UIViewController*)ctrl;
+(void)openStorePage;
+(void)openLinkInBrowser:(NSString*)link;
+(NSString*)localizedStringWithKey:(NSString*)key;
+(void)tellAFriendWithMessage:(id)message fromController:(UIViewController*)ctrlr;
+(void)tellAFriendWithMessage:(id)message fromRect:(CGRect)rect inView:(UIView*)view;
+(void)takeFeedbackFromController:(UIViewController*)controller subject:(NSString*)sub body:(NSString*)body;
//+(void)askForMailIDWithType:(int)type;

@end
