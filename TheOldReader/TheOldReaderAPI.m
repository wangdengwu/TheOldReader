//
//  TorOpenAPIService.m
//  TheOldReader
//
//  Created by 王登武 on 14-4-28.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import "TheOldReaderAPI.h"
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

-(void)getUserInfo:(NSString*)token callback:(UserInfoCallBackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getUserInfoAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@" GoogleLogin auth=%@",token]];
    ASIHTTPRequest *temp=request;
    [request setCompletionBlock:^{
        NSString *callbackText=temp.responseString;
        NSLog(@"***************************%@",callbackText);
        NSError *error;
        NSDictionary *info=[NSJSONSerialization JSONObjectWithData:[temp responseData] options:NSJSONReadingMutableLeaves error:&error];
        TORUserInfo *userInfo=[[TORUserInfo alloc]init];
        userInfo.isBloggerUser=[[info objectForKey:@"isBloggerUser"] boolValue];
        userInfo.userEmail=[info objectForKey:@"userEmail"];
        userInfo.userId=[info objectForKey:@"userId"];
        userInfo.userName=[info objectForKey:@"userName"];
        userInfo.userProfileId=[info objectForKey:@"userProfileId"];
        userInfo.isMultiLoginEnabled=[[info objectForKey:@"isMultiLoginEnabled"]boolValue];
        if (error) {
            callback(NO,nil);
        }else{
            callback(YES,userInfo);//需要copy
        }
    }];
    
    [request setFailedBlock:^{
        NSLog(@"%@",temp.responseString);
        callback(NO,nil);
    }];
    [request startAsynchronous];
}

-(void)getFolderTag:(NSString *)token callback:(FolderTagCallBackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getFolderTagAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",token]];
    ASIHTTPRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"***************************%@",callbackText);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:temp.responseData options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arr = [dic objectForKey:@"tags"];
        NSMutableArray *folderTag = [[NSMutableArray alloc] init];
        for (int i = 0; i<arr.count; i++) {
            if (i == 0) {
                //系统默认的starred文件夹路径多一层
                NSString *folderPath = [[arr objectAtIndex:i] objectForKey:@"id"];
                NSArray *titleArr = [folderPath componentsSeparatedByString:@"/"];
                NSString *title = titleArr[4];
                [folderTag addObject:title];
            }else{
                NSString *folderPath2 = [[arr objectAtIndex:i] objectForKey:@"id"];
                NSArray *titleArr2 = [folderPath2 componentsSeparatedByString:@"/"];
                NSString *title2 = titleArr2[3];
                [folderTag addObject:title2];
            }
        }
        callback(YES,folderTag);
    }];
    [request setFailedBlock:^{
        callback(NO,nil);
    }];
    [request startAsynchronous];
}






















@end
