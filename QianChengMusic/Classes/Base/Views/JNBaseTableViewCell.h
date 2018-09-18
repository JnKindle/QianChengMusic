//
//  JNBaseTableViewCell.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style Identifier:(NSString *)Identifier;

//设置根视图
- (void)setUpAllChildView;


@end
