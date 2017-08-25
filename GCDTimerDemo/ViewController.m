//
//  ViewController.m
//  GCDTimerDemo
//
//  Created by GK on 2017/8/25.
//  Copyright © 2017年 GK. All rights reserved.
//

#import "ViewController.h"
#import "DispatchTimer.h"
#import "Reachability.h"

@interface ViewController ()
@property (nonatomic,strong) DispatchTimer *dispatchTimer;
@property (nonatomic) Reachability *internetReachability;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    
    [self registerNotification];
    
    self.dispatchTimer = [[DispatchTimer alloc] init];
    
    [self.dispatchTimer startTimer:^{
        __strong typeof(self) strongSelf=  weakSelf;
        // [strongSelf.dispatchTimer pauseTimer];
        // 做一些定时任务
        
        NSLog(@"timer is running");
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.dispatchTimer cancelTimer];
}
// registerNotification
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
- (void)reachabilityChanged:(NSNotification *)info {
    
    id curReach = [info object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);

    Reachability *reachability = (Reachability *)curReach;

    NetworkStatus netStatus = [reachability currentReachabilityStatus];

    switch (netStatus) {
        case NotReachable: {
            [self.dispatchTimer pauseTimer];
            break;
        }
        case ReachableViaWWAN: {
            [self.dispatchTimer resumeTimer];
            break;
        }
        case ReachableViaWiFi: {
            [self.dispatchTimer resumeTimer];
            break;
        }
    }
}
- (void)appEnterForeground:(NSNotification *)info {
    [self.dispatchTimer enterForground];
}
- (void)appEnterBackground:(NSNotification *)info {
    [self.dispatchTimer enterBackground];
}
@end
