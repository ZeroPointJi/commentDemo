//
//  KeyBoardView.h
//  CommontDemo
//
//  Created by 诺心ios on 16/6/16.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceBoard.h"

typedef void (^SendReply) (NSString *);

@interface KeyBoardView : UIView

/** 判断键盘状态 */
@property (nonatomic, assign) BOOL isKeyBoard;
/** 表情按钮 */
@property (nonatomic, strong) UIButton *faceButton;
/** 输入框 */
@property (nonatomic, strong) UITextView *textView;
/** 发送按钮 */
@property (nonatomic, strong) UIButton *sendButton;
/** 表情面板 */
@property (nonatomic, strong) FaceBoard *faceBoard;
/** 遮罩 */
@property (nonatomic, strong) UIView *coverView;
/** 发送按钮回调事件 */
@property (nonatomic, copy) SendReply sendReplyAndReload;

/** 自定义初始化方法 */
- (instancetype)initWithBGView:(UIView *)view;

/** 显示键盘 */
- (void)show;

@end
