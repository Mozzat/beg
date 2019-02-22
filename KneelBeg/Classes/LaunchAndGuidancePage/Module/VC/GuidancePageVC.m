//
//  GuidancePageVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GuidancePageVC.h"
#import "TabBarVC.h"

@interface GuidancePageVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation GuidancePageVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
   
    [self setLocationUI];
}


- (void)setLocationUI{
    
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    [self.view addSubview:scrollerView];
    scrollerView.delegate =self;
    scrollerView.contentSize = CGSizeMake(3 * SCREEN_WIDTH, SCREENH_HEIGHT);
    scrollerView.pagingEnabled = YES;
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    
    ///关闭
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [closeBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
    closeBtn.titleLabel.font = Font14();
    [closeBtn setBackgroundColor:redColor()];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn rounded:25];
    [self.view addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(300);
        make.bottom.equalTo(self.view).offset(-40);
        
    }];
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 3;
    self.pageControl = pageControl;
    pageControl.pageIndicatorTintColor = HexColor(@"d9d9d9");
    pageControl.currentPageIndicatorTintColor = redColor();
    [self.view addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(100);
        make.bottom.equalTo(closeBtn.mas_top).offset(-20);
        
    }];

}

- (void)closeAction{
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarVC alloc]init];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger count = 0;
    count = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.pageControl.currentPage = count;
    
}

@end
