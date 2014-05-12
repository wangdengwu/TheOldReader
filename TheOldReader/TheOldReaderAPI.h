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
typedef void(^ItemContentCallbackBlock) (BOOL isSuccess, NSMutableArray *itemContent);
typedef void(^StreamContentCallbackBlock) (BOOL isSuccess, NSMutableArray *Content);
typedef void(^MakeAsAllreadCallbackBlock) (BOOL isSuccess);
typedef void(^UpdatingitemsCallbackBlock) (BOOL isSuccess);

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
#warning 需要进一步完善，应该直接返回标题、内容，而不是只返回id，如果只返回id，在使用的过程，又要多调用一次方法
-(void)getItmeIdsWithItem:(NSString *)item getNumber:(NSString *)number callback:(AllItemsIdCallbackBlock)callback;
#warning 回去看到输出了在完善，数据有点大。。看不出解析后的，太乱了，不好找。。
-(void)itemContentWithId:(NSString *)ids callback:(ItemContentCallbackBlock)callback;

/*
 #stream
 
 -  feed/00157a17b192950b65be3791
 
 -  user/-/state/com.google/read
 
 -  user/-/label/Folder
 */
-(void)getStreamContentstWithStream:(NSString *)Stream getNumber:(NSString *)number callback:(StreamContentCallbackBlock)callback;

/*
 # All items
 s=user/-/state/com.google/reading-list
 
 # Folder
 s=user/-/label/...
 
 # Subscription
 s=feed/...
 */
-(void)makeasAllreadWithParam:(NSString *)param callback:(MakeAsAllreadCallbackBlock)callback;

/*
 @ param state YES是添加 NO是移除
 @ param star YES是星标 NO是阅读
 */
-(void)UpdatingitemsWithId:(NSString *)ids state:(BOOL)state star:(BOOL)star callback:(UpdatingitemsCallbackBlock)callback;
@end
