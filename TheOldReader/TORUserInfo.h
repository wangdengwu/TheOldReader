//
//  TORUserInfo.h
//  TheOldReader
//
//  Created by 王登武 on 14-5-11.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TORUserInfo : NSObject

@property BOOL isBloggerUser;
@property BOOL isMultiLoginEnabled;
@property NSDate *signupTimeSec;
@property NSString *userEmail;
@property NSString *userId;
@property NSString *userName;
@property NSString *userProfileId;

@end
