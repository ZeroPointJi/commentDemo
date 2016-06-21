//
//  KeyBoardView.m
//  CommontDemo
//
//  Created by 诺心ios on 16/6/16.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import "KeyBoardView.h"

@implementation KeyBoardView

#pragma mark -- 懒加载 --
- (UIButton *)faceButton
{
    if (!_faceBoard) {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceButton.frame = CGRectMake(0, 4, 40, 36);
        [_faceButton setTitle:@"表情" forState:UIControlStateNormal];
        _faceButton.backgroundColor = [UIColor darkGrayColor];
        [_faceButton addTarget:self action:@selector(showOrHideFaceBoard) forControlEvents:UIControlEventTouchUpInside];
        _faceButton.layer.cornerRadius = 5;
    }
    
    return _faceButton;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(41, 4, SCREENW - 120, 36);
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.returnKeyType = UIReturnKeyNext;
        _textView.layer.cornerRadius = 5;
    }
    
    return _textView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(SCREENW - 69, 4, 59, 36);
        _sendButton.backgroundColor = [UIColor blueColor];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendReply) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.layer.cornerRadius = 5;
    }
    
    return _sendButton;
}

- (FaceBoard *)faceBoard
{
    if (!_faceBoard) {
        _faceBoard = [[FaceBoard alloc] initWithFrame:CGRectMake(0, SCREENH, SCREENW, 240)];
        __weak UITextView *textView = self.textView;
        _faceBoard.buttonClick = ^(UIButton *button) {
            NSString *newText = [textView.text stringByAppendingString:button.titleLabel.text];
            textView.text = newText;
            [textView scrollRangeToVisible:NSMakeRange(0, MAXFLOAT)];
        };
    }
    
    return _faceBoard;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_coverView addGestureRecognizer:tap];
    }
    
    return _coverView;
}

#pragma mark -- 初始化与销毁 --
- (instancetype)initWithBGView:(UIView *)view
{
    self = [super init];
    if (self) {
        // 添加表情按钮
        [self addSubview:self.faceButton];
        
        // 添加输入框
        [self addSubview:self.textView];
        
        // 添加发送按钮
        [self addSubview:self.sendButton];
        
        // 添加表情键盘
        [view addSubview:self.faceBoard];
        
        // 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    // 销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark -- 核心方法 --
// 显示键盘
- (void)show
{
    [self.textView becomeFirstResponder];
}

// 回收所有键盘
- (void)recoveryAllKeyBoard
{
    _isKeyBoard = NO;
    
    [self.textView resignFirstResponder];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREENH, SCREENW, 44);
        self.faceBoard.frame = CGRectMake(0, SCREENH, SCREENW, 240);
    }];
}

// 弹出表情键盘
- (void)showFaceBoard
{
    _isKeyBoard = NO;
    
    [self.textView resignFirstResponder];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREENH - 44 - 240, SCREENW, 44);
        self.faceBoard.frame = CGRectMake(0, SCREENH - 240, SCREENW, 240);
    }];
}

// 弹出系统键盘
- (void)showSystemKeyBoard:(CGRect)keyBoardFrame
{
    _isKeyBoard = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREENH - 44 - keyBoardFrame.size.height, SCREENW, 44);
        self.faceBoard.frame = CGRectMake(0, SCREENH, SCREENW, 240);
    }];
}

// 添加遮罩
- (void)addCoverView
{
    [self.faceBoard.superview insertSubview:self.coverView belowSubview:self.faceBoard];
}

// 移除遮罩
- (void)removeCoverView
{
    [_coverView removeFromSuperview];
    _coverView = nil;
}

// tap事件
- (void)tap
{
    [self recoveryAllKeyBoard];
    [self removeCoverView];
}


// 表情按钮点击事件
- (void)showOrHideFaceBoard
{
    if (_isKeyBoard) {
        [self showFaceBoard];
    } else {
        [self.textView becomeFirstResponder];
    }
}

// 发送评论
- (void)sendReply
{
    _sendReplyAndReload(_textView.text);
   
    // 输入框置空
    self.textView.text = @"";
   
    // 回收键盘
    [self recoveryAllKeyBoard];
    
    // 移除遮罩
    [self removeCoverView];
}

#pragma mark -- Nofitication --

// 键盘将要弹出
- (void)keyBoardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyBoardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self showSystemKeyBoard:keyBoardFrame];
    
    [self addCoverView];
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
