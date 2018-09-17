//
//  JNPlayView.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/13.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNPlayView.h"

@interface JNPlayView ()

@property (nonatomic, weak) UIView *topView;
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


-(UIView *)topView
{
    if (!_topView) {
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = JN_ViewBackgroundColor;
        [self addSubview:topView];
        _topView = topView;
    }
    return _topView;
}

-(UILabel *)curTimeLabel
{
    if (!_curTimeLabel) {
        UILabel *curTimeLabel = [UILabel commonLabelWithFrame:CGRectZero
                                                         text:@"00:00"
                                                    textColor:[UIColor whiteColor]
                                                         font:[UIFont systemFontOfSize:15*JN_FIT_WIDTH]
                                                textAlignment:NSTextAlignmentCenter];
        [self.topView addSubview:curTimeLabel];
        [curTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        _curTimeLabel = curTimeLabel;
    }
    return _curTimeLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
