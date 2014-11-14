//
//  AppDelegate.m
//  testTruthAndDare
//
//  Created by unibera1 on 8/14/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TruthAndDare.h"
#import <CoreData/CoreData.h>
#import <sqlite3.h>

@implementation AppDelegate

NSUserDefaults *defaults;
static NSManagedObjectContext* context;
#define DATABASE_NAME @"TRUTHDARE"

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = (NSString *)[defaults objectForKey:@"database"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    UINavigationController *nv = [[[UINavigationController alloc]initWithRootViewController:self.viewController]autorelease];
    self.window.rootViewController = nv;
    if(!str)
    {
        //NSLog(@"Fetch Database");
        NSManagedObjectContext *context = [AppDelegate getcontext];
        [AppDelegate populateDrugsInManagedObjectContext:context];
    }
    [self.window makeKeyAndVisible];
    
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"DN3TC95JKY9D39843277"];
    
    // Override point for customization after application launch.
    [Appirater setAppId:@"724406705"];
    [Appirater setDaysUntilPrompt:2];
    [Appirater setUsesUntilPrompt:4];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:1];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
    
    return YES;
}

+(NSManagedObjectContext *)getcontext{
    
    if (context!=nil) {
        return context;
    }
    NSURL *nsurl = [[NSBundle mainBundle] URLForResource:@"truthDare" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:nsurl];
    NSPersistentStoreCoordinator *per = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    [model release];
    NSURL *Sqlite = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"abcd.sqlite"];
    //    NSURL *Sqlite =[[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"sqlite"];
    
    NSError *error = nil;
    if (![per addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:Sqlite options:nil error:&error]) {
        //NSLog(@"Error while adding persistent store: %@", error.description);
        abort();
    }
    
    context = [[NSManagedObjectContext alloc]init];
    [context retain];
    [context setPersistentStoreCoordinator:per];
    [per release];
    
    return context;
}


+ (void) populateDrugsInManagedObjectContext:(NSManagedObjectContext *)context
{
    //NSLog(@"Begin country Fetching from sqlite db");
    
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:DATABASE_NAME ofType:@"sqlite"];
    //NSLog(@"Country_list db file path: %@", dbFilePath);
    
    sqlite3 *database;
    
    if (sqlite3_open([dbFilePath UTF8String], &database) != SQLITE_OK) {
        //NSLog(@"sqlite3_open: failed");
    } else {
        //        //NSLog(@"%@",database);
        NSString *nsquery = [[NSString alloc] initWithFormat:@"SELECT * FROM TRUTHDARE"];
        const char *query = [nsquery UTF8String];
        
        sqlite3_stmt *statement;
        int prepareCode = sqlite3_prepare_v2(database, query, -1, &statement, NULL);
        //                //NSLog(@"%@",statement);
        if(prepareCode == 0) {
            TruthAndDare *truthObject;
            //NSLog(@"About to start adding the data");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                truthObject = [NSEntityDescription insertNewObjectForEntityForName:@"TruthAndDare" inManagedObjectContext:context];
                
                
                truthObject.category = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                truthObject.truth = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                truthObject.dare = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
                truthObject.both = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                truthObject.sno = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 4) encoding:NSUTF8StringEncoding];
                
            }
            NSError *error = nil;
            if (![context save:&error])
                //NSLog(@"error occured while saving: %@",error.description);
            
            sqlite3_finalize(statement);
            //NSLog(@"Added all the sqlite3 Drug data");
        } else {
            //NSLog(@"Prepare code was not right: %d",prepareCode);
        }
        NSError *err;
        NSFileManager *filemgr = [[NSFileManager alloc] init];
        
        
        NSManagedObjectContext *context = [AppDelegate getcontext];
        NSError *error;
        NSFetchRequest *req = [[NSFetchRequest alloc] init];
        req.entity = [NSEntityDescription entityForName:@"TruthAndDare" inManagedObjectContext:context];
        NSArray *arr = [context executeFetchRequest:req error:&error];
        for (TruthAndDare *truth in arr) {
            
            //NSLog(@"%@ %@ \n",truth.category,truth.sno);
        }
        
        [req release];
        [defaults setObject:@"databasePresent" forKey:@"database"];
        [defaults synchronize];
        //NSLog(@"Array count = %d",arr.count);
        [filemgr removeItemAtPath:dbFilePath error:&err];
        //NSLog(@"Deleted sqlite3 database");
        [filemgr release];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
