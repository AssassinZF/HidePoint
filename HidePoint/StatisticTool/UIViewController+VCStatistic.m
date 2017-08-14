//
//  UIViewController+VCStatistic.m
//  HidePoint
//
//  Created by zhanfeng on 2017/8/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "UIViewController+VCStatistic.h"
#import "HookTool.h"
#import "StatisticDataUpload.h"

@implementation UIViewController (VCStatistic)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swiz_viewWillAppear:);
        [HookTool swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(swiz_viewWillDisappear:);
        [HookTool swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
    });
}

#pragma mark - Method Swizzling

- (void)swiz_viewWillAppear:(BOOL)animated
{
    //插入需要执行的代码
    [self inject_viewWillAppear];
    [self swiz_viewWillAppear:animated];
}

- (void)swiz_viewWillDisappear:(BOOL)animated
{
    [self inject_viewWillDisappear];
    [self swiz_viewWillDisappear:animated];
}

//利用hook 统计所有页面的停留时长
- (void)inject_viewWillAppear
{
    NSString *pageID = [self pageEventID:YES];
    if (pageID) {
        [StatisticDataUpload gatherVCWithPageID:pageID];
    }
}

- (void)inject_viewWillDisappear
{
    NSString *pageID = [self pageEventID:NO];
    if (pageID) {
        [StatisticDataUpload gatherVCWithPageID:pageID];
    }
}

- (NSString *)pageEventID:(BOOL)bEnterPage
{
    NSDictionary *configDict = [StatisticDataUpload IDConfigPlist];
    NSString *selfClassName = NSStringFromClass([self class]);
    return configDict[selfClassName][PAGE_DISPLAY_KEY][bEnterPage ? @"Enter" : @"Leave"];
}

@end
