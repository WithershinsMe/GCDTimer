# GCDTimer

# 用GCD实现的一个Timer

# 建议的使用方法
##  在viewDidApper 里面初始化并开启定时器
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    
    [self registerNotification];
    
    self.dispatchTimer = [[DispatchTimer alloc] init];
    
    [self.dispatchTimer startTimer:^{  
        __strong typeof(self) strongSelf=  weakSelf;
        // [strongSelf.dispatchTimer pauseTimer];  // 1
        // 做一些定时任务
        
        NSLog(@"timer is running");
    }];
}
## 在viewDidDisappear里面销毁定时器
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.dispatchTimer cancelTimer];
}
## 如果遇到网络变化，如断网情况应该调用
[self.dispatchTimer resumeTimer];
## 需要检测app进入后台状态
[self.dispatchTimer enterBackground];
## 检测到APP进入前台状态
[self.dispatchTimer enterForground];
## 可以自己控制定时器的请求频率
把start block里的标注为1的方法注释打开，然后在合适的地方调用[self.dispatchTimer resumeTimer];可以用在定时器高频次的请求，并控制只有一次请求完并处理
完毕之后，在让定时器跑起来，发起第二次请求



