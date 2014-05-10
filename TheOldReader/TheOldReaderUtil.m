//
//  TheOldReaderUtil.m
//  TheOldReader
//
//  Created by 王登武 on 14-5-10.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import "TheOldReaderUtil.h"
static NSDictionary* apis;
@implementation TheOldReaderUtil

+(NSString*)getLoginAPI{
    if (!apis) {
        NSString* plist=[[NSBundle mainBundle] pathForResource:@"OpenAPI" ofType:@"plist"];
        apis=[[NSDictionary alloc] initWithContentsOfFile:plist];
    }
    return [apis objectForKey:@"Login"];
}

+(NSString *)getUserInfoAPI{
    return [apis objectForKey:@"UserInfo"];
}

+(NSString *)getFolderTagAPI{
    return [apis objectForKey:@"FolderTag"];
}

+(NSString *)postRenameFolderAPI{
    return [apis objectForKey:@"RenameFolder"];
}

+(NSString *)postRemoveFolderAPI{
    return [apis objectForKey:@"RemoveFolder"];
}

+(NSString *)getUnreadCountAPI{
    return [apis objectForKey:@"UnreadCount"];
}

+(NSString *)getSubscriptionsListAPI{
    return [apis objectForKey:@"SubscriptionsList"];
}

+(NSString *)getSubscriptionsOPMLAPI{
    return [apis objectForKey:@"SubscriptionsOPML"];
}

+(NSString *)postAddSubscriptionAPI{
    return [apis objectForKey:@"AddSubscription"];
}

+(NSString *)postChangeSubscriptionTitleAPI{
    return [apis objectForKey:@"ChangeSubscriptionTitle"];
}

+(NSString *)postMoveSubscriptionToFolderAPI{
    return [apis objectForKey:@"MoveSubscriptionToFolder"];
}

+(NSString *)postMoveSubscriptionToDefaultFolderAPI{
    return [apis objectForKey:@"MoveSubscriptionToDefaultFolder"];
}

+(NSString *)postRemoveSubscriptionAPI{
    return [apis objectForKey:@"RemoveSubscription"];
}

+(NSString *)getAllItemsIdsAPI{
    return [apis objectForKey:@"AllItemsIds"];
}

+(NSString *)getStarredItemsAPI{
    return [apis objectForKey:@"StarredItems"];
}














@end
