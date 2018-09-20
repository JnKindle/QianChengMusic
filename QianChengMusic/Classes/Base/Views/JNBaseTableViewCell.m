//
//  JNBaseTableViewCell.m
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/18.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "JNBaseTableViewCell.h"

@interface JNBaseTableViewCell ()

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

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

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            
            
            
            //这个判断我认为是比较重要的 ，避免你多次添加图片，你不添加这个判断，会发现会添加多次图片
            if (self.backImage == nil) {
                self.backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
                
                //NSLog(@"%@",NSStringFromCGRect(subView.frame));
                self.backImage.frame = CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height);
                
                self.backImage.frame = CGRectMake(0, 0, 134, 44);    //这里我是直接打印出两个按钮的位置来定的位置，实际项目中，更具你按钮的个数进行调整
                [subView addSubview:self.backImage];
                
                UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                // 毛玻璃视图
                self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                //添加到要有毛玻璃特效的控件中
                self.effectView.frame = self.backImage.frame;
                [subView addSubview:self.effectView];
                
                //注意：这里顺序不能反，要先将毛玻璃效果放到最后面，再将图片放在最后面，这样才能确保毛玻璃是在图片上面的
                [subView sendSubviewToBack:self.effectView];
                
                [subView sendSubviewToBack:self.backImage];
                
                break;
            } else {
                
                //NSLog(@"%@",NSStringFromCGRect(subView.frame));
                
                [subView addSubview:self.effectView];
                [subView sendSubviewToBack:self.effectView];
                
                [subView addSubview:self.backImage];
                [subView sendSubviewToBack:self.backImage];
                break;
            }
            
            
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
