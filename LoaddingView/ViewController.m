//
//  ViewController.m
//  PTLDemo1_提示框与加载框
//
//  Created by PTL on 16/9/2.
//  Copyright © 2016年 PTL. All rights reserved.
//

#import "ViewController.h"
#import "PTLToastView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(80, 400, 160, 30);
    [button setTitle:@"旋转图片loadding" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=101;
    
    UIButton * button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(80, 450, 160, 30);
    [button2 setTitle:@"系统菊花loadding" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag=102;
    
    
    // self.view.backgroundColor=[UIColor whiteColor];
    mySwitch=[[UISwitch alloc]init];
    mySwitch.frame=CGRectMake(100, 100, 0, 0);
    mySwitch.on=YES;
    [mySwitch setOnTintColor:[UIColor redColor]];
    [mySwitch addTarget:self action:@selector(doChange:) forControlEvents:UIControlEventValueChanged];
    
    Loadding=[PTLLoaddingView initWithParentView:self.view];
    
    [self.view addSubview:mySwitch];
    [self.view addSubview:button];
    [self.view addSubview:button2];
}

-(void)onClick:(UIButton *)button{
    if(button.tag==101){//旋转图片loadding
        [Loadding showLoaddingViewWithText:@"正在登陆" andStyle:1];
       // [Loadding showLoaddingViewWithStyle:1];
        // [Loadding showLoaddingViewWithText:@"正在登录"];
    }else if(button.tag==102){//系统菊花loadding
        [Loadding showLoaddingViewWithStyle:0];
    }else if(button.tag==103){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


-(void)doChange:(UISwitch *)Switch{
    if(Switch.on==YES){
        [PTLToastView showToastViewWithText:@"已开启" andDuration:3 andCorner:5 andParentView:self.view];
    }else{
        [PTLToastView showToastViewWithText:@"已关闭" andDuration:3 andCorner:5 andParentView:self.view];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if([Loadding isShowing]==YES){
        [Loadding dismissLoaddingView];
    }
}

-(void)creatUI{
    
    
}


@end
