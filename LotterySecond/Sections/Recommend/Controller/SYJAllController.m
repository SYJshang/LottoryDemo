//
//  SYJAllController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/7.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJAllController.h"
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
#import "SYJKaijiangModel.h"
#import "SYJKaijinagDetailController.h"

@interface SYJAllController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation SYJAllController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    [self setTableViewRegister];
    
    // Do any additional setup after loading the view.
}

- (void)getHttpPic{
    
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://m.zhuoyicp.com/kaijang/kjhall?getData=1"] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        //获取数据
        self.listArr = [SYJKaijiangModel mj_objectArrayWithKeyValuesArray:json[@"datas"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, KSceenW, KSceenH - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHttpPic];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
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
    SYJKaijiangModel *model = self.listArr[indexPath.row];
    
    switch (model.lotteryNo) {
        case 33:
        {
            SYJPLThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pl3"];
            
            if (!NULLArray(self.listArr)) {
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
            
            
            if (!NULLArray(self.listArr)) {
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
            
            
            if (!NULLArray(self.listArr)) {
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
            
            
            if (!NULLArray(self.listArr)) {
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
            
            
            if (!NULLArray(self.listArr)) {
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
            
            if (!NULLArray(self.listArr)) {
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
            
            if (!NULLArray(self.listArr)) {
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
            
            
            if (!NULLArray(self.listArr)) {
                cell.icon.image = [UIImage imageNamed:imgArr[indexPath.row]];
                cell.lotteryName.text = model.lotteryName;
                cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.ISSUE_ID];
                cell.timeLab.text = model.AWARD_TIME;
                cell.numLab.text = model.AWARD_NUMBER;
                
            }
            return cell;
            
        }
            
            
            break;
        case 51:
        {
            SYJShuangSeQiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shuangse"];
            
            
            if (!NULLArray(self.listArr)) {
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
            
            
            if (!NULLArray(self.listArr)) {
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
    
    SYJKaijiangModel *mdoel = self.listArr[indexPath.row];
    SYJKaijinagDetailController *vc = [[SYJKaijinagDetailController alloc]init];
    vc.lotteryNo = [NSString stringWithFormat:@"%ld",mdoel.lotteryNo];
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
