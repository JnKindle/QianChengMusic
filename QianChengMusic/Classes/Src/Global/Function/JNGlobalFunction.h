//
//  JNGlobalFunction.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/19.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNGlobalFunction : NSObject

#pragma mark - 圆角边框
/**
 切圆角
 
 @param cornerRadius 圆角半径
 */
+ (void)setRoundWithView:(UIView *)view cornerRadius:(float)cornerRadius;

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
+ (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius;

+ (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius viewRect:(CGRect)rect;

/**
 设置边宽
 
 @param borderWidth 边宽宽度
 @param borderColor 边宽颜色
 */
+ (void)setBorderWithView:(UIView *)view width:(float)borderWidth color:(UIColor *)borderColor;



+(void)setShodawWithView:(UIView *)view color:(UIColor *)color;


+(void)setAutoShodawWithView:(UIView *)view color:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius opacity:(CGFloat)opacity;

#pragma mark - 文字
/**
 获取文字宽度
 
 @param text 文本内容
 @param fontSize 字号大小
 @return return value description
 */
+ (CGFloat)getTextWidth:(NSString *)text fontSize:(CGFloat)fontSize;

/**
 获取文字宽度
 
 @param text 文本内容
 @param font 字号大小
 @return return value description
 */
+ (CGFloat)getTextWidth:(NSString *)text font:(UIFont *)font;


/**
 获取文字高度
 
 @param text 文本内容
 @param fontSize 字号大小
 @param width 宽度
 @return return value description
 */
+ (CGFloat)getTextHeight:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width;

@end
