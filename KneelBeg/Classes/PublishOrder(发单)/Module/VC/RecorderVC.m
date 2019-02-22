//
//  RecorderVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "RecorderVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "PublishVoiceVC.h"
#import "VoiceRecorderManager.h"
#import "AudioShowTostView.h"
#import "PublishVoiceVC.h"

@interface RecorderVC ()

@property (nonatomic, strong) UIButton *recorderBtn;
@property (nonatomic, strong) VoiceRecorderManager *recorderManager;
@property (nonatomic, strong) AudioShowTostView    *tostView;

@property (nonatomic, strong) NSTimer     *currentTimer;
///是否取消
@property (nonatomic, assign) BOOL        canceled;
///时长
@property (nonatomic, assign) float       duration;

@property (nonatomic, assign) AudioShowTostType currentRecordState;

@end

static float timeSpace = 0.2;
static float maxRecorderDuration = 60;
@implementation RecorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLocationUI];
    [self resetState];
    
}

- (BOOL)fd_prefersNavigationBarHidden{
    
    return YES;
    
}

#pragma mark---懒加载
- (VoiceRecorderManager *)recorderManager{
    
    if (!_recorderManager) {
        _recorderManager = [[VoiceRecorderManager alloc]init];
        
    }
    return _recorderManager;
}

- (AudioShowTostView *)tostView{
    
    if (!_tostView ){
        _tostView = [[AudioShowTostView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 130)/2.0, (SCREENH_HEIGHT - 130)/2.0, 130, 130)];
        
    }
    return _tostView;
}

///初始化UI
- (void)setLocationUI{
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-30 - BDBottomHeight);
        make.width.height.mas_equalTo(20);
        
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    self.recorderBtn = btn;
    [btn rounded:30];
    btn.userInteractionEnabled = NO;
    btn.backgroundColor = redColor();
    [btn setImage:[UIImage imageNamed:@"语音发布"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"语音灰"] forState:UIControlStateSelected];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(60);
        make.bottom.equalTo(closeBtn.mas_top).offset(-60);
        
    }];
    
    UILabel *promitLab = [[UILabel alloc]init];
    promitLab.text = @"按住说话";
    promitLab.textColor = blackColor();
    promitLab.font =Font14();
    [self.view addSubview:promitLab];
    
    [promitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(btn.mas_top).offset(-20);
        
    }];
    
    [self.view addSubview:self.tostView];
    self.tostView.hidden = YES;
//    [self.tostView updateUIWithRecordState:AudioShowTostTypeReleaseToCancel];
    
}

#pragma mark---开启定时器
- (void)startTimer{
    
    if (_currentTimer) {
        [_currentTimer invalidate];
        _currentTimer = nil;
    }
    
    self.currentTimer = [NSTimer scheduledTimerWithTimeInterval:timeSpace target:self selector:@selector(onTimerTimeOut) userInfo:nil repeats:YES];
    [self.currentTimer fire];
    
}

- (void)stopTimer
{
    if (_currentTimer) {
        [_currentTimer invalidate];
        _currentTimer = nil;
    }
}

- (void)resetState
{
    [self stopTimer];
    self.duration = 0;
    self.canceled = YES;
}

- (void)onTimerTimeOut{
    self.duration += timeSpace;
//    NSLog(@"+++duration+++ %f",self.duration);
    float remainTime = maxRecorderDuration - self.duration;
    
//    CGFloat level = [self.recorderManager listenEnvironmentMusic];
//    NSLog(@"%f",level);
    
    if ((int)remainTime == 0) {
        self.currentRecordState = AudioShowTostTypeNormal;
        [self stopRecorderAction];
        [self stopTimer];
        
    }

}


#pragma mark---点击事件
- (void)closeAction{
    
    for (BaseViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[NSClassFromString(@"SendTypeOrderVC") class]]) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

- (void)openPublishVoiceVC{
    
    PublishVoiceVC *publish = [[PublishVoiceVC alloc]init];
    [self.navigationController pushViewController:publish animated:YES];
    
}

- (void)startReocrderAction{
    
    self.recorderBtn.selected = YES;
    [self.recorderManager startRecord];

}

- (void)stopRecorderAction{
    
    self.recorderBtn.selected = NO;
    [self.recorderManager stopRecorder];
    
    [self openPublishVoiceVC];
    
    
}

- (void)closeRecorderAction{
    
    self.recorderBtn.selected = NO;
    [self.recorderManager closeRecorder];
    
}

- (void)playAction{
    
    [self.recorderManager playRecordWithPath:@""];
    
}

#pragma mark---moveAction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    
    if (CGRectContainsPoint(self.recorderBtn.frame, touchPoint)) {
        
        self.currentRecordState = AudioShowTostTypeRecording;
        [self dispatchVoiceState];
        
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.canceled) {
        return;
    }
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    
    if (CGRectContainsPoint(self.recorderBtn.frame, touchPoint)) {
        
        self.currentRecordState = AudioShowTostTypeRecording;
        
    } else {
        
        self.currentRecordState = AudioShowTostTypeReleaseToCancel;
        
    }
    
    [self dispatchVoiceState];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.canceled) {
        return;
    }
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    if (CGRectContainsPoint(self.recorderBtn.frame, touchPoint)) {
        
        if (self.duration < 3) {
            self.currentRecordState = AudioShowTostTypeReleaseToShort;
            
        } else {
            
            self.currentRecordState = AudioShowTostTypeNormal;
            
        }
        
    } else {
        
        self.currentRecordState = AudioShowTostTypeReleaseToCancel;
        
    }
    
    [self touchEndAction];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.canceled) {
        return;
        
    }
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    if (CGRectContainsPoint(self.recorderBtn.frame, touchPoint)) {
        
        if (self.duration < 3) {
            self.currentRecordState = AudioShowTostTypeReleaseToShort;
            
        } else {
            
            self.currentRecordState = AudioShowTostTypeNormal;
            
        }
        
    }
    
    [self dispatchVoiceState];
    
}


- (void)dispatchVoiceState{
    if (_currentRecordState == AudioShowTostTypeRecording) {
        self.canceled = NO;
        [self startTimer];
        [self startReocrderAction];
    }
    else if (_currentRecordState == AudioShowTostTypeNormal)
    {
        [self stopTimer];
        [self resetState];
        [self stopRecorderAction];
        
    }
    
    if (self.tostView.hidden) {
        self.tostView.hidden = NO;
    }
    
    [self.tostView updateUIWithRecordState:self.currentRecordState];
}

- (void)touchEndAction{
    
    if (self.currentRecordState == AudioShowTostTypeNormal) {
        
        [self resetState];
        [self stopRecorderAction];
        
    }  else if (_currentRecordState == AudioShowTostTypeReleaseToShort ) {
    
        [self resetState];
        [self closeRecorderAction];
        [self.tostView updateUIWithRecordState:AudioShowTostTypeReleaseToShort];
    
    } else if (_currentRecordState == AudioShowTostTypeReleaseToCancel) {
    
            [self stopTimer];
            [self resetState];
            [self closeRecorderAction];
    }
    
    self.tostView.hidden = YES;
    
}

@end
