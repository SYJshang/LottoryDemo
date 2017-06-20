//
//  SYJKaijinagDetailController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJKaijinagDetailController.h"
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
#import "SYJDetailModel.h"

@interface SYJKaijinagDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger tolNum;
    
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) int numPage;

@end

@implementation SYJKaijinagDetailController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"往期开奖详情" font:18.0];
    
    self.navBarTintColor = [UIColor redColor];
    self.navTintColor = [UIColor whiteColor];
    
}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarTintColor = [UIColor redColor];
    
    [self setTableView];
    [self setTableViewRegister];
    
    // Do any additional setup after loading the view.
}

- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.numPage = 1;
        [self getHttpPic];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.listArr.count < tolNum) {
            self.numPage ++;
            [self getHttpPic];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
       
    }];
    
}

- (void)setTableViewRegister{
    
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
    
}


- (void)getHttpPic{
    
    NSString *page = [NSString stringWithFormat:@"%d",self.numPage];
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://m.zhuoyicp.com/kaijang/recents?getData=1&page=%@&playid=%@&selnum=20",page,self.lotteryNo] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *arr = [SYJDetailModel mj_objectArrayWithKeyValuesArray:json[@"datas"]];
        for (SYJDetailModel *model in arr) {
            [self.listArr addObject:model];
        }
        
        tolNum = [json[@"dataNum"] integerValue];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *imgArr = @[@"排列三",@"排列五",@"福彩3D",@"七乐彩",@"超级大乐透",@"胜负彩",@"进球彩",@"半全场",@"双色球",@"七星彩"];
    SYJDetailModel *model = self.listArr[indexPath.row];

    NSInteger type = [self.lotteryNo integerValue];
    switch (type) {
    
        case 33:
        {
            SYJPLThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pl3"];
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[0]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *arr = [model.lotteryNumber componentsSeparatedByString:@","];
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
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[1]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *arr = [model.lotteryNumber componentsSeparatedByString:@","];
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
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[2]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *arr = [model.lotteryNumber componentsSeparatedByString:@","];
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
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[3]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *arr = [model.lotteryNumber componentsSeparatedByString:@":"];
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
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[4]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *arr = [model.lotteryNumber componentsSeparatedByString:@":"];
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
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[5]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                cell.numLab.text = model.lotteryNumber;
                
            }
            return cell;
            
        }
            
            
            break;
        case 18:
        {
            SYJJinQiuCaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jinqiu"];
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[6]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                cell.numLab.text = model.lotteryNumber;
                
            }
            return cell;
            
        }
            
            
            break;
        case 16:
        {
            SYJBanQuanChangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banquan"];
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[7]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                cell.numLab.text = model.lotteryNumber;
                
            }
            return cell;
            
        }
            
            
            break;
        case 51:
        {
            SYJShuangSeQiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shuangse"];
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[8]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *arr = [model.lotteryNumber componentsSeparatedByString:@":"];
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
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[9]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
                cell.timeLab.text = model.time;
                
                NSArray *strArr = [model.lotteryNumber componentsSeparatedByString:@","];
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
    

    static NSString *cellIdentifier = @"MTCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];

    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
