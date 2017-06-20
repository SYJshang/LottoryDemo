//
//  SYJMoreCaiZhongController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/7.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJMoreCaiZhongController.h"
#import "SYJCollectionFlowLayout.h"
#import "SYJLotteryCollectionCell.h"
#import "SYJLotteryModel.h"
#import "SYJIntroduceVC.h"

#define Kwidths  ([UIScreen mainScreen].bounds.size.width / 4)


@interface SYJMoreCaiZhongController ()<UICollectionViewDelegate,UICollectionViewDataSource,SYJCollectionFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listImgArr;


@end

@implementation SYJMoreCaiZhongController

- (NSMutableArray *)listImgArr{
    
    if (_listImgArr == nil) {
        _listImgArr = [NSMutableArray arrayWithObjects:@"竞彩系列",@"11选5系列",@"双色球",@"超级大乐透",@"竞彩足球",@"福彩3D",@"胜负彩",@"任选九",@"排列三",@"快乐11选5",@"新快三",@"11选5",@"一场决胜",@"江西11选5",@"激情11选5",@"进球彩",@"排列五",@"半全场",@"竞彩篮球",@"北京单场",@"胜负过关",@"资讯",@"新11选5",@"2选1",@"七星彩",@"七乐彩",@"快乐扑克",@"幸运赛车",@"快三",@"老快三",@"快三系列",@"时时彩",@"竞彩系列",@"11选5系列",@"双色球",@"超级大乐透",@"",@"",@"",@"",@"",nil];
    }
    
    return _listImgArr;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    
    self.navBarTintColor = [UIColor redColor];
    self.navTintColor = [UIColor whiteColor];
    
}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBarTintColor = [UIColor redColor];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"更多彩种" font:18.0];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    //创建瀑布流布局
    SYJCollectionFlowLayout *layout = [[SYJCollectionFlowLayout alloc]init];
    layout.delegate = self;
    
    //创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[SYJLotteryCollectionCell class] forCellWithReuseIdentifier:@"cell"];

    // Do any additional setup after loading the view.
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArr.count;
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
    
    if(!NULLArray(self.listArr)) {
            NSString *str = mdoel.lotName;
            cell.lotteryName.text = str;
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
    
    
    
    SYJIntroduceVC *vc = [[SYJIntroduceVC alloc]init];
    vc.type = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Kwidths, Kwidths);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
