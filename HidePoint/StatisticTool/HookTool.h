//
//  HookTool.h
//  HidePoint
//
//  Created by zhanfeng on 2017/8/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookTool : NSObject
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
