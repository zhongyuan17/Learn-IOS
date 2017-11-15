//
//  RINItemStore.m
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/24.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINItemStore.h"
#import "RINItem.h"
#import "RINImageStore.h"

@interface RINItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

- (instancetype)initPrivate;

@end

@implementation RINItemStore

- (RINItem *)createItem { 
    RINItem *item = [RINItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

static RINItemStore *sharedItemStore = nil;

+ (instancetype)sharedStore {
    if (!sharedItemStore) {
        @synchronized(self) {
            if (!sharedItemStore) {
                sharedItemStore = [[RINItemStore alloc] initPrivate];
            }
        }
    }
    return sharedItemStore;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[RINItemStore sharedItemStore]" userInfo:nil];
    return nil;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (BOOL)removeItem:(NSUInteger)index {
    if (index < self.privateItems.count) {
        [[RINImageStore sharedStore] deleteImageForKey:[self.privateItems[index] itemKey]];
        [self.privateItems removeObjectAtIndex:index];
        return YES;
    }
    return NO;
}

- (BOOL)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return YES;
    }
    NSUInteger count = self.privateItems.count;
    if (fromIndex >= count || toIndex >= count) {
        return NO;
    }
    
    RINItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
    return YES;
}

@end
