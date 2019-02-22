//
//  VoiceRecorderManager.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoiceRecorderManager : NSObject

- (void)startRecord;

- (void)stopRecorder;

- (void)closeRecorder;

- (void)playRecordWithPath:(NSString *)path;

- (CGFloat)listenEnvironmentMusic;

@end

NS_ASSUME_NONNULL_END
