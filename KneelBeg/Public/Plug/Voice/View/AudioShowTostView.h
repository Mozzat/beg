//
//  AudioShowTostView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/22.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceRecorderStatesHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioShowTostView : UIView

- (void)updateUIWithRecordState:(AudioShowTostType)state;

- (void)showVoiceImage;

@end

NS_ASSUME_NONNULL_END
