//
//  KeyBoardView.m
//  CommontDemo
//
//  Created by 诺心ios on 16/6/16.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import "KeyBoardView.h"

@implementation KeyBoardView

- (instancetype)initWithBGView:(UIView *)view
{
    self = [super init];
    if (self) {
        // 表情按钮
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceButton.frame = CGRectMake(0, 4, 40, 36);
        [_faceButton setTitle:@"表情" forState:UIControlStateNormal];
        _faceButton.backgroundColor = [UIColor darkGrayColor];
        [_faceButton addTarget:self action:@selector(showFaceBoard) forControlEvents:UIControlEventTouchUpInside];
        _faceButton.layer.cornerRadius = 5;
        [self addSubview:_faceButton];
        
        // 输入框
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(41, 4, SCREENW - 120, 36);
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.returnKeyType = UIReturnKeyNext;
        _textView.layer.cornerRadius = 5;
        [self addSubview:_textView];
        
        // 发送按钮
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(SCREENW - 69, 4, 59, 36);
        _sendButton.backgroundColor = [UIColor blueColor];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendReply) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.layer.cornerRadius = 5;
        [self addSubview:_sendButton];
        
        // 表情键盘
        _faceBoard = [[FaceBoard alloc] initWithFrame:CGRectMake(0, SCREENH, SCREENW, 240)];
        __weak UITextView *textView = self.textView;
        _faceBoard.buttonClick = ^(UIButton *button) {
            NSString *newText = [textView.text stringByAppendingString:button.titleLabel.text];
            textView.text = newText;
        };
        [view addSubview:_faceBoard];
        
        // 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

// 回收键盘,移除遮罩
- (void)tap
{
    [self.textView resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREENH, SCREENW, 44);
        self.faceBoard.frame = CGRectMake(0, SCREENH, SCREENW, 240);
    }];
    [_coverView removeFromSuperview];
    _coverView = nil;
}

// 弹出表情面板
- (void)showFaceBoard
{
    if (_isKeyBoard) {
        _isKeyBoard = NO;
        
        // 回收键盘
        [self.textView resignFirstResponder];
        
        // 改变位置
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, SCREENH - 44 - 240, SCREENW, 44);
            self.faceBoard.frame = CGRectMake(0, SCREENH - 240, SCREENW, 240);
        }];
    } else {
        // 回收键盘
        [self.textView becomeFirstResponder];
    }
}

// 发送评论
- (void)sendReply
{
    _isKeyBoard = NO;
    
    _sendReplyAndReload(_textView.text);
   
    // 输入框置空
    self.textView.text = @"";
   
    // 回收键盘移除遮罩
    [self tap];
}

// 键盘将要弹出
- (void)keyBoardWillShow:(NSNotification *)notification
{
    _isKeyBoard = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyBoardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREENH - 44 - keyBoardFrame.size.height, SCREENW, 44);
        self.faceBoard.frame = CGRectMake(0, SCREENH, SCREENW, 240);
    }];
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_coverView addGestureRecognizer:tap];
        [self.faceBoard.superview insertSubview:_coverView belowSubview:self.faceBoard];
    }
}

// 键盘将要隐藏
- (void)keyBoardWillHide:(NSNotification *)notification
{
    
}

// 键盘已经隐藏
- (void)keyBoardDidHide:(NSNotification *)notification
{
    
}

@end
