//
//  Login.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/5.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "Login.h"
#import "YUTimer.h"
#import <JMessage/JMessage.h>
#import <JPUSHService.h>

@interface Login ()

@property (nonatomic, strong) UITextField   *phoneTextF;
@property (nonatomic, strong) UITextField   *virCodeTextF;
@property (nonatomic, strong) UIButton      *sendBtn;
@property (nonatomic, strong) YUTimer       *yutTimer;
@property (nonatomic, assign) NSInteger     totalCount;
@property (nonatomic, strong) UIButton      *clearBtn;
@property (nonatomic, strong) UIButton      *loginBtn;
///光标的位置
@property (nonatomic, assign) NSInteger     i;

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.i = 0;
    self.totalCount = 60;
    [self setLocationUI];
    
}

- (void)setLocationUI{
    
    UIImageView *topImagV = [[UIImageView alloc]init];
    topImagV.image = [UIImage imageNamed:@"跪求标题"];
    [self.view addSubview:topImagV];
    
    [topImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(70);
        make.centerX.equalTo(self.view);
        
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topImagV);
        make.right.equalTo(self.view).offset(-20);
        make.height.width.mas_equalTo(44);
        
    }];
    
    [self.view addSubview:self.phoneTextF];
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImagV.mas_bottom).offset(80);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(36);
        
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = HexColor(@"ebebeb");
    [self.view addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.phoneTextF);
        make.bottom.equalTo(self.phoneTextF.mas_bottom);
        make.height.mas_equalTo(1);
        
    }];
    
    UIButton *clearBtn = [[UIButton alloc]init];
    [clearBtn setImage:[UIImage imageNamed:@"输入删除"] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearTextAction) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn = clearBtn;
    self.clearBtn.hidden = YES;
    [self.view addSubview:clearBtn];
    
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.phoneTextF);
        make.right.equalTo(self.phoneTextF);
        make.width.height.mas_equalTo(20);
        
    }];
    
    [self.view addSubview:self.virCodeTextF];
    [self.virCodeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.phoneTextF.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = HexColor(@"ebebeb");
    [self.view addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.virCodeTextF);
        make.bottom.equalTo(self.virCodeTextF.mas_bottom);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.view addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.virCodeTextF);
        make.right.equalTo(self.virCodeTextF);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(24);
        
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    loginBtn.backgroundColor = redColor();
    loginBtn.titleLabel.font = Font15();
    [loginBtn rounded:4];
    self.loginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(compeletAction) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.enabled = NO;
    [self.view addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line2).offset(80);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"未注册的手机号验证后即完成注册";
    label1.textColor = HexColor(@"b9b9b9");
    label1.font = Font15();
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.left.equalTo(loginBtn);
        
    }];

}

