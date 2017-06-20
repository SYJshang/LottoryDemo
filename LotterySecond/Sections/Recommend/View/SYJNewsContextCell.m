//
//  SYJNewsContextCell.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJNewsContextCell.h"

@implementation SYJNewsContextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.icon = [[UIImageView alloc]init];
        [self.contentView addSubview:self.icon];
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.sd_layout.leftSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(90).widthIs(100);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 5;
        self.icon.layer.borderColor = Gray.CGColor;
        self.icon.layer.borderWidth = 0.5;
        
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.textColor = [UIColor blackColor];
        self.nameLab.font = [UIFont systemFontOfSize:16.0];
        self.nameLab.sd_layout.leftSpaceToView(self.icon, 5).topEqualToView(self.icon).rightSpaceToView(self.contentView, 30).heightIs(20);
        
        self.typeNameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.typeNameLab];
        self.typeNameLab.textColor = TextColor;
        self.typeNameLab.backgroundColor = [UIColor whiteColor];
        self.typeNameLab.font = [UIFont systemFontOfSize:10.0];
        self.typeNameLab.sd_layout.rightSpaceToView(self.contentView, 5).topEqualToView(self.icon).leftSpaceToView(self.nameLab, -20).heightIs(20);
        self.typeNameLab.textAlignment = NSTextAlignmentCenter;
        self.typeNameLab.layer.masksToBounds = YES;
        self.typeNameLab.layer.cornerRadius = 8;
        self.typeNameLab.layer.borderColor = TextColor.CGColor;
        self.typeNameLab.layer.borderWidth = 1.0;
        
        self.textLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.textLab];
        self.textLab.textColor = [UIColor grayColor];
        self.textLab.font = [UIFont systemFontOfSize:14.0];
        self.textLab.sd_layout.rightSpaceToView(self.contentView, 5).topSpaceToView(self.nameLab, 10).leftSpaceToView(self.icon, 5).bottomSpaceToView(self.contentView, 5);
        self.textLab.numberOfLines = 0;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
    
}

- (void)setModel:(SYJContextModel *)model{
    
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"图片占位or加载"]];
    self.nameLab.text = model.title;
    self.typeNameLab.text = model.typeName;
    self.textLab.text = model.summary;
    
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
