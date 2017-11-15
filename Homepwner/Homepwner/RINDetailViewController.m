//
//  RINDetailViewController.m
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/25.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINDetailViewController.h"
#import "RINItem.h"
#import "RINImageStore.h"

@interface RINDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark View Outlet
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RINDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.item) {
        self.nameField.text = self.item.itemName;
        self.serialField.text = self.item.serialNumber;
        self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
        
        static NSDateFormatter *dateFormatter = nil;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            dateFormatter.timeStyle = NSDateFormatterNoStyle;
        }
        self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
        
        UIImage *image = [[RINImageStore sharedStore] imageForKey:self.item.itemKey];
        self.imageView.image = image;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
}

- (void) setItem:(RINItem *)item
{
    _item = item;
    self.navigationItem.title = self.item.itemName;
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[RINImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
