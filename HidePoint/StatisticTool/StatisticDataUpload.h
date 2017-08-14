//
//  StatisticDataUpload.h
//  HidePoint
//
//  Created by zhanfeng on 2017/8/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>

//对应plist配置表中的采集类型
#define PAGE_DISPLAY_KEY @"PageDisplay"
#define ACTION_ENENT_KEY @"ActionEvent"

@interface StatisticDataUpload : NSObject
#pragma mark - ViewController display statistic
+(void)gatherVCWithPageID:(NSString *)pageID;
#pragma mark - Action Statistic
+(void)gatherActionWithEventID:(NSString *)actionID;
#pragma mark - config plist data
+(NSDictionary *)IDConfigPlist;
@end
