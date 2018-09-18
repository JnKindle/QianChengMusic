//
//  JNBaseTableView.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNBaseTableView.h"

@implementation JNBaseTableView




+ (instancetype)tableView
{
    UITableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStylePlain];
    [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = view;
    
    _tableView.sectionHeaderHeight = 0.f;
    _tableView.sectionFooterHeight = 0.f;
    
    //去掉横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //关闭自动估算高度(iOS11默认开启)
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    return _tableView;
}



+ (instancetype)groupTableView
{
    UITableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStyleGrouped];
    
    [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    //去掉横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.sectionHeaderHeight = 0.f;
    _tableView.sectionFooterHeight = 0.f;
    
    //关闭自动估算高度(iOS11默认开启)
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    return _tableView;
}

/*
+ (instancetype)tpTableView
{
    TPKeyboardAvoidingTableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStylePlain];
    [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = view;
    
    _tableView.sectionHeaderHeight = 0.f;
    _tableView.sectionFooterHeight = 0.f;
    
    //去掉横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //关闭自动估算高度(iOS11默认开启)
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    
    return _tableView;
}

+ (instancetype)tpGroupTableView
{
    TPKeyboardAvoidingTableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStyleGrouped];
    
    [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    //去掉横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.sectionHeaderHeight = 0.f;
    _tableView.sectionFooterHeight = 0.f;
    
    //关闭自动估算高度(iOS11默认开启)
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    return _tableView;
}
 */

- (void)scrollToBottom
{
    NSInteger sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    NSInteger lastSectionRowCount = [self.dataSource tableView:self numberOfRowsInSection:sectionCount-1];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastSectionRowCount-1 inSection:sectionCount-1];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
