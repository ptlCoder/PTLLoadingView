//
//  PTLLoaddingView.m
//  Demo
//
//  Created by PTL on 16/8/10.
//  Copyright © 2016年 PTL. All rights reserved.
//

#import "PTLLoaddingView.h"


@implementation PTLLoaddingView

@synthesize text=_text;
@synthesize timer=_timer;
@synthesize activityView=_activityView;


-(instancetype)initWithParentView:(UIView *) parentView
{
    self = [super init];
    if (self) {
        [self caculatSizeWithTarget:parentView];
        self.frame=CGRectMake(x, y, width, width);
        self.layer.cornerRadius=10;
        self.backgroundColor=[UIColor colorWithRed:00 green:00 blue:00 alpha:0.7];
        self.tag=1001;
        [self creatLoaddingView];
    }
    return  self;
}

/**
 *  便利构造器
 *
 *  @param parentView 父视图
 *
 *  @return 自身对象
 */
+(id)initWithParentView:(UIView *) parentView
{
    PTLLoaddingView * loaddding=[[PTLLoaddingView alloc]initWithParentView:parentView];
    return loaddding;
}

/**
 *  计算一些必要尺寸
 *
 *  @param parentView <#parentView description#>
 */
-(void)caculatSizeWithTarget:(UIView *) parentView
{
    screenWidth=[UIScreen mainScreen].bounds.size.width;
    screenHeight=[UIScreen mainScreen].bounds.size.height;
    width=screenWidth*0.3;
    x= screenWidth/2-width/2;
    y= screenHeight/2-width/2;
    angle=0;
    num=0;
    isShowLoadding=NO;
    _parentView=parentView;
    
}

/**
 *  创建loadding视图
 */
-(void)creatLoaddingView
{
    view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, screenWidth, screenHeight);
    
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(width/2-width*0.5/2,15, width*0.5,width*0.4);
    imageView.clipsToBounds=YES;
    imageView.layer.rasterizationScale=[UIScreen mainScreen].scale;
    [imageView setImage:[UIImage imageNamed:@"loadding.png"]];
    
    _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(width/2-width*0.55/2,15, width*0.55,width*0.45)];
    _activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    
    
    label=[[UILabel alloc]init];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:14];
    int y2=imageView.frame.size.height+(width-imageView.frame.size.height)/2;
    label.frame=CGRectMake(0,y2, width, 20);
    label.textAlignment=NSTextAlignmentCenter;
    
}

/**
 *  开启loadding动画
 */
- (void)startAnimation
{
    if(isShowLoadding==YES){
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / -180.0f));
        [UIView animateWithDuration:0.03f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageView.transform =endAngle;
        } completion:^(BOOL finished) {
            if(angle==360){
                angle=0;
            }
            if(angle==0||angle==360){
                label.text=[_text stringByAppendingString:@"..."];
            }else if(angle==90){
                label.text=_text;
            }else if(angle==180){
                label.text=[_text stringByAppendingString:@"."];
            }else if(angle==270){
                label.text=[_text stringByAppendingString:@".."];
            }
            angle += 10;
            
            [self startAnimation];
        }];
    }
    
}

/**
 *  显示loadding.默认文本为 "正在加载"
 */
-(void)showLoaddingView
{
    if(isShowLoadding==YES){
        return;
    }
    if(_text==nil||[_text isEqualToString:@""]){
        _text=@"正在加载";
    }
    label.text=_text;
    isShowLoadding=YES;
    angle=0;
    self.hidden=NO;
    [self addSubview:imageView];
    [self addSubview:label];
    [view addSubview:self];
    [_parentView addSubview:view];
    [PTLLoaddingView rotateImageView:imageView];
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(UpdateText) userInfo:nil repeats:YES];

}

-(void)showLoaddingViewWithStyle:(int)style
{
    if(style==0){//菊花加载
        if(isShowLoadding==YES){
            return;
        }
        if(_text==nil||[_text isEqualToString:@""]){

             _text=@"正在加载";
         }
        label.text=_text;
        isShowLoadding=YES;
        angle=0;
        self.hidden=NO;
        [self addSubview:_activityView];
        [self addSubview:label];
        [imageView removeFromSuperview];
        [_activityView startAnimating];
        [view addSubview:self];
        [_parentView addSubview:view];
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(UpdateText) userInfo:nil repeats:YES];

    }else{//旋转图片加载
        [self showLoaddingView];
    }

}

/**
 *  显示loadding
 *
 *  @param string 显示的文本
 */
-(void)showLoaddingViewWithText:(NSString *) string
{
    _text=string;
    [self showLoaddingView];
}


-(void)showLoaddingViewWithText:(NSString *)text andStyle:(int)style{
    _text=text;
    [self showLoaddingViewWithStyle:style];
}

/**
 *  启动计数定时器
 */
-(void)UpdateText
{
    num++;
    if (num>4) {
        num=0;
    }
    if(num==0||num==4){
       label.text=[_text stringByAppendingString:@"..."];
    }else if(num==1){
       label.text=_text;
    }else if(num==2){
       label.text=[_text stringByAppendingString:@"."];
    }else if(num==3){
        label.text=[_text stringByAppendingString:@".."];
    }

}

/**
 *  给imageView添加动画
 *
 *  @param imageView imageview
 *
 *  @return imageview
 */
+ (UIImageView *)rotateImageView:(UIImageView *)imageView
{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    
    [imageView.layer addAnimation:animation forKey:nil];
    return imageView;
}

/**
 *  消失loadding
 */
-(void)dismissLoaddingView
{
    self.hidden=YES;
    isShowLoadding=NO;
    [_timer invalidate];
    [imageView.layer removeAllAnimations];
    [_activityView stopAnimating];
    [view removeFromSuperview];
}

/**
 *  判断当前loadding是否显示
 *
 *  @return 是否显示
 */

-(BOOL)isShowing{
    return isShowLoadding;
}


@end
