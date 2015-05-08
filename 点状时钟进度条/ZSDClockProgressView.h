//
//  ZSDClockProgressView.h
//  demo
//
//  Created by zhaoxiao on 15/4/9.
//  Copyright (c) 2015年 zhaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSDClockProgressView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detailText;

@property (nonatomic,assign) CGFloat bigCircleRadiu;    //点刻度圆的半径
@property (nonatomic,copy) UIColor *selectedColor;      //进度显示的颜色

@property (nonatomic,assign) CGFloat startAngle;
@property (nonatomic,assign) CGFloat progress;          //进度

@end
