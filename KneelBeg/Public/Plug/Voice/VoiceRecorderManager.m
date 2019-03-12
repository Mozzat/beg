//
//  VoiceRecorderManager.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "VoiceRecorderManager.h"
#import <AVFoundation/AVFoundation.h>
#import "lame.h"

@interface VoiceRecorderManager ()

@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer   *player;
@property (nonatomic, copy)   NSString        *file;

@end

@implementation VoiceRecorderManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sesssionError = nil;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sesssionError];
        
        if (session == nil) {
            
            NSLog(@"Error creating session: %@",[sesssionError description]);
            
        } else {
            
            [session setActive:YES error:nil];
            
        }
        
        self.session = session;
        
        ///获取沙盒地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingString:@"/Audio"];
        NSLog(@"%@",filePath);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:filePath]) {
            
            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
            
        } else {
            
            NSLog(@"文件目录已存在");
            
        }
        self.file = filePath;
        
        NSDate *currentDate = [NSDate date];
        NSString *fileName = [NSString stringWithFormat:@"%.f.wav", [currentDate timeIntervalSince1970] * 1000];
        NSString *fileTotalPath = [self.file stringByAppendingPathComponent:fileName];
        self.filePath = fileTotalPath;
        
        //录音设置
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
        //设置录音格式
        [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
        //采样率 采样率必须要设为11025才能使转化成mp3格式后不会失真
        [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
        //通道数要转换成MP3格式必须为双通道
        [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
        
        //音频质量,采样质量
        [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
        
        //创建录音对象
        self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:fileTotalPath] settings:recordSettings error:nil];
        
        [self.recorder prepareToRecord];
        
    }
    return self;
}

- (CGFloat)listenEnvironmentMusic{
    
    [self.recorder updateMeters];
    float level = 0;
    float minDecibels = -80.0f;
    float decibels    = [self.recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels)
    {
        level = 0.0f;
    }
    else if (decibels >= 0.0f)
    {
        level = 1.0f;
    }
    else
    {
        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * decibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }

    return level * 5;
    
}

- (void)startRecord{
    
    [self.recorder record];
    
}

- (void)stopRecorder{
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    [self audio_PCMtoMP3];
    
}

- (void)closeRecorder{
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
}

//录音文件转码
- (void)audio_PCMtoMP3
{
    NSString *recorderSavePath = [self.filePath stringByReplacingOccurrencesOfString:@"wav" withString:@"mp3"];
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([self.filePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([recorderSavePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSLog(@"MP3生成成功: %@",recorderSavePath);

    }
    
}

- (void)playRecordWithPath:(NSString *)path{
    
    if ([self.player isPlaying])return;
    
    NSURL *url = [NSURL URLWithString:[self.filePath stringByReplacingOccurrencesOfString:@"wav" withString:@"mp3"]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    NSLog(@"%li",self.player.data.length/1024);
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
    
}

@end
