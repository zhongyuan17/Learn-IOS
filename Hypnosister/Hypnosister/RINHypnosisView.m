//
//  RINHypnosisView.m
//  Hypnosister
//
//  Created by Zhong,Yuan on 2017/10/18.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINHypnosisView.h"

@interface RINHypnosisView()

@property (nonatomic, strong) UIColor *circleColor;

- (void)randomChangeColor;

@end

@implementation RINHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self randomChangeColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2;
    center.y = bounds.origin.y + bounds.size.height / 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    [self.circleColor setStroke];
    for (float r = MAX(bounds.size.width, bounds.size.height); r > 0; r -= 30) {
        [path moveToPoint:CGPointMake(center.x + r, center.y)];
        [path addArcWithCenter:center radius:r startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    [path stroke];
}

- (void)randomChangeColor {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    self.circleColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"on touches began");
//    [self randomChangeColor];
//    [self setNeedsDisplay];
//}

- (NSString *)description
{
    return [NSString stringWithFormat:@"RINHypnosisView %@", [super description]];
}

@end
