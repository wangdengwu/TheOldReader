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
#import "TORItemIds.h"

typedef void (^LoginCallBackBlock)(BOOL isSucess, NSString* authToken);
typedef void (^UserInfoCallBackBlock)(BOOL isSucess, TORUserInfo* userInfo);
typedef void (^FolderTagCallBackBlock)(BOOL isSucess, NSMutableArray *folderList);
typedef void(^RemoveFolderCallBackBlock) (BOOL isSucess);
typedef void(^UnreadCountCallBackBlock) (BOOL isSucess, NSDictionary *unread);
typedef void(^RenameFolderCallBackBlock) (BOOL isSucess);
typedef void(^SubscriptionsListCallBackBlock) (BOOL isSucess, NSMutableArray *subscriptionsList);
typedef void(^AddSubscriptionCallBackBlock) (BOOL isSucess);
typedef void(^ChangeSubscriptionTitleCallBackBlock) (BOOL isSucess);
typedef void(^MoveSubscriptionToFolderCallBackBlock) (BOOL isSuccess);
typedef void(^RemoveSubscriptionFromFolderCallBackBlock) (BOOL isSuccess);
typedef void(^AllItemsIdCallbackBlock) (BOOL isSuccess, NSMutableArray *allImtes);

@interface TheOldReaderAPI : NSObject

-(void)doLogin:(NSString*)userName password:(NSString*)password callback:(LoginCallBackBlock)callback;

-(void)getUserInfoWithCallback:(UserInfoCallBackBlock)callback;

-(void)getFolderTagWithCallback:(FolderTagCallBackBlock)callback;

-(void)removeFolder:(NSString *)folderPath callback:(RemoveFolderCallBackBlock)callback;

-(void)renameFolderOldPath:(NSString *)oldPath newnPath:(NSString *)newPath callback:(RenameFolderCallBackBlock)callback;

-(void)getUnreadCountWithCallback:(UnreadCountCallBackBlock)callback;

-(void)getSubscriptionsListWithCallback:(SubscriptionsListCallBackBlock)callback;

-(void)addSubscriptionsWithAddress:(NSString *)address callback:(AddSubscriptionCallBackBlock)callback;

-(void)changeSubscriptionTitleWithId:(NSString *)ids newTitle:(NSString *)title callback:(ChangeSubscriptionTitleCallBackBlock)callback;

-(void)moveSubscriptionToFolderWithId:(NSString *)ids folderPath:(NSString *)folderPath callback:(MoveSubscriptionToFolderCallBackBlock)callback;

-(void)removeSubscriptionFromFolderWithId:(NSString *)ids folderPath:(NSString *)folderPath callback:(RemoveSubscriptionFromFolderCallBackBlock)callback;
/*
 # All items                                                # Starred items
 s=user/-/state/com.google/reading-list                     s=user/-/state/com.google/starred
 
 # Read items                                               # Folder
 s=user/-/state/com.google/read                             s=user/-/label/...
 
 # Subscription                                             # Only unread
 s=feed/...                                                 xt=user/-/state/com.google/read
 
 # Limit items
 n=20
 */
-(void)getItmeIdsWithItem:(NSString *)item getNum:(NSString *)num Callback:(AllItemsIdCallbackBlock)callback;

@end
