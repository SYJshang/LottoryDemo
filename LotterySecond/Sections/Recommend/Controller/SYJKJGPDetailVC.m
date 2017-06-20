//
//  SYJKaijinagDetailController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJKJGPDetailVC.h"
#import "SYJBanQuanChangCell.h"
#import "SYJDFModel.h"



@interface SYJKJGPDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger tolNum;
    
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) int numPage;

@end

@implementation SYJKJGPDetailVC

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
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
    
    [self.tableView registerClass:[SYJBanQuanChangCell class] forCellReuseIdentifier:@"banquan"];
    
}


- (void)getHttpPic{

    
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://m.zhuoyicp.com/kaijang/gplist?getData=1&lotid=%@&prizeDate=%@",self.lotteryNo,self.time]parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *arr = [SYJDFModel mj_objectArrayWithKeyValuesArray:json[@"datas"]];
        for (SYJDFModel *model in arr) {
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
    
    SYJDFModel *model = self.listArr[indexPath.row];
    
    SYJBanQuanChangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banquan"];
    if (!NULLArray(self.listArr)) {
        cell.icon.image = [UIImage imageNamed:@"竞彩系列"];
        cell.lotteryName.text = model.lotName;
        cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
        cell.numLab.text =  model.award;
        cell.timeLab.text = model.prizeDate;
    }
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
