//
//  replyViewController.h
//  CommontDemo
//
//  Created by 诺心ios on 16/5/27.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadTableView) (NSString *);

@interface replyViewController : UIViewController

/** tableView刷新回调 */
@property (nonatomic, copy) ReloadTableView reloadTableView;

@end
