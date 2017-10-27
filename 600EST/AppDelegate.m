//
//  AppDelegate.m
//  600EST
//
//  Created by NguyenThanhLuan on 15/02/2017.
//  Copyright (c) 2017 Olala. All rights reserved.
//

#import "AppDelegate.h"

@import GoogleMobileAds;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-4039533744360639~9786924109"];
    
    UIStoryboard *storyboard;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_ipad" bundle:nil];
    }
    else{
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    
    UIViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"idrootview"];
    self.window.rootViewController = viewcontroller;
    
    //register notification
    UIUserNotificationCategory *notiSetting = [[UIUserNotificationCategory alloc] init];
    NSSet *set = [NSSet setWithObject:notiSetting];
    
    UIUserNotificationSettings *notificationsetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert   categories:set];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationsetting];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    NSString *strBody = @"";
    int index = random() % 3;
    if (index == 0) {
        strBody = @"Have a nice day!\n.Take your time and enjoy the lesson.";
    }
    else if (index == 1){
        strBody = @"Good morning!\nHow are you today?";
    }
    else if (index == 2){
        strBody = @"Hi~\nLet's study together.";
    }
    
    [self createNotificationAt:8 alertBody:strBody];
    
    index = random() % 3;
    if (index == 0) {
        strBody = @"Hey!\nComeback and take the lessons";
    }
    else if (index == 1){
        strBody = @"Excuse Me!\nAre you free now?";
    }
    else if (index == 2){
        strBody = @"Hi~\nMay I help you?.";
    }
    
    index = rand() % 2;
    if (index == 0) {
        [self createNotificationAt:14 alertBody:strBody];
    }
    else{
        [self createNotificationAt:19 alertBody:strBody];
    }

    return YES;
}

-(void)createNotificationAt:(int)hour alertBody:(NSString*)body{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond)
                                               fromDate:[NSDate date]];
    [components setHour: hour];
    [components setMinute: 5];
    [components setSecond: 0];
    
    [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
    NSDate *fireDate = [calendar dateFromComponents:components];
    
    components.day = components.day+1;
    fireDate = [calendar dateFromComponents:components];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = fireDate;
    notification.alertBody = body;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.repeatInterval = NSCalendarUnitDay;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    UIApplicationState appState = [[UIApplication sharedApplication] applicationState];
    
    if (appState == UIApplicationStateActive) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
