//
//  MyItem.m
//  RandomItems
//
//  Created by Zhong,Yuan on 2017/10/16.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "MyItem.h"

@implementation MyItem

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

- (void) setContainedItem:(MyItem *)containedItem
{
    _containedItem = containedItem;
    self.containedItem.container = self;
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
    
    MyItem *item = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerailNumber];
    return item;
}

@end

@implementation MyContainer

- (void)addSubItem:(MyItem *)subitem
{
    if (!_subitems) {
        _subitems = [[NSMutableArray alloc] init];
    }
    [_subitems addObject:subitem];
}

- (NSString *)description
{
    int value = self.valueInDollars;
    NSString *subitemDes = [[NSString alloc] init];
    for (MyItem *subitem in _subitems) {
        value += subitem.valueInDollars;
        subitemDes = [NSString stringWithFormat:@"%@, %@", subitemDes, subitem];
    }
    NSString *des = [NSString stringWithFormat:@"%@: Worth %d", self.itemName, value];
    return [NSString stringWithFormat:@"%@ %@", des, subitemDes];
}

@end
