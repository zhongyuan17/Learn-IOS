//
//  RINItemStore.h
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/24.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RINItem;

@interface RINItemStore : NSObject

+ (instancetype)sharedStore;
- (RINItem *)createItem;

@property (nonatomic, readonly) NSArray *allItems;
- (NSArray *)allItems;

- (BOOL)removeItem:(NSUInteger) index;
- (BOOL)moveItemAtIndex:(NSUInteger) fromIndex
                toIndex:(NSUInteger) toIndex;

@end
