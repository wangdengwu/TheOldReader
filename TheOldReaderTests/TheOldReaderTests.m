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
    NSRunLoop* runLoop;
    __block BOOL run;
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
    runLoop=[NSRunLoop currentRunLoop];
    run=YES;
    //加异步等待，防止请求还未返回，进程已经退出
    while (run) {
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)testLogin
{
    
    [api doLogin:@"370802756@qq.com" password:@"3235967" callback:^(BOOL isSucess, NSString *authToken) {
        XCTAssertTrue(isSucess, @"测试登录成功");
        XCTAssertNotNil(authToken, @"如果登录成功返回的authToken不能为nil");
        NSLog(@"%@",authToken);
        XCTAssertEqualObjects(@"jEMAfbMXzy657p9X1LUH", authToken, @"authToken不对");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run=NO;
    }];
    
}

-(void)testUserInfo
{
    [api getUserInfo:@"jEMAfbMXzy657p9X1LUH" callback:^(BOOL isSucess, TORUserInfo *userInfo) {
        XCTAssertTrue(isSucess, @"获取用户信息成功");
        XCTAssertNotNil(userInfo, @"如果获取用户信息成功，userInfo不能为nil");
        NSLog(@"%@",userInfo);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run=NO;
    }];
}

-(void)testFolderTag
{
    [api getFolderTag:@"PPgr7anpZchq1YpBDGuP" callback:^(BOOL isSucess, NSMutableArray *folderList) {
        XCTAssertTrue(isSucess, @"获取文件夹列表成功");
        XCTAssertNotNil(folderList, @"存有列表的数组");
        NSLog(@"%@",folderList);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}
@end
