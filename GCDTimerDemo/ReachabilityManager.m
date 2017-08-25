//
//  ReachabilityManager.m
//  GCDTimerDemo
//
//  Created by GK on 2017/8/25.
//  Copyright © 2017年 GK. All rights reserved.
//

#import "ReachabilityManager.h"

@interface ReachabilityManager()
//@property (nonatomic,strong) Reachability *reachability;
@property (nonatomic,strong) Reachability *hostReachability;
@end
@implementation ReachabilityManager

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static ReachabilityManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[ReachabilityManager alloc] init];
        //manager.reachability = [Reachability reachabilityForInternetConnection];
        //[manager.reachability startNotifier];
        //[manager reachabilityStatus:manager.reachability];
        
        manager.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        [manager.hostReachability startNotifier];
    });
    return manager;
}
- (NetworkStatus)networkStatus {
    return [self.hostReachability currentReachabilityStatus];
}
//- (void) reachabilityChanged:(NSNotification *)note
//{
//    id curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
//    
//    Reachability *reachability = (Reachability *)curReach;
//    
//    NetworkStatus netStatus = [reachability currentReachabilityStatus];
//
//    switch (netStatus) {
//        case NotReachable: {
//            break;
//        }
//        case ReachableViaWWAN: {
//            
//            break;
//        }
//        case ReachableViaWiFi: {
//            
//            break;
//        }
//    }
//}
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

@end
