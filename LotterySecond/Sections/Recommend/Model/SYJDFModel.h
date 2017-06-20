//
//  SYJDFModel.h
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/7.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJDFModel : NSObject

@property (nonatomic , assign) NSString             *ID;
@property (nonatomic , assign) NSInteger              lotId;
@property (nonatomic , assign) NSInteger              sale;
@property (nonatomic , copy) NSString              * pool;
@property (nonatomic , copy) NSString              * prizeDetail;
@property (nonatomic , copy) NSString              * prizeDate;
@property (nonatomic , copy) NSString              * lotName;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * award;

@end
