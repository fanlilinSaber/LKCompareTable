//
//  AppDelegate.m
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/11/8.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 全局设置
#pragma mark - 1.NavigationBar appearance
    [UINavigationBar appearance].tintColor = UIColor.blackColor;
    [UINavigationBar appearance].translucent = NO;
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = UINavigationBarAppearance.new;
        appearance.shadowColor = UIColor.clearColor;
        appearance.shadowImage = UIImage.new;
        appearance.backgroundImage = UIImage.new;
        appearance.backgroundColor = UIColor.whiteColor;
        appearance.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName:UIColor.blackColor};
        [UINavigationBar appearance].standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            [UINavigationBar appearance].scrollEdgeAppearance = appearance;
        }
    }else {
        [UINavigationBar appearance].shadowImage = UIImage.new;
        [UINavigationBar appearance].backgroundColor = UIColor.whiteColor;
        [UINavigationBar appearance].barTintColor = UIColor.whiteColor;
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
