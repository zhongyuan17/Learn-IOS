//
//  RINDetailViewController.h
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/25.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RINItem;

@interface RINDetailViewController : UIViewController

@property (nonatomic, strong) RINItem *item;
- (void) setItem:(RINItem *)item;

@end
