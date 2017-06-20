//
//  SYJMainViewController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/5/26.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJMainViewController.h"
#import <SDCycleScrollView.h>
#import "SYJLotteryModel.h"
#import "SYJTableCollectionCell.h"
#import "SYJKaijiangModel.h"
#import "SYJPLThreeCell.h"
#import "SYJPLFiveCell.h"
#import "SYJFuCaiCell.h"
#import "SYJQiLeCaiCell.h"
#import "SYJBanQuanChangCell.h"
#import "SYJDaLeTouCell.h"
#import "SYJShengFuCaiCell.h"
#import "SYJJinQiuCaiCell.h"
#import "SYJShuangSeQiuCell.h"
#import "SYJQiXingCaiCell.h"
#import "SYJKJDTController.h"
#import "SYJContextModel.h"
#import "SYJNewsContextCell.h"
#import "SYJContextWebController.h"
#import "SYJMoreCaiZhongController.h"
#import "SYJIntroduceVC.h"

//#define NSLog(FORMAT, ...) fprintf(stderr,"%s",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@interface SYJMainViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,SYJSelectDelegate>{
   
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *img;
    
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *kaijiangList;

/**
    彩票名称数组
 */
@property (nonatomic, strong) NSMutableArray *lotListArr;

@property (nonatomic, strong) NSMutableArray *contextListArr;

@property (nonatomic, strong) NSMutableArray *lunboArr;





@end

@implementation SYJMainViewController

- (NSMutableArray *)lunboArr{
    
    if (_lunboArr == nil) {
        _lunboArr = [NSMutableArray array];
    }
    
    return _lunboArr;
    
}


- (NSMutableArray *)contextListArr{
    
    if (_contextListArr == nil) {
        _contextListArr = [NSMutableArray array];
    }
    
    return _contextListArr;
    
}

- (NSMutableArray *)kaijiangList{
    
    if (_kaijiangList == nil) {
        _kaijiangList = [NSMutableArray array];
    }
    return _kaijiangList;
}


- (NSMutableArray *)lotListArr{
    
    if (_lotListArr == nil) {
        _lotListArr = [NSMutableArray array];
    }
    return _lotListArr;
}
    


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];


    
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
//    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"Recommend" font:18.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"菜单"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    
    
}

- (void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
    
#pragma mark - scrollView Delegate
    
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    self.navAlpha = y / 200;
    if (y > 200) {
        self.navTintColor = [UIColor whiteColor];
    } else {
        self.navTintColor = y < 0 ? [UIColor clearColor] : [UIColor whiteColor];
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTintColor = [UIColor whiteColor];
    self.navBarTintColor = [UIColor redColor];
    self.navAlpha = 0;

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
    [self setTableViewRegister];
    [self getHttpPic];
    [self getKaiJiangPic];
    
}

- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(5, 5, KSceenW - 10, 190.0)];
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"图片占位or加载"];
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.layer.masksToBounds = YES;
    self.cycleScrollView.layer.borderColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
    self.cycleScrollView.layer.borderWidth = 2;
    self.cycleScrollView.layer.cornerRadius = 5;
    self.tableView.tableHeaderView = self.cycleScrollView;

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHttpPic];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self getHttpPic];
//    }];

}

- (void)setTableViewRegister{
    
    [self.tableView registerClass:[SYJTableCollectionCell class] forCellReuseIdentifier:@"lunboCell"];
    [self.tableView registerClass:[SYJPLThreeCell class] forCellReuseIdentifier:@"pl3"];
    [self.tableView registerClass:[SYJPLFiveCell class] forCellReuseIdentifier:@"pl5"];
    [self.tableView registerClass:[SYJFuCaiCell class] forCellReuseIdentifier:@"fucai"];
    [self.tableView registerClass:[SYJQiLeCaiCell class] forCellReuseIdentifier:@"qile"];
    [self.tableView registerClass:[SYJBanQuanChangCell class] forCellReuseIdentifier:@"banquan"];
    [self.tableView registerClass:[SYJDaLeTouCell class] forCellReuseIdentifier:@"dale"];
    [self.tableView registerClass:[SYJShengFuCaiCell class] forCellReuseIdentifier:@"shengfu"];
    [self.tableView registerClass:[SYJJinQiuCaiCell class] forCellReuseIdentifier:@"jinqiu"];
    [self.tableView registerClass:[SYJShuangSeQiuCell class] forCellReuseIdentifier:@"shuangse"];
    [self.tableView registerClass:[SYJQiXingCaiCell class] forCellReuseIdentifier:@"qixing"];
    [self.tableView registerClass:[SYJNewsContextCell class] forCellReuseIdentifier:@"context"];




}




