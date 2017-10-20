//
//  main.m
//  RandomItems
//
//  Created by Zhong,Yuan on 2017/10/16.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            [items addObject:[MyItem randomItem]];
        }
        
        for (MyItem *item in items) {
            NSLog(@"%@", item);
        }
        
        items = nil;
    }
    return 0;
}

