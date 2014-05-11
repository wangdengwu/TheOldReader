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
    ASIFormDataRequest *temp=request;
    [request setCompletionBlock:^{
        NSString *callbackText=temp.responseString;
        NSArray *temps=[callbackText componentsSeparatedByString:@"\n"];
        NSLog(@"***************************%@",temps);
        NSString *keyToken=temps[2];//目前是第三个数据，以后不会操蛋的变吧
        NSArray *keyAndValue=[keyToken componentsSeparatedByString:@"="];
        NSLog(@"***************************%@",keyAndValue);
        NSString *token=nil;
        if (keyAndValue.count==2) {
            token=keyAndValue[1];
        }
        callback(YES,token);
    }];
    
    [request setFailedBlock:^{
        NSLog(@"%@",temp.responseString);
        callback(NO,nil);
    }];
    [request startAsynchronous];
}
@end
