//
//  FaceBoard.m
//  CommontDemo
//
//  Created by 诺心ios on 16/6/16.
//  Copyright © 2016年 诺心ios. All rights reserved.
//

#import "FaceBoard.h"
#import "Emoji.h"

#define kLINE 3
#define kCOLUMN 8

#define kPAD 10
#define kITEMW (self.frame.size.width - kPAD * 9) / kCOLUMN
#define kITEMH (self.frame.size.height - kPAD * 4) / kLINE

#define kEMOJINUM [Emoji systemEmoji].defaultEmoticons.count
#define kPAGENUM kEMOJINUM / (kLINE * kCOLUMN)

@interface FaceBoard () <UIScrollViewDelegate>

/** 滚动视图 **/
@property (nonatomic, strong) UIScrollView *scrollView;
/** 页面指示器 **/
@property (nonatomic, strong) UIPageControl *pageControl;
/** 表情数组 **/
@property (nonatomic, strong) NSArray *emojiArray;

@end

@implementation FaceBoard

- (NSArray *)emojiArray
{
    if (!_emojiArray) {
        self.emojiArray = [Emoji systemEmoji].defaultEmoticons;
    }
    return _emojiArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

// 初始化子控件
- (void)initSubViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.contentSize = CGSizeMake((kPAGENUM + 1) * SCREENW, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    for (NSInteger i = 0; i < kEMOJINUM; i++) {
        UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSInteger num = i % (kLINE * kCOLUMN);
        NSInteger page = i / (kLINE * kCOLUMN);
        NSInteger line = num / kCOLUMN;
        NSInteger column = num % kCOLUMN;
        
        CGFloat itemX = page * SCREENW +  (column + 1) * kPAD + column * kITEMW;
        CGFloat itemY = (line + 1) * kPAD + line * kITEMH;
        
        faceButton.frame = CGRectMake(itemX, itemY, kITEMW, kITEMH);
        
        [faceButton setTitle:self.emojiArray[i] forState:UIControlStateNormal];
        [faceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [faceButton addTarget:self action:@selector(faceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:faceButton];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 5, SCREENW, 20)];
    _pageControl.numberOfPages = kPAGENUM + 1;
    [_pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

// 表情点击事件
- (void)faceButtonClick:(UIButton *)button
{
    _buttonClick(button);
}

// 值改变时触发的方法
- (void)pageChange
{
    CGFloat offsetX = self.pageControl.currentPage * SCREENW;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - ScrollView Delegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / SCREENW + 0.5;
    self.pageControl.currentPage = page;
}

@end