//
//  JKRemindView.h
//  jike
//
//  Created by 上海荣豫资产 on 2018/5/29.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ReminderType) {
    
    ReminderTypeCompelet = 0,
    ReminderTypeFalied  = 1,
    ReminderTypeWaring  = 2,
    ReminderTypeSuccess = 3
    
    
};
@interface JKRemindView : UIView


+ (void)showReminderString:(NSString *)reminderStr;

@end
