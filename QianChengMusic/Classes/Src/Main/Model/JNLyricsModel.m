//
//  JNLyricsModel.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNLyricsModel.h"

@implementation JNLyricsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeArr = [NSMutableArray array];
        _wordsArr = [NSMutableArray array];
    }
    return self;
}

@end
