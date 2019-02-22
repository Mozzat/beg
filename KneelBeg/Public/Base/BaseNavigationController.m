//
//  BaseNavigationController.m
//  jike
//
//  Created by taotingxing on 2018/5/15.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dict = @{NSForegroundColorAttributeName:blackColor(),
                           NSFontAttributeName:BlodFont(16)};
    self.navigationBar.titleTextAttributes = dict;
    
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    
//    UIBarButtonItem *itmes = [UIBarButtonItem  appearanceWhenContainedInInstancesOfClasses:
//                              @[[UINavigationBar class]]];
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName: Font16(),
//                                     NSForegroundColorAttributeName: blackColor()
//                                     };
//    [itmes setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
//    [itmes setTitleTextAttributes:textAttributes forState:UIControlStateHighlighted];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {

        //图片5：8的比例
        self.navigationBar.backItem.hidesBackButton = YES;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 11) {

            UIImage *rightImage = [[UIImage imageNamed:@"评论页面-返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(backVC)];

            viewController.navigationItem.leftBarButtonItem = left;

        }else{
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0, 0, 44, 44);
            [backButton setImage:[UIImage imageNamed:@"评论页面-返回"] forState:UIControlStateNormal];
            backButton.imageView.contentMode = UIViewContentModeCenter;

            [backButton addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];


            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = - 20 ;

            viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, leftButton];
        }
    }
    [super pushViewController:viewController animated:animated];
}


- (void)backVC
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
