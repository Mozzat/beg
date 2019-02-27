//
//  MZTScrollVIewSlider.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MZTScrollVIewSlider.h"
#import "UIImageView+Load.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MZTScrollVIewSlider ()

@property (nonatomic, strong) MZTScrollView *scrollView;

@end

@implementation MZTScrollVIewSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self);
            
        }];
        
    }
    return self;
}

#pragma mark---懒加载
- (MZTScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[MZTScrollView alloc]init];
        
    }
    return _scrollView;
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    self.scrollView.imageArr = data;
    
}

@end

@interface MZTScrollView ()<UIScrollViewDelegate>

//左后的滑动坐标
@property(nonatomic, assign)CGFloat lastPosition;
//当前页
@property(nonatomic, assign)NSInteger currentpage;

@property (nonatomic, assign) float   maxHeight;


@end

@implementation MZTScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置分页
        self.pagingEnabled = YES;
        //设置弹簧效果为NO
        self.bounces = NO;
        self.delegate = self;
        //关闭自动布局
        self.translatesAutoresizingMaskIntoConstraints = NO;
        //隐藏滚动条
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr{
    
    _imageArr = imageArr;
    
    [self removeAllSubviews];
    
    UIImageView *lastImage = nil;
    for (NSInteger index = 0; index < imageArr.count ; index ++) {
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.tag = 1111 + index;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
//        [imageV loadImageViewWithImageString:imageArr[index] WithPlaceHoldeImage:@"坐标模式"];
        NSString *currentImageStr = [imageArr[index] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imageV sd_setImageWithURL:[NSURL URLWithString:currentImageStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            CGFloat w = image.size.width;
            CGFloat h = image.size.height;
            CGFloat scale = w/h;
            CGFloat h1 =  SCREEN_WIDTH /  scale;
            
            if (index == 0) {
                self.maxHeight = h1;
                
            } else {
                
                if (h1 > self.maxHeight) {
                    self.maxHeight = h1;
                }
                
            }
            
            
        }];
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            if (lastImage) {
                make.left.equalTo(lastImage.mas_right);
            } else {
                make.left.equalTo(self);
            }
            
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.equalTo(self);
            
        }];
        
        lastImage = imageV;
        
    }
    
}

- (void)setMaxHeight:(float)maxHeight{
    
    _maxHeight = maxHeight ;
    
    self.contentSize = CGSizeMake(self.imageArr.count * SCREEN_WIDTH, maxHeight);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(maxHeight);
        
    }];
    
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //拿到移动中的x
//    CGFloat offsetX = scrollView.contentOffset.x;
//    CGFloat currentPostion = offsetX;
//    //当前页数
//    int page = offsetX / SCREEN_WIDTH;
//
////    BOOL isleft;
////    if (currentPostion > _lastPosition) {
////        isleft = YES;
////        if (page > 0  && offsetX - page * SCREEN_WIDTH <0.01) {
////            page = page -1;
////        }
////    }else{
////        isleft = NO;
////    }
//
//    UIImageView *firstImageView = (UIImageView *)[self viewWithTag:1111+page];
////    UIImageView *nextImageView = (UIImageView *)[self viewWithTag:1111+page+1];
////    ImageModel *firstModel = [self.imageArray objectAtIndex:page];
////    ImageModel *nextModel = [self.imageArray objectAtIndex:page+1];
//
//    CGFloat firtstImageHeiht = firstImageView.height;
////    CGFloat nextImageHeiht = nextImageView.height;
//
//    //设置Y
////    CGFloat distanceY = isleft ? nextImageHeiht - firstImageView.height :firtstImageHeiht - firstImageView.height;
////    CGFloat leftDistaceX = (page +1) * SCREEN_WIDTH - _lastPosition;
////    CGFloat rightDistanceX = SCREEN_WIDTH - leftDistaceX;
////    CGFloat distanceX = isleft ? leftDistaceX :rightDistanceX;
//
//
//    //移动值
////    CGFloat movingDistance = 0.0;
////    if (distanceX != 0 && fabs(_lastPosition - currentPostion) > 0) {
////        movingDistance = distanceY / distanceX * (fabs(_lastPosition - currentPostion));
////    }
//
////    CGFloat firstScale = [firstModel.imageWidth floatValue] / [firstModel.imageHeiht floatValue];
////    CGFloat nextScale = [nextModel.imageWidth floatValue] / [nextModel.imageHeiht floatValue];
//
////    firstImageView.frame = CGRectMake((firstImageView.frame.origin.x- movingDistance * firstScale), 0, (firstImageView.height+movingDistance)*firstScale, firstImageView.height+movingDistance);
////
////    nextImageView.frame = CGRectMake(SCREEN_WIDTH *(page+1), 0, firstImageView.height * nextScale, firstImageView.height);
//    //重新设置大小
//    self.contentSize = CGSizeMake( SCREEN_WIDTH * self.imageArr.count, firstImageView.height);
//
//    //重新设置高度
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//
//        make.height.mas_equalTo(firstImageView.height);
//
//    }];
//
//
////    int newpage = offsetX / SCREEN_WIDTH;
////    if ( offsetX - newpage * SCREEN_WIDTH < 0.01) {
////        _currentpage = newpage+1;
////    }
////
////    _lastPosition = currentPostion;
//}


@end
