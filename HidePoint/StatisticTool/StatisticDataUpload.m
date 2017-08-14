//
//  StatisticDataUpload.m
//  HidePoint
//
//  Created by zhanfeng on 2017/8/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "StatisticDataUpload.h"

@implementation StatisticDataUpload
#pragma mark - ViewController display statistic

+(void)gatherVCWithPageID:(NSString *)pageID{
    NSLog(@"采集到有页面显示：ID -> %@",pageID);
    
}
#pragma mark - Action Statistic

+(void)gatherActionWithEventID:(NSString *)actionID{
    NSLog(@"采集到时间点击响应：ID -> %@",actionID);
}

#pragma mark - config plist data
+(NSDictionary *)IDConfigPlist{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"StatisticID_Config" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
