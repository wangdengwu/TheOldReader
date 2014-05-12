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
    [api getUserInfoWithCallback:^(BOOL isSucess, TORUserInfo *userInfo) {
        XCTAssertTrue(isSucess, @"获取用户信息成功");
        XCTAssertNotNil(userInfo, @"如果获取用户信息成功，userInfo不能为nil");
        NSLog(@"%@",userInfo);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run=NO;
    }];
}

-(void)testFolderTag
{
    [api getFolderTagWithCallback:^(BOOL isSucess, NSMutableArray *folderList) {
        XCTAssertTrue(isSucess, @"获取文件夹列表成功");
        XCTAssertNotNil(folderList, @"存有列表的数组");
        NSLog(@"%@",folderList);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testRemoveFolder{
    [api removeFolder:@"user/-/label/123" callback:^(BOOL isSucess) {
        XCTAssertTrue(isSucess, @"删除成功");
        NSLog(@"%hhd",isSucess);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testUnreadCount{
    [api getUnreadCountWithCallback:^(BOOL isSucess, NSDictionary *unread) {
        XCTAssertTrue(isSucess, @"获取未读文章数量成功");
        XCTAssertNotNil(unread, @"存有信息");
        NSLog(@"%@",unread);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testRenameFolder{
    [api renameFolderOldPath:@"user/-/label/1234" newnPath:@"user/-/label/12345" callback:^(BOOL isSucess) {
        XCTAssertTrue(isSucess, @"修改成功");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testSubscriptionsList{
    [api getSubscriptionsListWithCallback:^(BOOL isSucess, NSMutableArray *subscriptionsList) {
        XCTAssertTrue(isSucess, @"获取成功");
        XCTAssertNotNil(subscriptionsList, @"存有数据");
        NSLog(@"%@",subscriptionsList);
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testAddSubscription{
    [api addSubscriptionsWithAddress:@"beyondvincent.com/atom.xml" callback:^(BOOL isSucess) {
        XCTAssertTrue(isSucess, @"添加成功");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testChangeSubTitle{
    [api changeSubscriptionTitleWithId:@"feed/53577c10fea0e7b4e5000c0b" newTitle:@"title" callback:^(BOOL isSucess) {
        XCTAssertTrue(isSucess, @"修改成功");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testRemoveSubscriptionFromFolder{
    [api removeSubscriptionFromFolderWithId:@"feed/53577c10fea0e7b4e5000c0b" folderPath:@"user/-/label/12345" callback:^(BOOL isSuccess) {
        XCTAssertTrue(isSuccess, @"修改成功");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testAllitems{
    [api getItmeIdsWithItem:@"user/-/state/com.google/reading-list" getNumber:@"20" callback:^(BOOL isSuccess, NSMutableArray *allImtes){
        XCTAssertTrue(isSuccess, @"获取成功");
        XCTAssertNotNil(allImtes, @"数组不为空");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}

-(void)testItemContent{
    [api itemContentWithId:@"5358755dfea0e78f1200079d" callback:^(BOOL isSuccess, NSMutableArray *itemContent) {
        XCTAssertTrue(isSuccess, @"获取成功");
        XCTAssertNotNil(itemContent, @"数组不为空");
        CFRunLoopStop([runLoop getCFRunLoop]);
        run = NO;
    }];
}
@end
