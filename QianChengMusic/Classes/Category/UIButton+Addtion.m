//
//  UIButton+Addtion.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/19.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "UIButton+Addtion.h"

@implementation UIButton (Addtion)

+ (UIButton *)commonButtonWithControl:(id)control
                               action:(SEL)action
                                frame:(CGRect)frame
                                title:(NSString *)title
                      higlightedTitle:(NSString *)higlightedTitle
                           titleColor:(UIColor *)titleColor
                 higlightedTitleColor:(UIColor *)higlightedTitleColor
                                 font:(UIFont *)font
                        textAlignment:(NSTextAlignment)textAlignment
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:higlightedTitle forState:UIControlStateHighlighted];
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:higlightedTitleColor forState:UIControlStateHighlighted];
    
    button.titleLabel.font = font;
    button.titleLabel.textAlignment = textAlignment;
    
    [button addTarget:control action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)commonButtonWithControl:(id)control
                               action:(SEL)action
                                frame:(CGRect)frame
                                image:(NSString *)image
                      higlightedImage:(NSString *)higlightedImage
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    
     [button addTarget:control action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
