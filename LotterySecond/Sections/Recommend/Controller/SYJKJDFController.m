
//
//  SYJKJDFController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/7.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJKJDFController.h"
#import "SYJDFModel.h"
#import "SYJBanQuanChangCell.h"
#import "SYJKJDFDetailVC.h"

@interface SYJKJDFController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSString *pervice;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSMutableArray *pervicesArr;

@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation SYJKJDFController

- (NSMutableArray *)pervicesArr{
    
    if (_pervicesArr == nil) {
        _pervicesArr = [NSMutableArray array];
    }
    
    return _pervicesArr;
}

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
    [self setTableViewRegister];
    [self getHttpPic];
    // Do any additional setup after loading the view.
}

- (void)getHttpPic{
    
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://m.zhuoyicp.com/kaijang/dfkj?getData=1"] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        //获取数据
        self.dict = json[@"datas"];
        pervice = json[@"province"];
        
        
        NSArray *perArr = [pervice componentsSeparatedByString:@","];
        SYJLog(@"..................%@",perArr);

        
        for (int i = 0; i < perArr.count; i ++) {
            
            NSString *str = perArr[i];
            NSArray *arr = [SYJDFModel mj_objectArrayWithKeyValuesArray:self.dict[str]];
            SYJLog(@"..................%@",arr);

            
            [self.listArr addObject:arr];
            
            


        }
        
        SYJLog(@"..................%@",self.listArr);

        
        
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
    
    
    
    
}

- (void)setTableViewRegister{
    
    [self.tableView registerClass:[SYJBanQuanChangCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHttpPic];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];

}


#pragma mark - table view dataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSArray *perArr;
    if (!NULLString(pervice)) {
        perArr = [pervice componentsSeparatedByString:@","];
    }
    
    NSString *str = perArr[section];
    return str;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSArray *perArr;
    if (!NULLString(pervice)) {
        perArr = [pervice componentsSeparatedByString:@","];
        return perArr.count;
    }else{
        
        return 1;
    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSArray *perArr;
//    if (!NULLString(pervice)) {
//        perArr = [pervice componentsSeparatedByString:@","];
//        NSString *str = perArr[section];
//        self.listArr = [SYJDFModel mj_objectArrayWithKeyValuesArray:self.dict[str]];
//          
//    }
//
    if (!NULLArray(self.listArr)) {
        
        NSArray *arr = self.listArr[section];
        
        return arr.count;

    }else{
        
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYJBanQuanChangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!NULLArray(self.listArr)) {
        
        
        
        NSArray *arr = self.listArr[indexPath.section];
        SYJDFModel *model = arr[indexPath.row];
        cell.icon.image = [UIImage imageNamed:@"竞彩系列"];
        cell.lotteryName.text = model.lotName;
        cell.numberLab.text = [NSString stringWithFormat:@"%@期",model.issue];
        cell.numLab.text = model.award;
        cell.timeLab.text = model.prizeDate;
    }
    
    return cell;
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr = self.listArr[indexPath.section];
    
    SYJDFModel *model = arr[indexPath.row];
    SYJKJDFDetailVC *vc = [[SYJKJDFDetailVC alloc]init];
    vc.lotteryNo = [NSString stringWithFormat:@"%ld",model.lotId ];
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
