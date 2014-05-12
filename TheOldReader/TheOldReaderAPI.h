//
//  TorOpenAPIService.h
//  TheOldReader
//
//  Created by 王登武 on 14-4-28.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "TORUserInfo.h"
#import "TORSubscriptionsList.h"

typedef void (^LoginCallBackBlock)(BOOL isSucess, NSString* authToken);
typedef void (^UserInfoCallBackBlock)(BOOL isSucess, TORUserInfo* userInfo);
typedef void (^FolderTagCallBackBlock)(BOOL isSucess, NSMutableArray *folderList);
typedef void(^RemoveFolderCallBackBlock) (BOOL isSucess);
typedef void(^UnreadCountCallBackBlock) (BOOL isSucess, NSDictionary *unread);
typedef void(^RenameFolderCallBackBlock) (BOOL isSucess);
typedef void(^SubscriptionsListCallBackBlock) (BOOL isSucess, NSMutableArray *subscriptionsList);


@interface TheOldReaderAPI : NSObject

-(void)doLogin:(NSString*)userName password:(NSString*)password callback:(LoginCallBackBlock)callback;

-(void)getUserInfoWithCallback:(UserInfoCallBackBlock)callback;

-(void)getFolderTagWithCallback:(FolderTagCallBackBlock)callback;

-(void)RemoveFolder:(NSString *)folderPath callback:(RemoveFolderCallBackBlock)callback;

-(void)RenameFolderOldPath:(NSString *)oldPath newnPath:(NSString *)newPath callback:(RenameFolderCallBackBlock)callback;

-(void)getUnreadCountWithCallback:(UnreadCountCallBackBlock)callback;

-(void)getSubscriptionsListWithCallback:(SubscriptionsListCallBackBlock)callback;


@end
