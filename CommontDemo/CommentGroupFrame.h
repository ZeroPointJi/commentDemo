//
//  CommentGroupFrame.h
//  CommontDemo
//
//  Created by 诺心ios on 16/5/26.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommentGroupModel.h"

@interface CommentGroupFrame : NSObject

/** 头像大小 */
@property (nonatomic, assign) CGRect iconFrame;
/** 昵称大小 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文大小 */
@property (nonatomic, assign) CGRect shuoshuoTextFrame;
/** 时间戳大小 */
@property (nonatomic, assign) CGRect timeFrame;
/** 评论按钮大小 */
@property (nonatomic, assign) CGRect commentFrame;
/** 点赞按钮大小 */
@property (nonatomic, assign) CGRect likeFrame;
/** 回复评论大小数组 */
@property (nonatomic, strong) NSMutableArray *replysArray;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 评论模型 */
@property (nonatomic, strong) CommentGroupModel *commentGroup;

/** 添加新回复 */
- (void)addNewReply:(NSString *)text;

@end
