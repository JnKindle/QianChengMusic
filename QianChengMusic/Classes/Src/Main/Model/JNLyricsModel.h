//
//  JNLyricsModel.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNLyricsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *timeArr;
@property (nonatomic, strong) NSMutableArray *wordsArr;

@end
