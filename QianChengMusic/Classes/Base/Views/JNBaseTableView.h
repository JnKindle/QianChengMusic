//
//  JNBaseTableView.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNBaseTableView : UITableView

//工厂方法
+ (instancetype)tableView;
+ (instancetype)groupTableView;

+ (instancetype)tpTableView;
+ (instancetype)tpGroupTableView;

//工具方法
- (void)scrollToBottom;

@end
