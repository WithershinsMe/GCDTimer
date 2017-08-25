//
//  ReachabilityManager.h
//  GCDTimerDemo
//
//  Created by GK on 2017/8/25.
//  Copyright © 2017年 GK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

static  NSString *kReachabilityManagerChangedNotification = @"kNetworkReachabilityManagerChangedNotification";

@interface ReachabilityManager : NSObject
@property (nonatomic) NetworkStatus networkStatus;
+ (instancetype) sharedInstance;
@end
