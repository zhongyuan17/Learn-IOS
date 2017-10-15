//
//  ViewController.m
//  Quiz
//
//  Created by 钟原 on 2017/10/15.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@property (nonatomic) int currentIndex;
@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.questionLabel.text = self.questions[self.currentIndex];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.questions = @[@"From what is cognac made?",
                           @"What is 7+7?",
                           @"What is the capital of Vermont?"];
        self.answers = @[@"Grapes",
                         @"14",
                         @"Montpelier"];
        self.currentIndex = 0;
    }
    
    return self;
}



- (IBAction)showQuestion:(id)sender
{
    self.currentIndex++;
    if (self.currentIndex >= [self.questions count]) {
        self.currentIndex = 0;
    }
    self.questionLabel.text = self.questions[self.currentIndex];
}

- (IBAction)showAnswer:(id)sender
{
    NSString *answer = self.answers[self.currentIndex];
    self.answerLabel.text = answer;
}

@end