- (void)getHttpPic{
    
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://mapi.yjcp.com/center/homePageInfo"] parameters:nil success:^(id responseObject) {
        
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
    //获取轮播图
    NSArray *arr = json[@"lunboList"];
    NSMutableArray *imgArr = [NSMutableArray array];
    if (!NULLArray(arr)) {
        for (int i = 0; i < arr.count; i ++) {
            NSString *imgUrl = arr[i][@"mapAddress"];
            [imgArr addObject:imgUrl];
            [self.lunboArr addObject:arr[i][@"linkAddress"]];
        }
    }
    self.cycleScrollView.imageURLStringsGroup = imgArr;
    
    //获取首页数据
    self.lotListArr = [SYJLotteryModel mj_objectArrayWithKeyValuesArray:json[@"lotterylist"]];
    self.contextListArr = [SYJContextModel mj_objectArrayWithKeyValuesArray:json[@"zxList"]];
        
    [self.tableView reloadData];
       
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)getKaiJiangPic{
    
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://m.zhuoyicp.com/kaijang/kjhall?getData=1"] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        self.kaijiangList = [SYJKaijiangModel mj_objectArrayWithKeyValuesArray:json[@"datas"]];
        
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark - table view dataSource And Delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"彩种系列";
    }else if (section == 1){
        return @"开奖大厅";
    }else{
        return @"热点推送";
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        return KSceenW;
    }else if (indexPath.section == 1){
        
        return 70;

    }else if (indexPath.section == 2){
        return 100;
    }else{
        
        return 0;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.kaijiangList.count;
   
    }else{
        
        return self.contextListArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SYJTableCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lunboCell"];
        cell.delegate = self;
        
        NSMutableArray *listArr = [NSMutableArray array];
        if (!NULLArray(self.lotListArr)) {
            for (int i = 0; i < self.lotListArr.count; i ++) {
                SYJLotteryModel *model = self.lotListArr[i];
                NSString *str = model.lotName;
                [listArr addObject:str];
                SYJLog(@"%@",str);
            }
            
        }
        cell.listArr = self.lotListArr;
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        NSArray *imgArr = @[@"排列三",@"排列五",@"福彩3D",@"七乐彩",@"超级大乐透",@"胜负彩",@"进球彩",@"半全场",@"双色球",@"七星彩"];
        
        SYJKaijiangModel *model = self.kaijiangList[indexPath.row];
        switch (model.lotteryNo) {
            case 33:
            {
                SYJPLThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pl3"];
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *arr = [model.AWARD_NUMBER componentsSeparatedByString:@","];
                    cell.firstNum.text = arr[0];
                    cell.secondNum.text = arr[1];
                    cell.thirdNum.text = arr[2];
                }
                return cell;
                
            }
                break;
            case 35:
            {
                SYJPLFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pl5"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *arr = [model.AWARD_NUMBER componentsSeparatedByString:@","];
                    cell.firstNum.text = arr[0];
                    cell.secondNum.text = arr[1];
                    cell.thirdNum.text = arr[2];
                    cell.fourNum.text = arr[3];
                    cell.fiveNum.text = arr[4];
                }
                return cell;
                
            }
                
                break;
            case 52:
            {
                SYJFuCaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fucai"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *arr = [model.AWARD_NUMBER componentsSeparatedByString:@","];
                    cell.firstNum.text = arr[0];
                    cell.secondNum.text = arr[1];
                    cell.thirdNum.text = arr[2];
                }
                return cell;
                
            }

                break;
            case 23528:
            {
                SYJQiLeCaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qile"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *arr = [model.AWARD_NUMBER componentsSeparatedByString:@":"];
                    NSArray *strArr = [arr[0] componentsSeparatedByString:@","];
                    cell.firstNum.text = strArr[0];
                    cell.secondNum.text = strArr[1];
                    cell.thirdNum.text = strArr[2];
                    cell.fourNum.text = strArr[3];
                    cell.fiveNum.text = strArr[4];
                    cell.sixNum.text = strArr[5];
                    cell.sevenNum.text = strArr[6];
                    cell.eightNum.text = arr[1];

                }
                return cell;
                
            }
                
                break;
            case 23529:
            {
                SYJDaLeTouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dale"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *arr = [model.AWARD_NUMBER componentsSeparatedByString:@":"];
                    NSArray *strArr = [arr[0] componentsSeparatedByString:@","];
                    NSArray *strArr1 = [arr[1] componentsSeparatedByString:@","];
                    cell.firstNum.text = strArr[0];
                    cell.secondNum.text = strArr[1];
                    cell.thirdNum.text = strArr[2];
                    cell.fourNum.text = strArr[3];
                    cell.fiveNum.text = strArr[4];
                    cell.sixNum.text =  strArr1[0];
                    cell.sevenNum.text = strArr1[1];
                    
                }
                return cell;
                
            }

                break;
            case 19:
            {
                SYJShengFuCaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shengfu"];
        
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    cell.numLab.text = model.AWARD_NUMBER;
                    
                }
                return cell;
                
            }

                
                break;
            case 18:
            {
                SYJJinQiuCaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jinqiu"];
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    cell.numLab.text = model.AWARD_NUMBER;
                    
                }
                return cell;
                
            }

                
                break;
            case 16:
            {
                SYJBanQuanChangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banquan"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.LotteryDates;
                    cell.numLab.text = model.AWARD_NUMBER;
                    
                }
                return cell;
                
            }

                
                break;
            case 51:
            {
                SYJShuangSeQiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shuangse"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *arr = [model.AWARD_NUMBER componentsSeparatedByString:@":"];
                    NSArray *strArr = [arr[0] componentsSeparatedByString:@","];
                    cell.firstNum.text = strArr[0];
                    cell.secondNum.text = strArr[1];
                    cell.thirdNum.text = strArr[2];
                    cell.fourNum.text = strArr[3];
                    cell.fiveNum.text = strArr[4];
                    cell.sixNum.text =  strArr[5];
                    cell.sevenNum.text = arr[1];
                    
                }
                return cell;
                
            }
                

                break;
            case 10022:
            {
                SYJQiXingCaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qixing"];
                
                
                if (!NULLArray(self.kaijiangList)) {
                    cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                    cell.lotteryName.text = model.lotteryName;
                    cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                    cell.timeLab.text = model.AWARD_TIME;
                    
                    NSArray *strArr = [model.AWARD_NUMBER componentsSeparatedByString:@","];
                    cell.firstNum.text = strArr[0];
                    cell.secondNum.text = strArr[1];
                    cell.thirdNum.text = strArr[2];
                    cell.fourNum.text = strArr[3];
                    cell.fiveNum.text = strArr[4];
                    cell.sixNum.text =  strArr[5];
                    cell.sevenNum.text = strArr[6];
                    
                }
                return cell;
                
            }
                
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 2){
        
        SYJNewsContextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"context"];
        SYJContextModel *model = self.contextListArr[indexPath.row];
        cell.model = model;
        return cell;
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYJKJDTController *vc = [[SYJKJDTController alloc]init];
    if (indexPath.section == 0) {
        
        
    }else if (indexPath.section == 1) {
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2){
        
        SYJContextModel *model = self.contextListArr[indexPath.row];
        SYJContextWebController *vc = [[SYJContextWebController alloc]init];
        vc.url = model.contentUrl;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

#pragma mark - collectionSelect delegate
- (void)index:(NSInteger)index{
    
    SYJLotteryModel *model = self.lotListArr[index];
    if ([model.remark isEqualToString:@"停售"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该彩种已经暂停销售！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else{
        
        switch (index) {
            case 0:{
                SYJContextWebController *vc = [[SYJContextWebController alloc]init];
                vc.url = @"http://m.zhuoyicp.com/jch5?";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            case 5:
                
                break;
            case 6:
                
                break;
            case 7:
                
                break;
            case 8:
                
                break;
            case 9:
                
                break;
            case 10:
                
                break;
            case 11:
                
                break;
            case 12:
                
                break;
            case 13:
                
                break;
            case 14:
                
                break;
            case 15:
            {
                SYJMoreCaiZhongController *vc =[[SYJMoreCaiZhongController alloc]init];
                vc.listArr = self.lotListArr;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
//        
//        if (index == 15){
//            
//            
//        }else{
//            
//            SYJIntroduceVC *VC = [[SYJIntroduceVC alloc]init];
//            VC.type = index;
//            [self.navigationController pushViewController:VC animated:YES];
//        }
 
    }
    
    
}

#pragma mark - delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    SYJContextWebController *vc =[[SYJContextWebController alloc]init];
    vc.url = self.lunboArr[index];
    [self.navigationController pushViewController:vc animated:YES];
    
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
