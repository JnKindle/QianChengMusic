//
//  JNPlayView.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/13.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNPlayView.h"

@interface JNPlayView ()

@property (nonatomic, weak) UILabel *curTimeLabel;
@property (nonatomic, weak) UILabel *totalTimeLabel;
@property (nonatomic, weak) UISlider *progressSlider;

@end

@implementation JNPlayView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
