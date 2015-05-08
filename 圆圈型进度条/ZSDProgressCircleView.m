//
//  ZSDProgressCircleView.m
//  Qian100
//
//  Created by shaw on 15/4/9.
//  Copyright (c) 2015年 ZOSENDA. All rights reserved.
//

#import "ZSDProgressCircleView.h"

#define kPointNumber 120
#define kAnglePerPoint (M_PI * 2 / kPointNumber)
#define kAngle(num) (kAnglePerPoint) * (num)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ZSDProgressCircleView ()
{
    CAShapeLayer *backLayer;
    CAShapeLayer *frontLayer;
}

@property (nonatomic,assign) CGFloat lineLength;
@property (nonatomic,copy) UIColor *normalLineColor;
@property (nonatomic,copy) UIColor *selectedLineColor;

@end

@implementation ZSDProgressCircleView

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
    
    backLayer = [[CAShapeLayer alloc]init];
    backLayer.frame = self.layer.bounds;
    frontLayer = [[CAShapeLayer alloc]init];
    frontLayer.frame = self.layer.bounds;
    
    [self.layer addSublayer:backLayer];
    [self.layer addSublayer:frontLayer];
    
    self.progressType = ZSDCircleProgressTypeValue1;
    self.startAngle = -M_PI_2;
    self.lineLength = 8.0f;
    self.normalLineColor = [UIColor grayColor];
    self.selectedLineColor = [UIColor redColor];
}

-(void)setConfig
{
    switch (_progressType) {
        case ZSDCircleProgressTypeValue1:
        {
            backLayer.lineWidth = 3.0f;
            backLayer.lineCap = kCALineCapRound;
            backLayer.lineJoin = kCALineJoinRound;
            backLayer.strokeColor = UIColorFromRGB(0xc1413f).CGColor;
            backLayer.fillColor = [UIColor clearColor].CGColor;
            
            frontLayer.strokeEnd = 0.f;
            frontLayer.lineWidth = 6.0f;
            frontLayer.lineCap = kCALineCapRound;
            frontLayer.lineJoin = kCALineJoinRound;
            frontLayer.lineDashPattern = nil;
            frontLayer.strokeColor = [UIColor whiteColor].CGColor;
            frontLayer.fillColor = [UIColor clearColor].CGColor;
        }
            break;
        case ZSDCircleProgressTypeValue2:
        {
            backLayer.lineWidth = 3.0f;
            backLayer.lineCap = kCALineCapRound;
            backLayer.lineJoin = kCALineJoinRound;
            backLayer.strokeColor = UIColorFromRGB(0xc1413f).CGColor;
            backLayer.fillColor = [UIColor clearColor].CGColor;
            
            frontLayer.strokeEnd = 0.f;
            frontLayer.lineWidth = 3.0f;
            frontLayer.lineCap = kCALineCapRound;
            frontLayer.lineJoin = kCALineJoinRound;
            frontLayer.lineDashPattern = @[@1,@6,@1,@6];
            frontLayer.strokeColor = [UIColor whiteColor].CGColor;
            frontLayer.fillColor = [UIColor clearColor].CGColor;
        }
            break;
        case ZSDCircleProgressTypeValue3:
        {
//            backLayer.lineWidth = 3.0f;
            backLayer.lineWidth = 1.0f;
            backLayer.lineCap = kCALineCapRound;
            backLayer.lineJoin = kCALineJoinRound;
//            backLayer.strokeColor = UIColorFromRGB(0xc1413f).CGColor;
            backLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.2f].CGColor;
            backLayer.fillColor = [UIColor clearColor].CGColor;
            
            frontLayer.frame = CGRectInset(self.layer.bounds, 6.0f, 6.0f);
            frontLayer.strokeEnd = 0.f;
            frontLayer.lineWidth = 1.0f;
            frontLayer.strokeColor = [UIColor whiteColor].CGColor;
            frontLayer.fillColor = [UIColor clearColor].CGColor;
        }
            break;
            
        default:
            break;
    }
    
    [self drawPath];
}

