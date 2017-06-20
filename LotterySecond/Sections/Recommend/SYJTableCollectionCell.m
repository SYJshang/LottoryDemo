//
//  SYJTableCollectionCell.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJTableCollectionCell.h"
#import "SYJCollectionFlowLayout.h"
#import "SYJLotteryCollectionCell.h"

#define Kwidths  ([UIScreen mainScreen].bounds.size.width / 4)

@interface SYJTableCollectionCell ()<UICollectionViewDataSource, SYJCollectionFlowLayoutDelegate,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *listImgArr;


@end



@implementation SYJTableCollectionCell

- (NSMutableArray *)listImgArr{
    
    if (_listImgArr == nil) {
        _listImgArr = [NSMutableArray arrayWithObjects:@"竞彩系列",@"11选5系列",@"双色球",@"超级大乐透",@"竞彩足球",@"福彩3D",@"胜负彩",@"任选九",@"排列三",@"快乐11选5",@"新快三",@"11选5",@"一场决胜",@"江西11选5",@"激情11选5",@"更多彩种",nil];
    }
    
    return _listImgArr;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //创建瀑布流布局
        SYJCollectionFlowLayout *layout = [[SYJCollectionFlowLayout alloc]init];
        layout.delegate = self;
        
        //创建CollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSceenW, KSceenW) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView registerClass:[SYJLotteryCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    
    return self;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
    SYJLog(@"%ld",self.listArr.count);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYJLotteryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:self.listImgArr[indexPath.row]];
    SYJLotteryModel *mdoel = [[SYJLotteryModel alloc]init];
    
    if (!NULLArray(self.listArr)) {
        mdoel = self.listArr[indexPath.row];
    }
    
    SYJLog(@"%@",mdoel.lotName);
    if (NULLString(mdoel.remark)) {
        cell.isNoLottery.hidden = YES;
    }else{
        cell.isNoLottery.text = mdoel.remark;
        cell.isNoLottery.hidden = NO;
    }
    
    if (indexPath.row == 15) {
        cell.lotteryName.text = @"更多彩种";
        cell.isNoLottery.hidden = YES;
    }else{
        if (!NULLArray(self.listArr)) {
            NSString *str = mdoel.lotName;
            cell.lotteryName.text = str;
        }

    }
    
    return cell;
}

- (void)setListArr:(NSMutableArray *)listArr{
    
    _listArr = listArr;
    
    [self.collectionView reloadData];
}


#pragma mark - <CYXWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return KSceenW / 4;
}

- (CGFloat)rowMarginInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 0;
}

- (CGFloat)columnCountInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 4;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(0,0,0,0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(index:)]) {
        [self.delegate index:indexPath.row];
    }

    
    
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Kwidths, Kwidths);
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
