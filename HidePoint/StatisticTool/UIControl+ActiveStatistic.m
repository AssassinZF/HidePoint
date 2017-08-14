//
//  UIControl+ActiveStatistic.m
//  HidePoint
//
//  Created by zhanfeng on 2017/8/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "UIControl+ActiveStatistic.h"
#import "HookTool.h"
#import "StatisticDataUpload.h"

@implementation UIControl (ActiveStatistic)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [HookTool swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling

- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    //插入埋点代码
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    //NSLog(@"\n***hook success.\n[1]action:%@\n[2]target:%@ \n[3]event:%@", NSStringFromSelector(action), target, event);
    NSString *eventID = nil;
    //只统计触摸结束时
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
        NSDictionary *configDict = [StatisticDataUpload IDConfigPlist];
        eventID = configDict[targetName][ACTION_ENENT_KEY][actionString];
    }
    if (eventID != nil) {
        [StatisticDataUpload gatherActionWithEventID:eventID];
    }
}



@end
