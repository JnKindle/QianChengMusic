//
//  UIWindow+Addtion.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "UIWindow+Addtion.h"

@implementation UIWindow (Addtion)

- (UIViewController*)currentController
{
    UIViewController *vc = nil;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]){
        
        vc = [(UINavigationController *)window.rootViewController visibleViewController];
        
    }else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabVC = (UITabBarController*)window.rootViewController;
        vc = [(UINavigationController *)[tabVC selectedViewController] visibleViewController];
        
    }else {
        
        vc = window.rootViewController;
    }
    return vc;
}

- (CGFloat)statusBarHeight
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

@end
