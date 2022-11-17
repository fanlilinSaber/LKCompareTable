//
//  LKCompareEasy.m
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/11/17.
//

#import "LKCompareEasy.h"

@implementation LKCompareEasy

+ (UIViewController *)currentViewController
{
    UIViewController *rootViewController = [self window].rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

+ (UIViewController *)currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    } else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}

+ (UIWindow *)window
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window) {
        return window;
    }
    
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }
    
    return window;
}

@end

void SetDeviceOrientation(UIDeviceOrientation orientation)
{
    @try {
        // ios16使用新的api
        if (@available(iOS 16.0, *)) {
            UIInterfaceOrientationMask oriMask = UIInterfaceOrientationMaskPortrait;
            if (orientation != UIDeviceOrientationPortrait && orientation != UIDeviceOrientationUnknown) {
                oriMask = UIInterfaceOrientationMaskLandscapeRight;
            }
            // 防止appDelegate supportedInterfaceOrientationsForWindow方法不调用
            UINavigationController *nav = LKCompareEasy.currentViewController.navigationController;
            SEL selUpdateSupportedMethod = NSSelectorFromString(@"setNeedsUpdateOfSupportedInterfaceOrientations");
            if ([nav respondsToSelector:selUpdateSupportedMethod]) {
                (((void (*)(id, SEL))[nav methodForSelector:selUpdateSupportedMethod])(nav, selUpdateSupportedMethod));
            }
            
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *ws = (UIWindowScene *)array.firstObject;
            Class GeometryPreferences = NSClassFromString(@"UIWindowSceneGeometryPreferencesIOS");
            id geometryPreferences = [[GeometryPreferences alloc] init];
            [geometryPreferences setValue:@(oriMask) forKey:@"interfaceOrientations"];
            SEL selGeometryUpdateMethod = NSSelectorFromString(@"requestGeometryUpdateWithPreferences:errorHandler:");
            void (^ErrorBlock)(NSError *error) = ^(NSError *error){
                  NSLog(@"iOS 16 转屏Error: %@",error);
            };
            if ([ws respondsToSelector:selGeometryUpdateMethod]) {
                (((void (*)(id, SEL,id,id))[ws methodForSelector:selGeometryUpdateMethod])(ws, selGeometryUpdateMethod,geometryPreferences,ErrorBlock));
            }

        } else {
            
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                SEL selector = NSSelectorFromString(@"setOrientation:");

                if ([UIDevice currentDevice].orientation == orientation) {
                    NSInvocation *invocationUnknow = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                    [invocationUnknow setSelector:selector];
                    [invocationUnknow setTarget:[UIDevice currentDevice]];
                    UIDeviceOrientation unKnowVal = UIDeviceOrientationUnknown;
                    [invocationUnknow setArgument:&unKnowVal atIndex:2];
                    [invocationUnknow invoke];
                }
                
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                [invocation setSelector:selector];
                [invocation setTarget:[UIDevice currentDevice]];
                UIDeviceOrientation val = orientation;
                [invocation setArgument:&val atIndex:2];
                [invocation invoke];
            }
        }

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
