//
//  UIColor+Addtion.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/17.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addtion)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+(UIColor *)colorwithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
