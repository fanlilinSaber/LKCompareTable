//
//  LKCompareEasy.h
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/11/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LKCompareEasy : NSObject

/// 获取当前栈上显示的ViewController
+ (UIViewController *)currentViewController;

@end


void SetDeviceOrientation(UIDeviceOrientation orientation);
