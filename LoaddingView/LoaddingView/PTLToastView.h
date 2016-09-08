//
//  PTLToastView.h
//  Demo
//
//  Created by PTL on 16/8/11.
//  Copyright © 2016年 PTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTLToastView : UILabel

{
    @public
    CGFloat screenWidth,screenHeight;
    int _corner;
    int _duration;
}

@property(assign,nonatomic)int corner;
@property(assign,nonatomic)int duration;


-(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andParentView:(UIView *)parentView;

-(void)showToastViewWithText:(NSString *)text andParentView:(UIView *)parentView;

-(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andCorner:(int)corner andParentView:(UIView *)parentView;

+(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andParentView:(UIView *)parentView;

+(void)showToastViewWithText:(NSString *)text andParentView:(UIView *)parentView;

+(void)showToastViewWithText:(NSString *)text andDuration:(int)duration andCorner:(int)corner andParentView:(UIView *)parentView;

-(void)setBackgroundWithColor:(UIColor *)color;

@end
