//
//  ViewController.m
//  RealReachability
//
//  Created by Dustturtle on 16/1/9.
//  Copyright © 2016 Dustturtle. All rights reserved.
//

#import "ViewController.h"
#import "RealReachability.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flagLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    /*
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    NSLog(@"Initial reachability status:%@",@(status));
    
    if (status == RealStatusNotReachable)
    {
        self.flagLabel.text = @"Network unreachable!没网";
    }
    
   else if (status == RealStatusViaWiFi)
    {
        self.flagLabel.text = @"Network wifi! Free! wifi网络";
    }
    
   else if (status == RealStatusViaWWAN)
    {
        self.flagLabel.text = @"Network WWAN! In charge!蜂窝网";
    }
    else
    {
        self.flagLabel.text=@"RealStatusUnknown未知";
    }*/
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    
    int netType = 0;
    //获取到网络返回码
    for (id child in children)
    {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            break;
        }
        //根据状态选择
    }
    switch (netType) {
        case 0:
        {
            self.flagLabel.text=@"没网";
        }
            break;
        case 1:
        {
            self.flagLabel.text=@"2G";
        }
            break;
        case 2:
        {
            self.flagLabel.text=@"3G";
        }
            break;
        case 3:
        {
            self.flagLabel.text=@"4G";
        }
            break;
        case 5:
        {
            self.flagLabel.text=@"wifi";
        }
            break;
            
        default:
            break;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)testAction:(id)sender
{
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case RealStatusNotReachable:
            {
                [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"Nothing to do! offlineMode 掉线了" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                break;
            }
                
            case RealStatusViaWiFi:
            {
                [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"Do what you want! free wifi!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                break;
            }
                
            case RealStatusViaWWAN:
            {
                [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"Take care of your money! You are in charge!蜂窝网" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                
                WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
                if (accessType == WWANType2G)
                {
                    self.flagLabel.text = @"RealReachabilityStatus2G";
                }
                else if (accessType == WWANType3G)
                {
                    self.flagLabel.text = @"RealReachabilityStatus3G";
                }
                else if (accessType == WWANType4G)
                {
                    self.flagLabel.text = @"RealReachabilityStatus4G";
                }
                else
                {
                    self.flagLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
                }
                
                break;
            }
            case RealStatusUnknown:
            {
                  [[[UIAlertView alloc] initWithTitle:@"RealStatusUnknown" message:@"RealStatusUnknown" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                break;
            }
                
            default:
                break;
        }
    }];
    
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)networkChanged:(NSNotification *)notification
{
    /*
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable)
    {
        self.flagLabel.text = @"Network unreachable!没网";
    }
    
   else if (status == RealStatusViaWiFi)
    {
        self.flagLabel.text = @"Network wifi! Free!wifi";
    }
    
   else if (status == RealStatusViaWWAN)
    {
        self.flagLabel.text = @"Network WWAN! In charge!蜂窝网";
    }
    
   else if (status == RealStatusViaWWAN)
    {
        WWANAccessType accessType = [GLobalRealReachability currentWWANtype];

        if (accessType == WWANType2G)
        {
            self.flagLabel.text = @"RealReachabilityStatus2G";
        }
        else if (accessType == WWANType3G)
        {
            self.flagLabel.text = @"RealReachabilityStatus3G";
        }
        else if (accessType == WWANType4G)
        {
            self.flagLabel.text = @"RealReachabilityStatus4G";
        }
        else
        {
            self.flagLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
        }
    }
    
   else if (status == RealStatusUnknown)
    {
        self.flagLabel.text=@"RealStatusUnknown";
    }*/
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    
    int netType = 0;
    //获取到网络返回码
    for (id child in children)
    {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            break;
        }
        //根据状态选择
    }
    switch (netType) {
        case 0:
        {
            self.flagLabel.text=@"没网";
            [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"没网" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];

        }
            break;
        case 1:
        {
            self.flagLabel.text=@"2G";
            [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"2G" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
        }
            break;
        case 2:
        {
            self.flagLabel.text=@"3G";
            [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"3G" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
        }
            break;
        case 3:
        {
            self.flagLabel.text=@"4G";
            [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"4G" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
        }
            break;
        case 5:
        {
            self.flagLabel.text=@"wifi";
            [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"wifi" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
        }
            break;
            
        default:
            break;
    }

}

@end