-(void)drawPath
{
    UIBezierPath *frontPath = [UIBezierPath bezierPath];
    UIBezierPath *backPath = [UIBezierPath bezierPath];
    switch (_progressType) {
        case ZSDCircleProgressTypeValue1:
        {
            CGFloat startAngle = M_PI_2 * 11 / 10.0f;
            CGFloat frontEndAngle = startAngle + _progress * (M_PI * 2 - M_PI_2 / 5.0f);
            CGFloat backEndAngle = M_PI_2 * 9 / 10.0f;
            
            [frontPath addArcWithCenter:frontLayer.position radius:self.bounds.size.width / 2.0f startAngle:startAngle endAngle:frontEndAngle clockwise:YES];
            
            [backPath addArcWithCenter:backLayer.position radius:self.bounds.size.width / 2.0f startAngle:startAngle endAngle:backEndAngle clockwise:YES];
        }
            break;
        case ZSDCircleProgressTypeValue2:
        {
            CGFloat startAngle = -M_PI_2;
            CGFloat frontEndAngle = startAngle + _progress * M_PI * 2;
            CGFloat backEndAngle = M_PI_2 * 3;
            
            [frontPath addArcWithCenter:frontLayer.position radius:self.bounds.size.width / 2.0f startAngle:startAngle endAngle:frontEndAngle clockwise:YES];
            
            [backPath addArcWithCenter:frontLayer.position radius:self.bounds.size.width / 2.0f startAngle:startAngle endAngle:backEndAngle clockwise:YES];
        }
            break;
        case ZSDCircleProgressTypeValue3:
        {
            CGFloat bigRadiu = frontLayer.bounds.size.width / 2.0f;
            CGFloat smallRadiu = frontLayer.bounds.size.width / 2.0f - 6.0;
            CGPoint centerPoint = CGPointMake(frontLayer.bounds.size.width / 2.0f, frontLayer.bounds.size.height / 2.0f);
            self.selectedLineColor = [UIColor whiteColor];
            self.normalLineColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
            for (int i = 0; i < kPointNumber; i++)
            {
                CAShapeLayer *sharpLayer = [CAShapeLayer layer];
                [frontLayer addSublayer:sharpLayer];
                
                UIBezierPath *path = [UIBezierPath bezierPath];
                sharpLayer.lineCap = kCALineCapSquare;
                sharpLayer.lineJoin = kCALineJoinBevel;
                sharpLayer.lineWidth = 1.0f;
                
                CGFloat point_x1 = cosf(_startAngle + kAngle(i)) * bigRadiu;
                CGFloat point_x2 = cosf(_startAngle + kAngle(i)) * smallRadiu;
                
                CGFloat point_y1 = sinf(_startAngle + kAngle(i)) * bigRadiu;
                CGFloat point_y2 = sinf(_startAngle + kAngle(i)) * smallRadiu;
                
                CGPoint point1 = CGPointMake(centerPoint.x + point_x1, centerPoint.y + point_y1);
                CGPoint point2 = CGPointMake(centerPoint.x + point_x2, centerPoint.y + point_y2);
                if(i < _progress * kPointNumber && (i > 0 || _progress == 1))
                {
                    sharpLayer.strokeColor = _selectedLineColor.CGColor;
                    sharpLayer.fillColor = [UIColor clearColor].CGColor;
                }
                else
                {
                    sharpLayer.strokeColor = _normalLineColor.CGColor;
                    sharpLayer.fillColor = [UIColor clearColor].CGColor;
                }
                
                [path moveToPoint:point1];
                [path addLineToPoint:point2];
                
                sharpLayer.path = path.CGPath;
            }
            
            CGFloat startAngle = -M_PI_2;
            CGFloat backEndAngle = M_PI_2 * 3;
            
            [backPath addArcWithCenter:frontLayer.position radius:self.bounds.size.width / 2.0f startAngle:startAngle endAngle:backEndAngle clockwise:YES];
        }
            break;
            
        default:
            break;
    }
    
    frontLayer.path = frontPath.CGPath;
    backLayer.path = backPath.CGPath;
    
    [self addAnimation];
}

-(void)addAnimation
{
    [self removeAnimation];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.6f;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    animation.repeatCount = 0.f;
    animation.fromValue = @(frontLayer.strokeEnd);
    animation.toValue = @(1.0f);
    [frontLayer addAnimation:animation forKey:@"strokeEndAnimation"];
}

-(void)removeAnimation
{
    [frontLayer removeAnimationForKey:@"strokeEndAnimation"];
}

//设置进度条类型
-(void)setProgressType:(ZSDCircleProgressType)progressType
{
    if (_progressType != progressType)
    {
        _progressType = progressType;
        
        [self setConfig];
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
        
        [self drawPath];
    }
}

-(void)setTitle:(NSString *)title
{
    if(_title != title)
    {
        _title = title;
        
        _titleLabel.text = _title;
    }
}

-(void)setDetailText:(NSString *)detailText
{
    if(_detailText != detailText)
    {
        _detailText = detailText;
        
        _detailLabel.text = _detailText;
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
