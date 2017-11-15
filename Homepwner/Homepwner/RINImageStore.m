//
//  RINImageStore.m
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/27.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINImageStore.h"

@interface RINImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionay;

@end

@implementation RINImageStore

static RINImageStore *sharedItemStore = nil;

+ (instancetype)sharedStore {
    if (!sharedItemStore) {
        @synchronized(self) {
            if (!sharedItemStore) {
                sharedItemStore = [[RINImageStore alloc] initPrivate];
            }
        }
    }
    return sharedItemStore;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.dictionay = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[RINImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionay[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key {
    return self.dictionay[key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    [self.dictionay removeObjectForKey:key];
}

@end
