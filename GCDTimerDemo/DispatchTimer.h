//
//  DispatchTimer.h
//  SNYifubao
//
//  Created by GK on 2017/8/17.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DispatchTimerStatus) {
    NotStarted = 0, //没开始
    Active,  //激活
    Paused ,//暂停
    Invalidated, //取消
    EnterBackground //进入背景

};
@interface DispatchTimer : NSObject
- (void)startTimer:(dispatch_block_t) block;
- (void)cancelTimer;
- (void)pauseTimer; //暂停timer 后，如果需要释放timer，需要resumeTimer或cancel timer
- (void)resumeTimer;
- (void)enterForground;
- (void)enterBackground;
- (DispatchTimerStatus)getStatus;
@end
