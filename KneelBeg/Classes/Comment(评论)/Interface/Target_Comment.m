//
//  Target_Comment.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "Target_Comment.h"
#import "CommentVC.h"

@implementation Target_Comment

- (UIViewController *)Action_gotoCommentVC:(NSDictionary *)params{
    
    CommentVC *comment = [[CommentVC alloc]init];
    comment.commitId = [params[@"commitId"] integerValue];
    return comment;
    
}

@end
