//
//  JNGlobalFunction.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/19.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNGlobalFunction.h"

@implementation JNGlobalFunction


#pragma mark - 圆角边框
/**
 切圆角
 
 @param cornerRadius 圆角半径
 */
+ (void)setRoundWithView:(UIView *)view cornerRadius:(float)cornerRadius
{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

/**
 切部分圆角
 
 UIRectCorner有五种
 UIRectCornerTopLeft //上左
 UIRectCornerTopRight //上右
 UIRectCornerBottomLeft // 下左
 UIRectCornerBottomRight // 下右
 UIRectCornerAllCorners // 全部
 
 @param cornerRadius 圆角半径
 */
+ (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    view.layer.mask = shapeLayer;
}

+ (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius viewRect:(CGRect)rect {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    
    view.layer.mask = shapeLayer;
}

/**
 设置边宽
 
 @param borderWidth 边宽宽度
 @param borderColor 边宽颜色
 */
+ (void)setBorderWithView:(UIView *)view width:(float)borderWidth color:(UIColor *)borderColor
{
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
}

+(void)setShodawWithView:(UIView *)view color:(UIColor *)color
{
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowRadius = 3;
    view.layer.shadowOpacity = 0.3;
}

+(void)setAutoShodawWithView:(UIView *)view color:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius opacity:(CGFloat)opacity
{
    view.layer.shadowOffset = size;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowRadius = radius;
    view.layer.shadowOpacity = opacity;
}

#pragma mark - 文字
/**
 获取文字宽度
 
 @param text 文本内容
 @param fontSize 字号大小
 @return return value description
 */
+ (CGFloat)getTextWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    
    return size.width;
}

/**
 获取文字宽度
 
 @param text 文本内容
 @param font 字号大小
 @return return value description
 */
+ (CGFloat)getTextWidth:(NSString *)text font:(UIFont *)font
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName:font}];
    
    return size.width;
}


/**
 获取文字高度
 
 @param text 文本内容
 @param fontSize 字号大小
 @param width 宽度
 @return return value description
 */
+ (CGFloat)getTextHeight:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width {
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.height;
}

@end
