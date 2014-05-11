//
//  TheOldReaderTests.m
//  TheOldReaderTests
//
//  Created by 王登武 on 14-5-10.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TheOldReaderAPI.h"

@interface TheOldReaderTests : XCTestCase{
    TheOldReaderAPI * api;
}

@end

@implementation TheOldReaderTests

- (void)setUp
{
    [super setUp];
    api=[[TheOldReaderAPI alloc]init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin
{
    [api doLogin:@"dengwu.wang@gmail.com" password:@"qwer123" callback:^(BOOL isSucess, NSString *authToken) {
        XCTAssertTrue(isSucess, @"测试登录成功");
        XCTAssertNotNil(authToken, @"如果登录成功返回的authToken不能为nil");
        NSLog(@"%@",authToken);
    }];
    //加异步等待，防止请求还未返回，进程已经退出
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:20]];
}

@end
