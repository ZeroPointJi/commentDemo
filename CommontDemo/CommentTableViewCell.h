//
//  CommentTableViewCell.h
//  CommontDemo
//
//  Created by 诺心ios on 16/5/26.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentGroupFrame.h"

typedef void (^ButtonClick) (UIButton *);

@interface CommentTableViewCell : UITableViewCell

/** 大小模型(内含CommentGroupmodel) */
@property (nonatomic, strong) CommentGroupFrame *commentGroupFrame;
/** 点赞按钮回调 */
@property (nonatomic, copy) ButtonClick likeBtnClick;
/** 评论按钮回调 */
@property (nonatomic, copy) ButtonClick commentBtnClick;

@end
