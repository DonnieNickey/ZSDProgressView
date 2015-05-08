//
//  ZSDProgressCircleView.h
//  Qian100
//
//  Created by shaw on 15/4/9.
//  Copyright (c) 2015年 ZOSENDA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZSDCircleProgressType)
{
    ZSDCircleProgressTypeNone,
    ZSDCircleProgressTypeValue1,        //下缺口的进度条
    ZSDCircleProgressTypeValue2,        //点状进度条
    ZSDCircleProgressTypeValue3         //线状时钟进度条
};

@interface ZSDProgressCircleView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;

@property (nonatomic,assign) CGFloat progress;                      //进度  0~1
@property (nonatomic,assign) ZSDCircleProgressType progressType;    //进度条类型

@property (nonatomic,assign) CGFloat startAngle;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detailText;


@end
