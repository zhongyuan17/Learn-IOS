//
//  RINReminderViewController.m
//  Hypnosister
//
//  Created by Zhong,Yuan on 2017/10/19.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINReminderViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface RINReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation RINReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"RINReminderView DidLoad");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Reminder";
        UIImage *image = [UIImage imageNamed:@"Time"];
        self.tabBarItem.image = image;
    }
    
    return self;
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取用户是否同意开启通知
            NSLog(@"request authorization successed!");
        }
    }];
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.body = @"Hypnotize me!";
    content.title = @"Hypnotize";
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateCompo = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateCompo repeats:YES];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"Hypnotize"
                                                                          content:content trigger:trigger];
    // Schedule the notification.
    [center addNotificationRequest:request withCompletionHandler:nil];
}

@end
