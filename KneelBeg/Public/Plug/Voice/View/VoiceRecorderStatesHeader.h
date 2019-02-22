//
//  VoiceRecorderStatesHeader.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/22.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#ifndef VoiceRecorderStatesHeader_h
#define VoiceRecorderStatesHeader_h

typedef NS_ENUM(NSInteger ,AudioShowTostType ) {
    
    AudioShowTostTypeNormal,        //初始状态
    AudioShowTostTypeRecording,     //正在录音
    AudioShowTostTypeReleaseToCancel, //上滑取消（也在录音状态，UI显示有区别）
    AudioShowTostTypeReleaseToShort //录音时间太短
};

#endif /* VoiceRecorderStatesHeader_h */
