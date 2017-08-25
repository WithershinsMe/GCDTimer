//
//  DispatchTimer.m
//  SNYifubao
//
//  Created by GK on 2017/8/17.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "DispatchTimer.h"

dispatch_source_t CreateDispatchTimer(double interval,dispatch_queue_t queue,dispatch_block_t block) {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
        dispatch_source_set_event_handler(timer, block);
    }
    return timer;
}


@interface DispatchTimer()
@property (nonatomic,strong) dispatch_source_t timer;
@property (nonatomic,strong) dispatch_queue_t queue;
@property (nonatomic) enum DispatchTimerStatus status;
@property (nonatomic) BOOL vaild;
@property (nonatomic) BOOL started;
@end
@implementation DispatchTimer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.status = NotStarted;
    }
    return self;
}
- (DispatchTimerStatus)getStatus {
    return self.status;
}
- (BOOL)vaild {
    return self.status != Invalidated;
}
- (BOOL)started {
    return (self.status != NotStarted);
}
- (void)startTimer:(dispatch_block_t) block {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.started) {
            double secondToFire = 1.000f;
            self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self.timer = CreateDispatchTimer(secondToFire, self.queue,block);
            dispatch_resume(self.timer);
            self.status = Active;
        }
    });
   
}
- (void)pauseTimer {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self != nil && self.status == Active) {
            dispatch_suspend(self.timer);
            self.status = Paused;
        }
    });
  
}
- (void)resumeTimer {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self != nil && self.status == Paused) {
            dispatch_resume(self.timer);
            self.status = Active;
        }
    });
   
}
- (void)cancelTimer {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self != nil && self.timer && self.status != Invalidated) {
            if (self.status == Paused ) {
                dispatch_resume(self.timer);
            }
            dispatch_source_cancel(self.timer);
            self.status = Invalidated;
        }
    });
    
}

- (void)enterBackground {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self != nil && self.status == Active) {
            dispatch_suspend(self.timer);
            self.status = EnterBackground;
        }
    });
}
-(void)enterForground {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self != nil && self.status == EnterBackground) {
            dispatch_resume(self.timer);
            self.status = Active;
        }
    });
}
@end
