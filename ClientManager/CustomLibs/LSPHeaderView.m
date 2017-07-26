//
//  LSPHeaderView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/27.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "LSPHeaderView.h"
#import "Groups.h"
#import "Model.h"
@interface LSPHeaderView()
@property (nonatomic,weak) UIButton *nameView;
@property (nonatomic,weak) UILabel *countView;

@end
@implementation LSPHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"headerView";
    
    LSPHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headerView == nil) {
        headerView = [[LSPHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupHeaderViewSubviews];
    }
    return self;
}
- (void)setupHeaderViewSubviews
{
    UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
    [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
    [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    // [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //给按钮添加点击事件
    [nameView addTarget:self action:@selector(clickHeaderView) forControlEvents:UIControlEventTouchUpInside];
    
    nameView.imageView.contentMode = UIViewContentModeCenter;
    nameView.imageView.clipsToBounds = NO;
    
    
    [self.contentView addSubview:nameView];
    
    self.nameView = nameView;
    
    
    UILabel *countView = [[UILabel alloc] init];
    countView.textAlignment = NSTextAlignmentRight;
    
    countView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:countView];
    
    self.countView = countView;
 
}
- (void)setGroup:(Groups *)group
{
    _group = group;
    [self.nameView setTitle:group.name forState:UIControlStateNormal];
    self.countView.text = [NSString stringWithFormat:@"%d/%zd",10,group.modelArray.count];
    //覆盖原来的数据
    
    [self didMoveToSuperview];

}
- (void)clickHeaderView
{
    self.group.open = !self.group.open;
    if ([self.delegate respondsToSelector:@selector(headerViewClickedNameViewWithHeaderView:)]) {
        [self.delegate headerViewClickedNameViewWithHeaderView:self];
    }
}
/**
 *  当子控件添加到父控件上去时调用此方法
 */
- (void)didMoveToSuperview
{
    if (self.group.open) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else{
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameView.frame = self.bounds;
    
    CGFloat countY = 0;
    CGFloat countH = self.frame.size.height;
    CGFloat countW = 150;
    CGFloat countX = self.frame.size.width - countW - 10;
    
    self.countView.frame = CGRectMake(countX, countY, countW, countH);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
