//
//  PTLToastView.m
//  Demo
//
//  Created by PTL on 16/8/11.
//  Copyright © 2016年 PTL. All rights reserved.
//

#import "PTLToastView.h"

@implementation PTLToastView

@synthesize corner=_corner;
@synthesize  duration=_duration;


/**
 *  实例方法显示toast
 *
 *  @param text       文本
 *  @param duration   时间
 *  @param corner     角度
 *  @param parentView 父控件
 */
-(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andCorner:(int)corner andParentView:(UIView *)parentView{
    _duration=duration;
    _corner=corner;
    [self caculateSize];
    [self createUIByText:text];
    [self showToastByParentView:parentView];
}

/**
 *  实例方法显示toast
 *
 *  @param text       文本
 *  @param parentView 父控件
 */
-(void)showToastViewWithText:(NSString *)text andParentView:(UIView *)parentView{
    _duration=1.0;
    _corner=5;
    [self caculateSize];
    [self createUIByText:text];
    [self showToastByParentView:parentView];
}

/**
 *  实例方法显示toast
 *
 *  @param text       文本
 *  @param duration   时间
 *  @param parentView 父控件
 */
-(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andParentView:(UIView *)parentView{
    _duration=duration;
    _corner=5;
    [self caculateSize];
    [self createUIByText:text];
    [self showToastByParentView:parentView];
}

/**
 *  便利构造器显示toast
 *
 *  @param text       文本
 *  @param duration   时间
 *  @param corner     圆角
 *  @param parentView 父控件
 */
+(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andCorner:(int)corner andParentView:(UIView *)parentView{
    
    PTLToastView * toast=[[PTLToastView alloc]init];
    toast.duration=duration;
    toast.corner=corner;
    [toast caculateSize];
    [toast createUIByText:text];
    [toast showToastByParentView:parentView];
    
}

/**
 *  便利构造器显示toast
 *
 *  @param text       文本
 *  @param parentView 父控件容器
 */
+(void)showToastViewWithText:(NSString *)text andParentView:(UIView *)parentView{
   PTLToastView * toast=[[PTLToastView alloc]init];
    toast.duration=1.0;
    toast.corner=5;
    [toast caculateSize];
    [toast createUIByText:text];
    [toast showToastByParentView:parentView];
}

/**
 *  便利构造器显示toast
 *
 *  @param text       文本
 *  @param duration   时间
 *  @param parentView 父控件容器
 */
+(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andParentView:(UIView *)parentView{
    PTLToastView * toast=[[PTLToastView alloc]init];
    toast.duration=duration;
    toast.corner=5;
    [toast caculateSize];
    [toast createUIByText:text];
    [toast showToastByParentView:parentView];
}

/**
 *  新建UI
 *
 *  @param str 要显示的文本
 */
-(void)createUIByText:(NSString *)str{
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor colorWithRed:00 green:00 blue:00 alpha:0.5];
    self.alpha = 0.8;
    self.text=str;
    self.font = [UIFont systemFontOfSize:14];
    self.textColor=[UIColor whiteColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:self.font.pointSize],};
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    self.frame=CGRectMake(screenWidth/2-(textSize.width*1.7)/2, screenHeight*0.5,textSize.width*1.7,
                               textSize.height*2);
    self.layer.cornerRadius = _corner;
    self.clipsToBounds = YES;
}

-(void)setBackgroundWithColor:(UIColor *)color{
    self.backgroundColor =color;
}


/**
 *  初始化测量数据
 */
-(void)caculateSize{
    screenWidth=[UIScreen mainScreen].bounds.size.width;
    screenHeight=[UIScreen mainScreen].bounds.size.height;
}
/**
 *  显示toast
 *
 *  @param parentView <#parentView description#>
 */
-(void)showToastByParentView:(UIView *)parentView{
    [parentView addSubview:self];
    //animateWithDuration可以控制label显示持续时间
    [UIView animateWithDuration:_duration animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
