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

@interface TheOldReaderAPI (){
    NSUserDefaults *userdefaults;
}

@end

@implementation TheOldReaderAPI

- (id)init
{
    self = [super init];
    if (self) {
        userdefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

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
        //登陆时候保存下来，省去后面方法调用再次传入令牌
        [userdefaults setObject:token forKey:@"token"];
        [userdefaults synchronize];
    }];
    
    [request setFailedBlock:^{
        NSLog(@"%@",temp.responseString);
        callback(NO,nil);
    }];
    [request startAsynchronous];
}

-(void)getUserInfoWithCallback:(UserInfoCallBackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getUserInfoAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@" GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
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

-(void)getFolderTagWithCallback:(FolderTagCallBackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getFolderTagAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
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

//以下均未测试，公司xcode版本过低。。先把代码写了
-(void)removeFolder:(NSString *)folderPath callback:(RemoveFolderCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil postRemoveFolderAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    [request setValue:folderPath forKey:@"s"];
    ASIFormDataRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        callback(YES);
    }];
    
    [request setFailedBlock:^{
        callback(NO);
    }];
    [request startAsynchronous];
}

-(void)renameFolderOldPath:(NSString *)oldPath newnPath:(NSString *)newPath callback:(RenameFolderCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil postRenameFolderAPI]]];
    [request setValue:oldPath forKey:@"s"];
    [request setValue:newPath forKey:@"dest"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    ASIFormDataRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        if ([callbackText isEqualToString:@"OK"]) {
            callback(YES);
        }
    }];
    [request setFailedBlock:^{
        callback(NO);
    }];
    
}

-(void)getUnreadCountWithCallback:(UnreadCountCallBackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getUnreadCountAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    ASIHTTPRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:temp.responseData options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *unread = [dic objectForKey:@"unreadcounts"];
        callback(YES,unread);
    }];
    
    [request setFailedBlock:^{
        callback(NO,nil);
    }];
    [request startAsynchronous];
}

-(void)getSubscriptionsListWithCallback:(SubscriptionsListCallBackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil getSubscriptionsListAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    ASIHTTPRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:temp.responseData options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arr = [dic objectForKey:@"subscriptions"];
        NSMutableArray *list = [[NSMutableArray alloc] init];
        TORSubscriptionsList *subsciptions = [[TORSubscriptionsList alloc] init];
        for (int i = 0; i<arr.count; i++) {
            subsciptions.ids = [arr[i] objectForKey:@"id"];
            subsciptions.title = [arr[i] objectForKey:@"title"];
            subsciptions.categories = [arr[i] objectForKey:@"categories"];
            subsciptions.url = [arr[i] objectForKey:@"url"];
            subsciptions.htmlUrl = [arr[i] objectForKey:@"htmlUrl"];
            subsciptions.icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arr[i] objectForKey:@"iconUrl"]]]];
            [list addObject:subsciptions];
        }
        callback(YES,list);
    }];
    
    [request setFailedBlock:^{
        callback(NO,nil);
    }];
    [request startAsynchronous];
}

-(void)addSubscriptionsWithAddress:(NSString *)address callback:(AddSubscriptionCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil postAddSubscriptionAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    [request setValue:address forKey:@"quickadd"];
    ASIFormDataRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:temp.responseData options:NSJSONReadingMutableLeaves error:&error];
        if ([[dic objectForKey:@"numResults"] isEqualToString:@"1"]) {
            callback(YES);
        }else{
            callback(NO);
        }
    }];
    [request setFailedBlock:^{
        callback(NO);
    }];
    [request startAsynchronous];
}

-(void)changeSubscriptionTitleWithId:(NSString *)ids newTitle:(NSString *)title callback:(ChangeSubscriptionTitleCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil UpdatingSubscriptionAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    [request setValue:@"edit" forKey:@"ac"];
    [request setValue:ids forKey:@"id"];
    [request setValue:title forKey:@"t"];
    ASIFormDataRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        if ([temp.responseString isEqualToString:@"OK"]) {
            callback(YES);
        }else{
            callback(NO);
        }
    }];
    [request setFailedBlock:^{
        callback(NO);
    }];
    [request startAsynchronous];
}

-(void)moveSubscriptionToFolderWithId:(NSString *)ids folderPath:(NSString *)folderPath callback:(MoveSubscriptionToFolderCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil UpdatingSubscriptionAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    [request setValue:@"edit" forKey:@"ac"];
    [request setValue:ids forKey:@"id"];
    [request setValue:folderPath forKey:@"a"];
    ASIFormDataRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        if ([temp.responseString isEqualToString:@"OK"]) {
            callback(YES);
        }else{
            callback(NO);
        }
    }];
    [request setFailedBlock:^{
        callback(NO);
    }];
    [request startAsynchronous];
}

-(void)removeSubscriptionFromFolderWithId:(NSString *)ids folderPath:(NSString *)folderPath callback:(RemoveSubscriptionFromFolderCallBackBlock)callback{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil UpdatingSubscriptionAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    [request setValue:@"edit" forKey:@"ac"];
    [request setValue:ids forKey:@"id"];
    [request setValue:folderPath forKey:@"r"];
    ASIFormDataRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        if ([temp.responseString isEqualToString:@"OK"]) {
            callback(YES);
        }else{
            callback(NO);
        }
    }];
    [request setFailedBlock:^{
        callback(NO);
    }];
    [request startAsynchronous];
}

-(void)getItmeIdsWithItem:(NSString *)item getNum:(NSString *)num Callback:(AllItemsIdCallbackBlock)callback{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TheOldReaderUtil ItemsIdsAPI]]];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"GoogleLogin auth=%@",[userdefaults objectForKey:@"token"]]];
    [request setValue:item forKey:@"s"];
    [request setValue:num forKey:@"n"];
    ASIHTTPRequest *temp = request;
    [request setCompletionBlock:^{
        NSString *callbackText = temp.responseString;
        NSLog(@"%@",callbackText);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:temp.responseData options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arr = [dic objectForKey:@"itemRefs"];
        NSMutableArray *itemids = [[NSMutableArray alloc] init];
        TORItemIds *item = [[TORItemIds alloc] init];
        for (int i = 0; i<arr.count; i++) {
            item.ids = [arr[i] objectForKey:@"id"];
            item.directStreamIds = [arr[i] objectForKey:@"directStreamIds"];
            item.timestampUsec = [arr[i] objectForKey:@"timestampUsec"];
            [itemids addObject:item];
        }
        callback(YES,itemids);
    }];
    [request setFailedBlock:^{
        callback(NO,nil);
    }];
    [request startAsynchronous];
}
@end
