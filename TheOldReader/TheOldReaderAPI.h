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

typedef void (^LoginCallBackBlock)(BOOL isSucess,NSString* authToken);

typedef void (^UserInfoCallBackBlock)(BOOL isSucess,TORUserInfo* userInfo);

typedef void (^FolderTagCallBackBlock)(BOOL isSucess,NSMutableArray *folderList);



@interface TheOldReaderAPI : NSObject


-(void)doLogin:(NSString*)userName password:(NSString*)password callback:(LoginCallBackBlock)callback;

-(void)getUserInfo:(NSString*)token callback:(UserInfoCallBackBlock)callback;

-(void)getFolderTag:(NSString *)token callback:(FolderTagCallBackBlock)callback;


@end
