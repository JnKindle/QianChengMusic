//
//  JNBaseTableViewCell.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNBaseTableViewCell.h"

@implementation JNBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildView];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setUpAllChildView];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style Identifier:(NSString *)Identifier{
    id cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:Identifier];
    }
    return cell;
}

- (void)setUpAllChildView
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
