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

@end
