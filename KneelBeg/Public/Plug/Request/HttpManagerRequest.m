//
//  HttpManagerRequest.m
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import "HttpManagerRequest.h"
#import "HttpNetworkManager+LBS.h"

@implementation HttpManagerRequest

+ (void)getPhoneVirCodeWithPhoneNum:(NSString *)phoneNum WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phoneNumber"] = phoneNum;
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:getVirCode WithParametr:parameter WithFileArray:nil WithSuccessBlock:sueessBlock WithFaileBlock:faileBlock];
    
}

+ (void)UserVirCodeLoginWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:User_LoginWithCaptcha_API WithParametr:parameter WithFileArray:nil WithSuccessBlock:sueessBlock WithFaileBlock:faileBlock];
    
}

+ (void)getLBSDataWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    [HttpNetworkManager getLBSCloudDataWithUrl:Datasearch_Around_API WithParametr:parameter WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)publishOrderWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:Order_Release_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)publishOrderWithWordsWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:Voc_ReleaseOrder_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)publishRedPacketWithWordsWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:Voc_ReleaseRedPacket_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)getRedPacketDataWithOrderNo:(NSString *)orderNo WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"orderNo"] = orderNo;
    
    if ([UserModelManager userIsLogin]) {
        parameter[@"userId"] = [UserModelManager getUserId];
    }
    
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:RedPacketc_QueryDetail_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)grabRedPacketWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    if ([UserModelManager userIsLogin]) {
        parameter[@"userId"] = [UserModelManager getUserId];
        
    }
    
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:RedPacketc_Get_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)redPacketListWithORderNo:(NSString *)orderNo WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"orderNo"] = orderNo;
    
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:RedPacketc_QueryGetDetail_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)getMyRedPacketListWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [UserModelManager getUserId];
    
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:RedPacketc_MyRedPacketRecord_API WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)uploadOrderImageWithArr:(NSArray *)imageArr WithSort:(NSInteger)sort WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableArray *data = [NSMutableArray array];
    
    for (UIImage *image in imageArr) {
        
        UpLoadFileModel *model = [[UpLoadFileModel alloc]init];
        model.data = UIImageJPEGRepresentation(image, 1);
        model.fileName = [NSString stringWithFormat:@"%f.jpg",[[NSDate date] timeIntervalSince1970]];
        model.mimeType = @"image/jpeg";
        model.file = @"file";
        [data addObject:model];
        
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"fileType"] = @"image";
    parameter[@"fileClass"] = @"order";
    parameter[@"sort"] = @(sort).stringValue;
    
    [HttpNetworkManager requestMethedWithType:Post WithIsFile:YES WithUrl:File_UploadFile_API WithParametr:parameter WithFileArray:data WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

+ (void)uploadOrderAudioWithArr:(NSString *)audioPath WithSort:(NSInteger)sort WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSData *data = [NSData dataWithContentsOfFile:audioPath];
    UpLoadFileModel *model = [[UpLoadFileModel alloc]init];
    model.data = data;
    model.fileName = [NSString stringWithFormat:@"%f.mp3",[[NSDate date] timeIntervalSince1970]];
    model.mimeType = @"audio/mpeg";
    model.file = @"file";
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"fileType"] = @"audio";
    parameter[@"fileClass"] = @"order";
    parameter[@"sort"] = @(sort).stringValue;
    
    [HttpNetworkManager requestMethedWithType:Post WithIsFile:YES WithUrl:File_UploadFile_API WithParametr:parameter WithFileArray:@[model] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
    
}

@end
