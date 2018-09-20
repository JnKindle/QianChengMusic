//
//  JNPlayView.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/13.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNPlayView.h"
#import <AVFoundation/AVFoundation.h>

#import "JNLyricsModel.h"

@interface JNPlayView ()<AVAudioPlayerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,assign) NSInteger row;


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
        self.timer.fireDate = [NSDate distantPast];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //对UItableView背景设置毛玻璃效果
            UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
            UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            effectView.frame = self.tableView.bounds;
            [imageView addSubview:effectView];
            self.tableView.backgroundView = imageView;
        });
        
        
        
    }
    return self;
}

- (AVAudioPlayer *)player
{
    if (!_player) {
        NSError *error = nil;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.url error:&error];
        _player.delegate = self;
        _player.numberOfLoops = 999;//单曲循环
        _player.volume = 1.0;
        [_player prepareToPlay]; //预播放 先读取一段音频 防止开始卡顿
        if (error) {
            JNLog(@"创建播放器失败");
            return nil;
        }
    }
    return _player;
}

- (NSURL *)url
{
    if (_url == nil) {
        _url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"情非得已" ofType:@"mp3"]];
    }
    return _url;
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(change) userInfo:nil repeats:YES];
    }
    return _timer;
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
        tableView.backgroundColor = [UIColor whiteColor];
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
        bottomView.backgroundColor = RGB_COLOR(66, 112, 238);
        [self addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}

-(UIButton *)lastButton
{
    if (!_lastButton) {
        UIButton *lastButton = [UIButton commonButtonWithControl:self
                                                          action:@selector(lastSong:)
                                                           frame:CGRectZero
                                                           title:@"上一曲"
                                                 higlightedTitle:@"上一曲"
                                                      titleColor:[UIColor whiteColor]
                                            higlightedTitleColor:[UIColor redColor]
                                                            font:[UIFont boldSystemFontOfSize:18*JN_FIT_WIDTH]
                                                   textAlignment:NSTextAlignmentRight];
        [self.bottomView addSubview:lastButton];
        _lastButton = lastButton;
    }
    return _lastButton;
}

-(UIButton *)playButton
{
    if (!_playButton) {
        UIButton *playButton = [UIButton commonButtonWithControl:self
                                                          action:@selector(playSong:)
                                                           frame:CGRectZero
                                                           title:@"播放"
                                                 higlightedTitle:@""
                                                      titleColor:[UIColor whiteColor]
                                            higlightedTitleColor:[UIColor redColor]
                                                            font:[UIFont boldSystemFontOfSize:25*JN_FIT_WIDTH]
                                                   textAlignment:NSTextAlignmentCenter];
        [self.bottomView addSubview:playButton];
        _playButton = playButton;
    }
    return _playButton;
}

-(UIButton *)nextButton
{
    if (!_nextButton) {
        UIButton *nextButton = [UIButton commonButtonWithControl:self
                                                          action:@selector(nextSong:)
                                                           frame:CGRectZero
                                                           title:@"下一曲"
                                                 higlightedTitle:@"下一曲"
                                                      titleColor:[UIColor whiteColor]
                                            higlightedTitleColor:[UIColor redColor]
                                                            font:[UIFont boldSystemFontOfSize:18*JN_FIT_WIDTH]
                                                   textAlignment:NSTextAlignmentLeft];
        
        [self.bottomView addSubview:nextButton];
        _nextButton = nextButton;
    }
    return _nextButton;
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
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = self.lyricsModel.wordsArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.row == indexPath.row) {
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    JNLog(@"一首歌曲播放完毕");
    self.player = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    JNLog(@"歌曲播放失败");
}

#pragma mark - Action

- (void)progressSliderChange:(UISlider *)sender
{
    self.player.currentTime = sender.value * self.player.duration;
}

- (void)change
{
    // 获取当前播放时间 总时间  刷新进度条
    self.curTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",(NSInteger)self.player.currentTime/60,(NSInteger)self.player.currentTime%60];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",(NSInteger)self.player.duration/60,(NSInteger)self.player.duration%60];
    self.progressSlider.value = self.player.currentTime/self.player.duration;
    
    // 歌词同步
    [self syncWords];
}

- (void)syncWords
{
    for (int i = 0; i < self.lyricsModel.timeArr.count; i++) {
        if (self.player.currentTime < [self.lyricsModel.timeArr[i] floatValue]) {
            // 第一次找到当前播放时间 小于 遍历中的时间数组 i对应的上一行就是应该被标记的行号
            self.row = (i == 0)?0:(i-1);
            break;
        }
    }
    [self.tableView reloadData];
    // 滚动到对应行的歌词
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)lastSong:(UIButton *)sender
{
    
}

- (void)playSong:(UIButton *)sender
{
    if (self.player.isPlaying) {
        [self.player pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [self.player play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

- (void)nextSong:(UIButton *)sender
{
    
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
        make.height.mas_equalTo(80*JN_FIT_WIDTH);
    }];
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(self.bottomView);
        make.right.mas_equalTo(self.playButton.mas_left);
        make.height.mas_equalTo(40*JN_FIT_WIDTH);
    }];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.centerX.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(60*JN_FIT_WIDTH);
        make.height.mas_equalTo(40*JN_FIT_WIDTH);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.right.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(self.playButton.mas_right);
        make.height.mas_equalTo(40*JN_FIT_WIDTH);
    }];
    
    
    
    
}

@end
