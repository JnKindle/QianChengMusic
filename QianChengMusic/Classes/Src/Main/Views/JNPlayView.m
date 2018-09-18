//
//  JNPlayView.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/13.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNPlayView.h"

#import "JNLyricsModel.h"

@interface JNPlayView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UILabel *curTimeLabel;
@property (nonatomic, weak) UILabel *totalTimeLabel;
@property (nonatomic, weak) UISlider *progressSlider;

@property (nonatomic, weak) JNBaseTableView *tableView;

@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIButton *lastButton;
@property (nonatomic, weak) UIButton *playButton;
@property (nonatomic, weak) UIButton *nextButton;

@property (nonatomic, strong) JNLyricsModel *lyricsModel;

@end

@implementation JNPlayView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self parsonLyrics];
    }
    return self;
}


-(UIView *)topView
{
    if (!_topView) {
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor grayColor];
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
                                                         font:[UIFont systemFontOfSize:15]
                                                textAlignment:NSTextAlignmentCenter];
        [self.topView addSubview:curTimeLabel];
        _curTimeLabel = curTimeLabel;
    }
    return _curTimeLabel;
}

-(UISlider *)progressSlider
{
    if (!_progressSlider) {
        UISlider *progressSlider = [[UISlider alloc] init];
        progressSlider.minimumValue = 0;
        progressSlider.maximumValue = 1;
        progressSlider.value = 0.0;
        progressSlider.minimumTrackTintColor = [UIColor redColor];
        progressSlider.maximumTrackTintColor = [UIColor whiteColor];
        progressSlider.continuous = YES;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
        [progressSlider addTarget:self action:@selector(progressSliderChange:) forControlEvents:UIControlEventValueChanged];
        [self.topView addSubview:progressSlider];
        _progressSlider = progressSlider;
    }
    return _progressSlider;
}

-(UILabel *)totalTimeLabel
{
    if (!_totalTimeLabel) {
        UILabel *totalTimeLabel = [UILabel commonLabelWithFrame:CGRectZero
                                                           text:@"00:00"
                                                      textColor:[UIColor whiteColor]
                                                           font:[UIFont systemFontOfSize:15]
                                                  textAlignment:NSTextAlignmentCenter];
        [self.topView addSubview:totalTimeLabel];
        _totalTimeLabel = totalTimeLabel;
    }
    return _totalTimeLabel;
}

- (JNBaseTableView *)tableView
{
    if (!_tableView) {
        JNBaseTableView *tableView = [JNBaseTableView groupTableView];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        //注册header footer
        [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
        _tableView = tableView;
    }
    return _tableView;
}


-(UIView *)bottomView
{
    if (!_bottomView) {
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}

-(JNLyricsModel *)lyricsModel
{
    if (!_lyricsModel) {
        _lyricsModel = [[JNLyricsModel alloc] init];
    }
    return _lyricsModel;
}

- (void)parsonLyrics
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //歌词解析
        NSString *mp3Str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"情非得已" ofType:@"lrc"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *songArr = [mp3Str componentsSeparatedByString:@"["];
        //songArr [0]为空  [2]才是标题 [3..]歌词和时间
        //标题解析  ti:天籁童声-情非得已]\r\n
        NSString *title = [songArr[2] substringWithRange:NSMakeRange(3, [songArr[2] length]-6)];
        self.lyricsModel.title = title;
        //歌词时间解析
        for (int i = 3; i < songArr.count; i++) {
            // 00:12.97]难以忘记初次见你
            NSArray *sepArr = [songArr[i] componentsSeparatedByString:@"]"];
            // 02:12.97 -> 60*2+12.97
            NSArray * timeArr = [sepArr[0] componentsSeparatedByString:@":"];
            NSString *time = [NSString stringWithFormat:@"%.2f",[timeArr[0] floatValue]*60 + [timeArr[1] floatValue]];
            [self.lyricsModel.timeArr addObject:time];
            [self.lyricsModel.wordsArr addObject:sepArr[1]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    view.contentView.backgroundColor = [UIColor whiteColor];
    
    for (UIView *subViews in view.contentView.subviews) {
        if (subViews) {
            [subViews removeFromSuperview];
        }
    }
    
    return view;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    view.contentView.backgroundColor = [UIColor whiteColor];
    
    for (UIView *subViews in view.contentView.subviews) {
        if (subViews) {
            [subViews removeFromSuperview];
        }
    }
    
    return view;
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lyricsModel.wordsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNBaseTableViewCell *cell = [JNBaseTableViewCell cellWithTableView:tableView style:UITableViewCellStyleDefault Identifier:NSStringFromClass([JNBaseTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.text = self.lyricsModel.wordsArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Action

- (void)progressSliderChange:(id)sender
{
    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider *slider = sender;
        CGFloat value = slider.value;
        NSLog(@"%.2f",value);
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(JN_StatusBarH+44);
    }];
    [self.curTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView).offset(JN_StatusBarH);
        make.left.mas_equalTo(self.topView).offset(12);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(60);
    }];
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView).offset(JN_StatusBarH);
        make.right.mas_equalTo(self.topView).offset(-12);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(60);
    }];
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView).offset(JN_StatusBarH);
        make.left.mas_equalTo(self.curTimeLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.totalTimeLabel.mas_left).offset(-10);
        make.height.mas_equalTo(44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(80);
    }];
    
    
}

@end
