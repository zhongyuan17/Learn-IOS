//
//  MyItem.h
//  RandomItems
//
//  Created by Zhong,Yuan on 2017/10/16.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RINItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;

- (instancetype) initWithItemName:(NSString *)name
                   valueInDollars:(int)value
                     serialNumber:(NSString *)sNumber;

- (instancetype) initWithItemName:(NSString *)name;

+ (instancetype) randomItem;

@end

