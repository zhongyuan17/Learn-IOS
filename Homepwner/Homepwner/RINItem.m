//
//  MyItem.m
//  RandomItems
//
//  Created by Zhong,Yuan on 2017/10/16.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINItem.h"

@implementation RINItem

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@): Worth %d, recored on %@",
            self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
}

- (instancetype) initWithItemName:(NSString *)name
                   valueInDollars:(int)value
                     serialNumber:(NSString *)sNumber
{
    self = [super init];
    if (self) {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
        
        NSUUID *uuid = [[NSUUID alloc] init];
        _itemKey = [uuid UUIDString];
    }
    return self;
}

- (instancetype) initWithItemName:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype) init
{
    return [self initWithItemName:@"Item"];
}

- (void)dealloc
{
    NSLog(@"Destroy: %@", self.itemName);
}

+ (instancetype) randomItem
{
    NSArray *randomAdjList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSUInteger adjIndex = arc4random() % [randomAdjList count];
    NSUInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjList objectAtIndex:adjIndex], [randomNounList objectAtIndex:nounIndex]];
    int randomValue = arc4random() % 100;
    NSString *randomSerailNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    RINItem *item = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerailNumber];
    return item;
}

@end
