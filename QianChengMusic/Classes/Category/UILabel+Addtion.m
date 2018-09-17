//
//  UILabel+Addtion.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/14.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "UILabel+Addtion.h"

@implementation UILabel (Addtion)


+ (UILabel *)commonLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment

{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = textAlignment;
    return label;
}

@end
