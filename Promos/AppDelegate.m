//
//  AppDelegate.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "AppDelegate.h"
#import "ARFConstants.h"
#import "ARFPromosViewController.h"
#import "ARFPromosDetailViewController.h"
#import "ARFCommerceViewController.h"

#import <Parse/Parse.h>
#import "UAirship.h"
#import "UAConfig.h"
#import "UAPush.h"
#import "UALocationService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Urban Airship
    [UAConfig defaultConfig];

    //Se da cuenta si estoy en development o release
    [[UAConfig defaultConfig] setDetectProvisioningMode:YES];

    [[UAConfig defaultConfig] setDevelopmentLogLevel:UALogLevelDebug];
    
    [UAirship takeOff];
    
    [[UAirship push] setUserPushNotificationsEnabled:YES];
    [[UAirship push] setUserNotificationTypes:(UIUserNotificationTypeAlert|
                                              UIUserNotificationTypeBadge|
                                              UIUserNotificationTypeSound)];
    
    NSString *channelID  =[UAirship push].channelID;
    NSString *deviceToken = [UAirship push].deviceToken;
    NSLog(@"My channel is: %@ -- My device token is: %@", channelID, deviceToken);
    
    
    
    [UALocationService setAirshipLocationServiceEnabled:YES];
    UALocationService *locationService = [UAirship shared].locationService;
    [locationService setBackgroundLocationServiceEnabled:NO];
    [locationService startReportingSignificantLocationChanges];
    

    //Parse Registration
    [Parse setApplicationId:kParseApplicationId
                  clientKey:kParseClientKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self configureRootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
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


#pragma mark Push Notifications & Deep Link
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    
    NSMutableArray *schemes = [NSMutableArray array];
    
    NSArray * bundleURLTypes = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleURLTypes"];
    [bundleURLTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [schemes addObjectsFromArray:[bundleURLTypes[idx] objectForKey:@"CFBundleURLSchemes"]];
    }];
    
    if (![schemes containsObject:url.scheme]) {
        return NO;
    }
    
    [self deepLink:url.pathComponents];
    
    return YES;
}

-(void) deepLink:(NSArray *) path{
    
    
    UITabBarController *rootVC = (UITabBarController *) self.window.rootViewController;
    
    [rootVC setSelectedIndex:0];
    
    UINavigationController *navVC = [rootVC.viewControllers firstObject];
    [navVC popToRootViewControllerAnimated:NO];
    
     __weak ARFPromosViewController *promosVC = (ARFPromosViewController *)navVC.topViewController;
    PFQuery *query = [PFQuery queryWithClassName:kPromosClassName];
    [query getObjectInBackgroundWithId:[path lastObject] block:^(PFObject *PF_NULLABLE_S object,  NSError *PF_NULLABLE_S error){
        
        if (!error) {
            ARFPromosDetailViewController *detailVC = [[ARFPromosDetailViewController alloc] initWithPromo:object];
            [promosVC.navigationController pushViewController:detailVC animated:YES];
            
        }
    }];
}


#pragma mark Utils

-(UIViewController *) configureRootViewController{
    
    
    //Promos
    ARFPromosViewController *promoVC = [[ARFPromosViewController alloc] initWithStyle:UITableViewStylePlain];
    [promoVC setTitle:@"Promociones"];
    UINavigationController *promosNavVC = [[UINavigationController alloc] initWithRootViewController:promoVC];
    
    
    //Commerce
    ARFCommerceViewController *commerceVC = [[ARFCommerceViewController alloc] initWithStyle:UITableViewStylePlain];
    [commerceVC setTitle:@"Marcas"];
    UINavigationController *commerceNavVC = [[UINavigationController alloc] initWithRootViewController:commerceVC];
    
    
    
    UITabBarController *tabBC = [[UITabBarController alloc] init];
    [tabBC setViewControllers:@[promosNavVC, commerceNavVC]];
    
    return tabBC;
}


@end
