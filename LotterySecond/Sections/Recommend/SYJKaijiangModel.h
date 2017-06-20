//
//  SYJKaijiangModel.h
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJKaijiangModel : NSObject

@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * LotteryDates;
@property (nonatomic , copy) NSString              * ISSUE_ID;
@property (nonatomic , copy) NSString              * cREATE_DATE;
@property (nonatomic , assign) NSInteger              AWARD_ID;
@property (nonatomic , assign) NSInteger              pourMoney;
@property (nonatomic , assign) NSInteger              awardMoney;
@property (nonatomic , copy) NSString              * lotteryName;
@property (nonatomic , copy) NSString              * EXT1;
@property (nonatomic , copy) NSString              * openNumber;
@property (nonatomic , assign) NSInteger              AWARD_MONEY;
@property (nonatomic , copy) NSString              * testaward_number;
@property (nonatomic , copy) NSString              * AWARD_NUMBER;
@property (nonatomic , copy) NSString              * EXT2;
@property (nonatomic , assign) NSInteger              TYPE_ID;
@property (nonatomic , copy) NSString              * AWARD_TIME;
@property (nonatomic , copy) NSString              * FINALAWARD_TIME;
@property (nonatomic , assign) NSInteger              AWARD_POOL;
@property (nonatomic , copy) NSString              * CREATE_DATE;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              typeId;
@property (nonatomic , assign) NSInteger             lotteryNo;
@property (nonatomic, strong) NSString             *MODIFY_DATE;


@end
