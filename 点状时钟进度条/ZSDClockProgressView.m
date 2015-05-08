//
//  ZSDClockProgressView.m
//  demo
//
//  Created by zhaoxiao on 15/4/9.
//  Copyright (c) 2015年 zhaoxiao. All rights reserved.
//

#import "ZSDClockProgressView.h"

#define kPointNumber 60
#define kAnglePerPoint (M_PI * 2 / kPointNumber)
#define kAngle(num) (kAnglePerPoint) * (num)

@interface ZSDClockProgressView ()
{
    CAShapeLayer *clockLayer;
}

@property (nonatomic,assign) CGFloat smallCircleRadiu;
@property (nonatomic,copy) UIColor *normalColor;

@end

@implementation ZSDClockProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setup];
    }
    
    return self;
}

-(void)setup
{
    self.bigCircleRadiu = 3.f;
    self.smallCircleRadiu = 1.0f;
    self.selectedColor = [UIColor redColor];
    self.normalColor = [UIColor grayColor];
    self.startAngle = -M_PI_2;
    
    clockLayer = [[CAShapeLayer alloc]init];
    clockLayer.frame = CGRectMake(0, 0, self.bounds.size.width - _bigCircleRadiu, self.bounds.size.height - _bigCircleRadiu);
    clockLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:clockLayer];
    
    _progress = -1;
    
    self.progress = 0;[self addLabels];
}

-(void)addLabels
{
    CGRect frect = CGRectZero;
    frect.origin.y = CGRectGetMidY(self.bounds) - 30.0f;
    frect.size.width = self.bounds.size.width;
    frect.size.height = 40.0f;
    _titleLabel = [[UILabel alloc]initWithFrame:frect];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    
    frect.origin.y = CGRectGetMaxY(_titleLabel.frame) + 5.0f;
    frect.size.height = 25.0f;
    _detailLabel = [[UILabel alloc]initWithFrame:frect];
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.textColor = [UIColor whiteColor];
    [self addSubview:_detailLabel];
}

-(void)drawClock
{
    CGFloat clockRadiu = clockLayer.bounds.size.width / 2.0f;
    CGPoint center = clockLayer.position;
    for (int i = 0; i < kPointNumber; i++)
    {
        CAShapeLayer *sharpLayer = [CAShapeLayer layer];
        [clockLayer addSublayer:sharpLayer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        sharpLayer.lineCap = kCALineCapRound;
        sharpLayer.lineJoin = kCALineJoinRound;
        
        CGFloat point_x = cosf(_startAngle + kAngle(i)) * clockRadiu;
        CGFloat point_y = sinf(_startAngle + kAngle(i)) * clockRadiu;
        CGPoint centerPoint = CGPointMake(center.x + point_x, center.y + point_y);
        
        if(i < _progress * kPointNumber && (i > 0 || _progress == 1))
        {
            sharpLayer.strokeColor = _selectedColor.CGColor;
            sharpLayer.fillColor = _selectedColor.CGColor;
        }
        else
        {
            sharpLayer.strokeColor = _normalColor.CGColor;
            sharpLayer.fillColor = _normalColor.CGColor;
        }
        
        if(i % 5 == 0)
        {
            sharpLayer.fillColor = [UIColor whiteColor].CGColor;
            [path addArcWithCenter:centerPoint radius:_bigCircleRadiu startAngle:0 endAngle:M_PI * 2 clockwise:NO];
        }
        else
        {
            [path addArcWithCenter:centerPoint radius:_smallCircleRadiu startAngle:0 endAngle:M_PI * 2 clockwise:NO];
        }
        sharpLayer.path = path.CGPath;
    }
}

-(void)setProgress:(CGFloat)progress
{
    if(progress > 1)
    {
        progress = 1;
    }
    if(_progress != progress)
    {
        _progress = progress;
        
        [self drawClock];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
