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

#define APP_NAME @"alireader"

@implementation TheOldReaderAPI

-(void)doLogin:(NSString*)userName password:(NSString*)password callback:(LoginCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getLoginAPI]]];
    [request setPostValue:APP_NAME forKey:@"client"];
    [request setPostValue:@"HOSTED_OR_GOOGLE" forKey:@"accountType"];
    [request setPostValue:@"reader" forKey:@"service"];
    [request setPostValue:[userName copy] forKey:@"Email"];
    [request setPostValue:[password copy] forKey:@"Passwd"];
    [request setCompletionBlock:^{
        NSString *callbackText=request.responseString;
        NSArray *temps=[callbackText componentsSeparatedByString:@"\n"];
        NSLog(@"***************************%@",temps);
        callback(YES,@"123sdasd");
    }];
    
    [request setFailedBlock:^{
        NSLog(@"%@",request.responseString);
        callback(NO,nil);
    }];
    [request startSynchronous];
}
@end
