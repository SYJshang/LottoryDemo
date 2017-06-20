
//
//  SYJBanQuanChangCell.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJBanQuanChangCell.h"

@implementation SYJBanQuanChangCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.icon = [[UIImageView alloc]init];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView, 5).centerYEqualToView(self.contentView).heightIs(50).widthIs(50);
        
        self.lotteryName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lotteryName];
        self.lotteryName.textColor = [UIColor blackColor];
        self.lotteryName.font = [UIFont boldSystemFontOfSize:15.0];
        self.lotteryName.textAlignment = NSTextAlignmentLeft;
        self.lotteryName.sd_layout.leftSpaceToView(self.icon, 5).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(100);
        
        self.numberLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.numberLab];
        self.numberLab.textColor = [UIColor grayColor];
        self.numberLab.font = [UIFont systemFontOfSize:13.0];
        self.numberLab.textAlignment = NSTextAlignmentCenter;
        self.numberLab.sd_layout.leftSpaceToView(self.lotteryName, -10).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(100);
        
        self.timeLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLab];
        self.timeLab.textColor = [UIColor grayColor];
        self.timeLab.font = [UIFont systemFontOfSize:13.0];
        self.timeLab.textAlignment = NSTextAlignmentRight;
        self.timeLab.sd_layout.rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(150);
        
        self.numLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.numLab];
        self.numLab.textColor = [UIColor redColor];
        self.numLab.backgroundColor = Gray;
        self.numLab.font = [UIFont systemFontOfSize:13.0];
        self.numLab.textAlignment = NSTextAlignmentCenter;
        self.numLab.sd_layout.leftSpaceToView(self.icon, 10).topSpaceToView(self.lotteryName, 10).rightSpaceToView(self.contentView, 10).heightIs(20);
        
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = Gray;
        line.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 1).heightIs(1);
        
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
