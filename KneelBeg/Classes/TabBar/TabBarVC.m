//
//  TabBarVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "TabBarVC.h"
#import "BaseNavigationController.h"
#import "GrabOrderVC.h"
#import "MineVC.h"
//#import "SendOrderVC.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : HexColor(@"b9b9b9")} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : redColor()} forState:UIControlStateSelected];
    
    NSArray *titleArr =@[@"抢单",@"发单",@"发单"];
    NSArray *vcArr = @[@"GrabOrderVC",@"SendOrderVC",@"MineVC"];
    NSArray *imageArr = @[@"抢单",@"发单",@"发单"];
    
    for (NSInteger index = 0; index < vcArr.count; index++) {
        
        BaseViewController *vc = [[NSClassFromString(vcArr[index]) alloc]init];
        vc.navigationItem.title = titleArr[index];
        [self setupOneChildViewController:vc title:titleArr[index] image:[NSString stringWithFormat:@"%@",imageArr[index]] selectedImage:[NSString stringWithFormat:@"%@-选中",imageArr[index]]];
        
    }
    
}

//设置子控制器
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    UIImage *image1 = [UIImage imageNamed:image];
    //    不使用系统自带的蓝色默认图
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSelect = [UIImage imageNamed:selectedImage];
    imageSelect = [imageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *na = [[BaseNavigationController alloc] initWithRootViewController:vc];
    na.tabBarItem.title = title;
    na.tabBarItem.image = image1;
    na.tabBarItem.selectedImage = imageSelect;

    [self addChildViewController:na];
}
@end