#pragma mark---懒加载
- (UITextField *)phoneTextF{
    
    if (!_phoneTextF) {
        _phoneTextF = [[UITextField alloc]init];
        _phoneTextF.placeholder = @"请输入手机号";
        _phoneTextF.textColor = blackColor();
        _phoneTextF.font = Font16();
        _phoneTextF.tintColor = blackColor();
        _phoneTextF.keyboardType = UIKeyboardTypePhonePad;
        [_phoneTextF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _phoneTextF;
}

- (UITextField *)virCodeTextF{
    
    if (!_virCodeTextF) {
        _virCodeTextF = [[UITextField alloc] init];
        _virCodeTextF.placeholder = @"输入验证码";
        _virCodeTextF.textColor = blackColor();
        _virCodeTextF.font = Font16();
        _virCodeTextF.tintColor = blackColor();
        _virCodeTextF.keyboardType = UIKeyboardTypePhonePad;
        [_virCodeTextF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _virCodeTextF;
}

- (UIButton *)sendBtn{
    
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]init];
        [_sendBtn setTitle:@"输入验证码" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:redColor() forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = Font16();
        [_sendBtn addTarget:self action:@selector(getVirCode) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sendBtn;
}

- (YUTimer *)yutTimer{
    
    if (!_yutTimer) {
        _yutTimer = [[YUTimer alloc]init];
        
    }
    return _yutTimer;
}


#pragma mark---事件处理
///开启定时器
- (void)startTimer{
    
    self.sendBtn.enabled = NO;
    LRWeakSelf(self);
    [self.yutTimer startTimerWithSpace:1 block:^{
        LRStrongSelf(self);
        
        if (self.totalCount >= 0) {
            
            [self.sendBtn setTitle:[NSString stringWithFormat:@"剩余 %lds",self.totalCount] forState:UIControlStateDisabled];
            
        } else {
            
            self.sendBtn.enabled = YES;
            [self.sendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            [self.yutTimer stopTimer];
            
        }
        
        self.totalCount -- ;
        
    }];
    
}


-(void)textFieldDidEditing:(UITextField *)textField{
    
    if (textField == self.phoneTextF) {
        
        if ([Util isBlankString:textField.text]) {
            
            self.clearBtn.hidden = YES;
            
        } else {
            
            self.clearBtn.hidden = NO;
            
        }
        
        if (textField.text.length > self.i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
            }
            self.i = textField.text.length;
            
        }else if (textField.text.length < self.i){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            self.i = textField.text.length;
        }
    }
    
    if (![Util isBlankString:self.phoneTextF.text] && self.virCodeTextF.text.length == 6) {
        
        self.loginBtn.enabled = YES;
        
    } else {
        
        self.loginBtn.enabled = NO;
        
    }
    
}

- (void)clearTextAction{
    
    self.phoneTextF.text = @"";
    
}

#pragma mark---网络请求
///获取验证码
- (void)getVirCode{
    
    if ([Util isBlankString:self.phoneTextF.text]) {
        
        [JKRemindView showReminderString:@"手机号不能为空"];
        return;
        
    }
    
    if (![Util iSMobilePhone:[self.phoneTextF.text stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
        
        [JKRemindView showReminderString:@"手机号格式不对"];
        return;
        
    }
    
    [self startTimer];
    [HttpManagerRequest getPhoneVirCodeWithPhoneNum:[self.phoneTextF.text stringByReplacingOccurrencesOfString:@" " withString:@""] WithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSString *ok = [Util getJsonResultState:dic];
        NSString *msg = dic[@"data"][@"message"];
        
        if ([ok isEqualToString:successKey]) {
            
            [JKRemindView showReminderString:@"验证码发送成功"];
            
        } else {
            
            [JKRemindView showReminderString:msg];
            
        }
        
    } WithFaileBlock:^(id result) {
        
    }];
    
}

///登录
- (void)compeletAction{
    
    if ([Util isBlankString:self.virCodeTextF.text]) {
        
        [JKRemindView showReminderString:@"验证码不能为空"];
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"username"] = [self.phoneTextF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    parameter[@"captcha"] = self.virCodeTextF.text;
    parameter[@"loginType"] = @"2";
    [HttpManagerRequest UserVirCodeLoginWithParameter:parameter WithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSString *ok = [Util getJsonResultState:dic];
        NSString *resMsg = [Util getJsonMessage:dic];
        
        if ([ok isEqualToString:successKey]) {
            
            [JKRemindView showReminderString:resMsg];
            [UserModelManager saveUserData:dic];
            
            [JPUSHService setAlias:[UserModelManager getUserOrderNO] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
                NSLog(@"%ld ===iResCode=== %@",iResCode, iAlias);
                
            } seq:0];
            
            
            [JMSGUser registerWithUsername:[UserModelManager getUserOrderNO] password:[UserModelManager getUserOrderNO] completionHandler:^(id resultObject, NSError *error) {
                
                [self loginJMessageAction];
                
            }];
            
        } else {
            [JKRemindView showReminderString:resMsg];
            
        }
        
    } WithFaileBlock:^(id result) {
        
    }];
    
}

///关闭
- (void)closeAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loginJMessageAction{

    [JMSGUser loginWithUsername:[UserModelManager getUserOrderNO] password:[UserModelManager getUserOrderNO] completionHandler:^(id resultObject, NSError *error) {
        
        if (error) {
            
        } else {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }];
    
}

@end
