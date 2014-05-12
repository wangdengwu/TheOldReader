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

+(void)load{
    if (!apis) {
        NSString* plist=[[NSBundle bundleForClass:[self class] ] pathForResource:@"OpenAPI" ofType:@"plist"];
        apis=[[NSDictionary alloc] initWithContentsOfFile:plist];
    }
}
+(NSString*)getLoginAPI{
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

+(NSString *)UpdatingSubscriptionAPI{
    return [apis objectForKey:@"UpdatingSubscription"];
}

+(NSString *)getAllItemsIdsAPI{
    return [apis objectForKey:@"ItemsIds"];
}

+(NSString *)postItemsContentAPI{
    return [apis objectForKey:@"ItemContents"];
}

+(NSString *)getItemsContentAPI{
    return [apis objectForKey:@"ItemContents2"];
}

+(NSString *)postMarkingallasreadAPI{
    return [apis objectForKey:@"Markingallasread"];
}

+(NSString *)postUpdatingitemsAPI{
    return [apis objectForKey:@"Updatingitems"];
}
@end
