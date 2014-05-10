//
//  TorOpenAPIService.h
//  TheOldReader
//
//  Created by 王登武 on 14-4-28.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheOldReaderAPI : NSObject

-(void)doLogin:(NSString*)userName password:(NSString*)password callback:(CallBackBlock)callback;

@end
