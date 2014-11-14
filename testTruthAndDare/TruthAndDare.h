//
//  TruthAndDare.h
//  testTruthAndDare
//
//  Created by unibera1 on 8/20/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TruthAndDare : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * dare;
@property (nonatomic, retain) NSString * truth;
@property (nonatomic, retain) NSString * both;
@property (nonatomic, retain) NSString * sno;

@end
