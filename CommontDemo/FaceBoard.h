//
//  FaceBoard.h
//  CommontDemo
//
//  Created by 诺心ios on 16/6/16.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FaceButtonClick) (UIButton *);

@interface FaceBoard : UIView

/** 表情点击事件 */
@property (nonatomic, copy) FaceButtonClick buttonClick;

@end
