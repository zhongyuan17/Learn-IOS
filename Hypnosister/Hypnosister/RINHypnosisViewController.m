//
//  RINHypnosisViewController
//  Hypnosister
//
//  Created by Zhong,Yuan on 2017/10/18.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINHypnosisViewController.h"
#import "RINHypnosisView.h"

@interface RINHypnosisViewController ()

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
    RINHypnosisView *firstView = [[RINHypnosisView alloc] init];
    self.view = firstView;
    NSLog(@"RINHypnosisView loadView");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
