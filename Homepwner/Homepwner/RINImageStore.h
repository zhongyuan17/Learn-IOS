//
//  RINImageStore.h
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/27.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RINImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
