//
//  SYJNewsContextCell.h
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYJContextModel.h"

@interface SYJNewsContextCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *textLab;

@property (nonatomic, strong) UILabel *typeNameLab;

@property (nonatomic, strong) SYJContextModel *model;

@end
