//
//  CommentGroupModel.h
//  CommontDemo
//
//  Created by 诺心ios on 16/5/26.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentGroupModel : NSObject

/** 时间戳 */
@property (nonatomic, copy) NSString *time;
/** 回复评论数组 */
@property (nonatomic, strong) NSMutableArray *replyArr;
/** 正文 */
@property (nonatomic, copy) NSString *shuoshuoText;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 头像名称 */
@property (nonatomic, copy) NSString *icon;
/** 点赞数 */
@property (nonatomic, strong) NSNumber *likeCounts;

/** 添加新回复 */
- (void)addReply:(NSString *)text;

@end
