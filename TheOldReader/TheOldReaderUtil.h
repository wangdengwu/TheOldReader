//
//  TheOldReaderUtil.h
//  TheOldReader
//
//  Created by 王登武 on 14-5-10.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheOldReaderUtil : NSObject

+(NSString *)getLoginAPI;

+(NSString *)getUserInfoAPI;

+(NSString *)getFolderTagAPI;

/*
 * @brief  修改文件夹名称
 
 * @param  s  旧文件路径（user/-/label/Folder）
 * @param  dest  新文件夹路径（user/-/label/NewFolder）
 */
+(NSString *)postRenameFolderAPI;

/*
 * @brief  删除文件夹
 
 * @param  s  文件夹路径（user/-/label/Folder）
 */
+(NSString *)postRemoveFolderAPI;

/*
 * @brief  获取未读文章数量
 */
+(NSString *)getUnreadCountAPI;

/*
 * @brief  获取订阅源列表
 */
+(NSString *)getSubscriptionsListAPI;

/*
 * @brief  导出OPML
 */
+(NSString *)getSubscriptionsOPMLAPI;

/*
 * @brief  添加新的订阅源
 
 * @param  quickadd  源地址
 */
+(NSString *)postAddSubscriptionAPI;

/*
 * @brief  修改源名称
 
 * @param  s  源id
 * @param  t  新名称
 */
+(NSString *)UpdatingSubscriptionAPI;

/*
 * @brief  将订阅源移动到文件夹
 
 * @param  s  源id
 * @param  a  文件夹路径（user/-/label/Folder）
 */
//+(NSString *)postMoveSubscriptionToFolderAPI;

/*
 * @brief  将订阅源移动到默认文件夹（从自定义文件夹内移除）
 
 * @param  s  源id
 * @param  r  文件夹路径（user/-/label/Folder）
 */
//+(NSString *)postMoveSubscriptionToDefaultFolderAPI;

/*
 * @brief  将订阅源移动到默认文件夹（从自定义文件夹内移除）
 
 * @param  s  源id
 */
//+(NSString *)postRemoveSubscriptionAPI;

/*
 * @brief  获取所有文章的id
 
 * @param  n  每次请求的个数
 */
+(NSString *)getItemsIdsAPI;

/*
 * @brief  通过id获取文章内容
 
 * @param  i  id
 */
+(NSString *)postItemsContentAPI;

+(NSString *)getStreamContentsAPI;

+(NSString *)postMarkingallasreadAPI;

+(NSString *)postUpdatingitemsAPI;

@end
