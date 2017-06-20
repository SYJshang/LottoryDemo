
//
//  SYJLotteryCollectionCell.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJLotteryCollectionCell.h"

@implementation SYJLotteryCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图片占位or加载"]];
        [self.contentView addSubview:self.img];
        self.img.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).bottomSpaceToView(self.contentView, 35);
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        
        self.lotteryName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lotteryName];
        self.lotteryName.textAlignment = NSTextAlignmentCenter;
        self.lotteryName.font = [UIFont boldSystemFontOfSize:13.0];
        self.lotteryName.textColor = [UIColor blackColor];
        self.lotteryName.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).heightIs(20).bottomSpaceToView(self.contentView,5);
        
        self.isNoLottery = [[UILabel alloc]init];
        [self.contentView addSubview:self.isNoLottery];
        self.isNoLottery.textAlignment = NSTextAlignmentCenter;
        self.isNoLottery.font = [UIFont boldSystemFontOfSize:8];
        self.isNoLottery.textColor = [UIColor whiteColor];
        self.isNoLottery.backgroundColor = [UIColor redColor];
        self.isNoLottery.sd_layout.rightSpaceToView(self.contentView,3).topSpaceToView(self.contentView, 0).heightIs(15).widthIs(40);
        self.isNoLottery.layer.masksToBounds = YES;
        self.isNoLottery.layer.cornerRadius = 8;
        self.isNoLottery.layer.borderWidth = .5;
        self.isNoLottery.layer.borderColor = Gray.CGColor;
        
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0;
        self.layer.borderColor = Gray.CGColor;
        self.layer.borderWidth = 0.5;
        
    }
    
    return self;
    
}

@end
