//
//  MainController.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/13.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "MainController.h"
#import "JNPlayView.h"

@interface MainController ()

@property (nonatomic, weak) JNPlayView *playView;

@end

@implementation MainController


-(JNPlayView *)playView
{
    if (!_playView) {
        JNPlayView *playView = [[JNPlayView alloc] init];
        [self.view addSubview:playView];
        [playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.view);
        }];
        _playView = playView;
    }
    return _playView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self playView];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
