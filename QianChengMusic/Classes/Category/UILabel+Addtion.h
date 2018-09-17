//
//  UILabel+Addtion.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/14.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addtion)

+ (UILabel *)commonLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment;

@end
