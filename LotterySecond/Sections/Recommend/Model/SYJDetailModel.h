//
//  SYJDetailModel.h
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJDetailModel : NSObject

@property (nonatomic , assign) NSInteger             lotteryId;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * testAwardNum;
@property (nonatomic , copy) NSString              * playid;
@property (nonatomic , assign) NSInteger              awardmoney;
@property (nonatomic , copy) NSString              * htime;
@property (nonatomic , copy) NSString              * lotteryName;
@property (nonatomic , strong) NSArray <NSString *>* red;
@property (nonatomic , strong) NSArray <NSString *>* blue;
@property (nonatomic , copy) NSString              * lotId;
@property (nonatomic , strong) NSArray             * dzInfos;
@property (nonatomic , copy) NSString              * lotteryNumber;
@property (nonatomic , assign) NSInteger              ernie_date;
@property (nonatomic , copy) NSString              * issueId;
@property (nonatomic , copy) NSString              * rq_time;
@property (nonatomic , copy) NSString              * awardNum;
@property (nonatomic , assign) NSInteger              prizePool;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * award;
@property (nonatomic , copy) NSString              * prizeDate;


@end
