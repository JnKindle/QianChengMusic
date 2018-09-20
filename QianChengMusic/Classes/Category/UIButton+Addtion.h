//
//  UIButton+Addtion.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/19.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addtion)

+ (UIButton *)commonButtonWithControl:(id)control
                               action:(SEL)action
                                frame:(CGRect)frame
                                title:(NSString *)title
                      higlightedTitle:(NSString *)higlightedTitle
                           titleColor:(UIColor *)titleColor
                 higlightedTitleColor:(UIColor *)higlightedTitleColor
                                 font:(UIFont *)font
                        textAlignment:(NSTextAlignment)textAlignment;

+ (UIButton *)commonButtonWithControl:(id)control
                               action:(SEL)action
                                frame:(CGRect)frame
                                image:(NSString *)image
                      higlightedImage:(NSString *)higlightedImage;

@end
