//
//  RINHypnosisViewController
//  Hypnosister
//
//  Created by Zhong,Yuan on 2017/10/18.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINHypnosisViewController.h"
#import "RINHypnosisView.h"

@interface RINHypnosisViewController () <UITextFieldDelegate>

@end

@implementation RINHypnosisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"RINHypnosisView DidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    NSLog(@"RINHypnosisView loadView");
    RINHypnosisView *firstView = [[RINHypnosisView alloc] init];
    self.view = firstView;
    
    CGRect frame = CGRectMake(0, 70, 240, 30);
    int x = ([UIScreen mainScreen].bounds.size.width - frame.size.width) / 2;
    frame.origin.x = x;
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeASCIICapable;
    textField.delegate = self;
    
    [self.view addSubview:textField];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno"];
        self.tabBarItem.image = image;
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = message;
        [label sizeToFit];
        
        int maxOriginX = self.view.bounds.size.width - label.bounds.size.width;
        int maxOriginY = self.view.bounds.size.height - label.bounds.size.height;
        int randomX = arc4random() % maxOriginX;
        int randomY = arc4random() % maxOriginY;
        
        CGRect frame = label.frame;
        frame.origin = CGPointMake(randomX, randomY);
        label.frame = frame;
        
        [self.view addSubview:label];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc]
                        initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [label addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc]
                        initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [label addMotionEffect:motionEffect];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
