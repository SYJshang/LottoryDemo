//
//  SYJLeftController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/5.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJLeftController.h"
#import "SYJMainViewController.h"
#import "SYJNavitionController.h"
#import "SYJKJDTController.h"
#import "SYJSetUpController.h"


@interface SYJLeftController ()<UITableViewDelegate,UITableViewDataSource>
    
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SYJLeftController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"设置" font:18.0];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor= [UIColor clearColor];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1234"]];

    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"路上"]];
//    self.tableView.backgroundView = imageView;
    
    // cellForRowAtIndexPath
    //    [self.tableView registerClass:[SYJPicTableCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,KSceenW, 0.01f)];

    // Do any additional setup after loading the view.
}
    
#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 240;
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *imgArr = @[@"首页",@"开奖结果",@"设置",@"帮助"];
    NSArray *titleArr = @[@"首页",@"开奖大厅",@"设置",@"帮助"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"路上"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
    
#pragma mark - table view delegate
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        }];
 
    }else if(indexPath.row == 1){
        
        SYJKJDTController *showVC = [[SYJKJDTController alloc]init];
        //拿到我们的LitterLCenterViewController，让它去push
        SYJNavitionController* nav = (SYJNavitionController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:showVC animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];

    }else if (indexPath.row == 2){
        
        SYJSetUpController *showVC = [[SYJSetUpController alloc]init];
        //拿到我们的LitterLCenterViewController，让它去push
        SYJNavitionController* nav = (SYJNavitionController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:showVC animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];

    }else if (indexPath.row == 3){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"如遇到更多问题，请拨打 010-66192758 咨询了解！"] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];

    }
    
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
