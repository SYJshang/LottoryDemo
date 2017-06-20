//
//  SYJPLThreeCell.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJPLThreeCell.h"

@implementation SYJPLThreeCell

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
        self.lotteryName.sd_layout.leftSpaceToView(self.icon, 5).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(70);
        
        self.numberLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.numberLab];
        self.numberLab.textColor = [UIColor grayColor];
        self.numberLab.font = [UIFont systemFontOfSize:13.0];
        self.numberLab.textAlignment = NSTextAlignmentCenter;
        self.numberLab.sd_layout.leftSpaceToView(self.lotteryName, 5).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(100);
        
        self.timeLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLab];
        self.timeLab.textColor = [UIColor grayColor];
        self.timeLab.font = [UIFont systemFontOfSize:13.0];
        self.timeLab.textAlignment = NSTextAlignmentRight;
        self.timeLab.sd_layout.rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(150);
        
        self.firstNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.firstNum];
        self.firstNum.textColor = [UIColor whiteColor];
        self.firstNum.backgroundColor = [UIColor redColor];
        self.firstNum.font = [UIFont systemFontOfSize:10.0];
        self.firstNum.textAlignment = NSTextAlignmentCenter;
        self.firstNum.sd_layout.leftSpaceToView(self.icon, 10).topSpaceToView(self.lotteryName, 10).heightIs(20).widthIs(20);
        self.firstNum.layer.masksToBounds = YES;
        self.firstNum.layer.cornerRadius = 10;
        self.firstNum.layer.borderColor = Gray.CGColor;
        self.firstNum.layer.borderWidth = 0.5;
        
        self.secondNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.secondNum];
        self.secondNum.textColor = [UIColor whiteColor];
        self.secondNum.backgroundColor = [UIColor redColor];
        self.secondNum.font = [UIFont systemFontOfSize:10.0];
        self.secondNum.textAlignment = NSTextAlignmentCenter;
        self.secondNum.sd_layout.leftSpaceToView(self.firstNum, 5).topSpaceToView(self.lotteryName, 10).heightIs(20).widthIs(20);
        self.secondNum.layer.masksToBounds = YES;
        self.secondNum.layer.cornerRadius = 10;
        self.secondNum.layer.borderColor = Gray.CGColor;
        self.secondNum.layer.borderWidth = 0.5;
        
        self.thirdNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.thirdNum];
        self.thirdNum.textColor = [UIColor whiteColor];
        self.thirdNum.backgroundColor = [UIColor redColor];
        self.thirdNum.font = [UIFont systemFontOfSize:10.0];
        self.thirdNum.textAlignment = NSTextAlignmentCenter;
        self.thirdNum.sd_layout.leftSpaceToView(self.secondNum, 5).topSpaceToView(self.lotteryName, 10).heightIs(20).widthIs(20);
        self.thirdNum.layer.masksToBounds = YES;
        self.thirdNum.layer.cornerRadius = 10;
        self.thirdNum.layer.borderColor = Gray.CGColor;
        self.thirdNum.layer.borderWidth = 0.5;
        
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
