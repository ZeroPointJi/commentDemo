//
//  Emoji.m
//  CommontDemo
//
//  Created by 诺心ios on 16/6/17.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import "Emoji.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);  

@implementation Emoji

+ (instancetype)systemEmoji
{
    static Emoji *emoji;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emoji = [[self alloc] init];
    });
    return emoji;
}

- (NSArray *)defaultEmoticons
{
    if (!_defaultEmoticons) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i=0x1F600; i<=0x1F64F; i++) {
            if (i < 0x1F641 || i > 0x1F644) {
                int sym = EMOJI_CODE_TO_SYMBOL(i);
                NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
                [array addObject:emoT];
            }
        }
        _defaultEmoticons = array;
    }
    return _defaultEmoticons;
}

@end
