//
//  TorOpenAPIService.m
//  TheOldReader
//
//  Created by 王登武 on 14-4-28.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import "TheOldReaderAPI.h"
#import "ASIFormDataRequest.h"
#import "TheOldReaderUtil.h"

@implementation TheOldReaderAPI

-(void)doLogin:(NSString*)userName password:(NSString*)password callback:(CallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getLoginAPI]]];
    [request setPostValue:@"theoldreader" forKey:@"client"];
    [request setPostValue:@"HOSTED_OR_GOOGLE" forKey:@"accountType"];
    [request setPostValue:@"reader" forKey:@"service"];
    [request setPostValue:[userName copy] forKey:@"Email"];
    [request setPostValue:[password copy] forKey:@"Passwd"];
    [request setCompletionBlock:^{
        callback(YES,request);
    }];
    [request setFailedBlock:^{
        callback(NO,request);
    }];
    [request startAsynchronous];
}
@end
