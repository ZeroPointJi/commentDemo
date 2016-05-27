//
//  CommentGroupModel.m
//  CommontDemo
//
//  Created by 诺心ios on 16/5/26.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import "CommentGroupModel.h"

@implementation CommentGroupModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"pictures"]) {
        
    }
    if ([key isEqualToString:@"replys"]) {
        NSArray *arr = value;
        _replyArr = [NSMutableArray arrayWithArray:arr];
    }
}

- (void)addReply:(NSString *)text
{
    [_replyArr addObject:text];
}

@end
