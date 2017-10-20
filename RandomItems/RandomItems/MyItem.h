//
//  MyItem.h
//  RandomItems
//
//  Created by Zhong,Yuan on 2017/10/16.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, strong) MyItem *containedItem;
@property (nonatomic, weak) MyItem *container;

- (void) setContainedItem:(MyItem *)containedItem;

- (instancetype) initWithItemName:(NSString *)name
                   valueInDollars:(int)value
                     serialNumber:(NSString *)sNumber;

- (instancetype) initWithItemName:(NSString *)name;

+ (instancetype) randomItem;

@end

@interface MyContainer : MyItem
{
    NSMutableArray *_subitems;
}

- (void)addSubItem:(MyItem *)subitem;
@end
