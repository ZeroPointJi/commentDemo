//
//  Emoji.h
//  CommontDemo
//
//  Created by 诺心ios on 16/6/17.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoji : NSObject

/** 系统自带表情数组 **/
@property (nonatomic, copy) NSArray *defaultEmoticons;

+ (instancetype)systemEmoji;

@end
