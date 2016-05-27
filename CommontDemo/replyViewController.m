//
//  replyViewController.m
//  CommontDemo
//
//  Created by 诺心ios on 16/5/27.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import "replyViewController.h"

@interface replyViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation replyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 150, 40)];
    label.text = @"请输入文字";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 150, 40)];
    _textField.backgroundColor = [UIColor redColor];
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.layer.borderWidth = 1;
    
    [self.view addSubview:self.textField];
}

#pragma mark - TextField Delegate -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSString *nameString = [NSString stringWithFormat:@"隔壁老王：%@", textField.text];
    _reloadTableView(nameString);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return YES;
}

@end