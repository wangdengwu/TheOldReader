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
    __block BOOL yes;
    __block NSString *test;
    [api doLogin:@"dengwu.wang@gmail.com" password:@"qwer123" callback:^(BOOL isSucess, NSString *authToken) {
        yes=isSucess;
        test=authToken;
    }];
    NSLog(@"%@",yes?@"YES":@"NO");
    NSLog(@"%@",test);
}

@end
