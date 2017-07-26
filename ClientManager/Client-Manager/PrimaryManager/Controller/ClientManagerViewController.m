//
//  ClientManagerViewController.m
//  ClientManager
//******************客户管理主控制器********************/
//  Created by iOS－MacBook on 2017/7/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//252 102 33

#import "ClientManagerViewController.h"
#import "CustomButtom.h"
#import "CMButton.h"
#import "CMResponsibleModel.h"
#import "CMCreateDateModel.h"
#import "CMResponsibleView.h"
#import "CMCreateDateView.h"
#import "CMClientModel.h"
#import "CMClientModelFrame.h"
#import "CMClientTableViewCell.h"
#import "CMFilterViewController.h"
#import "GCSliderMenue.h"
#import "TakeNotesViewController.h"
#define ClientDefaultColor [UIColor colorWithRed:252 / 255.0 green:102 / 255.0 blue:33 / 255.0 alpha:1.0]
@interface ClientManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 <#annotation#>
 */
@property (nonatomic,assign) CMTopViewType topViewType;

/**
 我负责的按钮
 */
@property (nonatomic,weak) CustomButtom *responsibleBtn;
/**
 我负责的按钮是否选中
 */
@property (nonatomic,assign) BOOL isResponsibleSelected;
/**
 创建时间是否选中
 */
@property (nonatomic,assign) BOOL isCreateDateSelected;
/**
 筛选按钮是否选中
 */
@property (nonatomic,assign) BOOL isFiltrateSelected;

/**
 创建时间按钮
 */
@property (nonatomic,weak) CustomButtom *createDateBtn;
/**
 筛选按钮
 */
@property (nonatomic,weak) CustomButtom *filtrateBtn;
/**
 我负责的模型
 */
@property (nonatomic,strong) NSMutableArray <CMResponsibleModel *> *responsibleArr;
/**
 创建时间的模型
 */
@property (nonatomic,strong) NSMutableArray <CMCreateDateModel *> *createDateArr;
/**
 下拉菜单的标题文字
 */
@property (nonatomic,strong) NSMutableArray *titleArr;
/**
 <#annotation#>
 */
@property (nonatomic,assign) NSInteger titleCount;


/**
 <#annotation#>
 */
@property (nonatomic,strong) CMResponsibleView *responsibleView;
/**
 弹出选择框
 */
@property (nonatomic,strong) UIWindow *alertWindow;
/**
 我负责的蒙版
 */
@property (nonatomic,strong) UIView *maskView;
/**
 创建时间
 */
@property (nonatomic,strong) CMCreateDateView *createDateView;
/**
 创建时间蒙版
 */
@property (nonatomic,strong) UIView *maskDateView;


/**
 <#annotation#>
 */
@property (nonatomic,strong) UIView *clientTopView;
/**
 我负责的按钮左边的文字坐标
 */
@property (nonatomic,assign) CGFloat responsibleOriginX;
/**
 创建时间左边的文字坐标
 */
@property (nonatomic,assign) CGFloat createDateOriginX;
/**
 是否是从顶部按钮互相切换过来的
 */
@property (nonatomic,assign) BOOL isSwitchTopBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *clientModelArr;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UILabel *bottomLabel;

@end

@implementation ClientManagerViewController

- (CMResponsibleView *)responsibleView
{
    if (nil == _responsibleView) {
        _responsibleView = [CMResponsibleView shareResponsibleView];
    }
    return _responsibleView;
}
- (CMCreateDateView *)createDateView
{
    if (nil == _createDateView) {
        _createDateView = [CMCreateDateView shareCreateDateView];
    }
    return _createDateView;
}

- (NSMutableArray<CMCreateDateModel *> *)createDateArr
{
    if (nil == _createDateArr) {
        
        _createDateArr = [NSMutableArray array];
        
    }
    
    return _createDateArr;

}
- (NSMutableArray *)titleArr
{
    
    if (nil == _titleArr) {
        
        _titleArr = [NSMutableArray array];
        
    }
    
    return _titleArr;
    
}
- (NSMutableArray *)clientModelArr
{
    
    if (nil == _clientModelArr) {
        
        _clientModelArr = [NSMutableArray array];
        
    }
    
    return _clientModelArr;
    
}
- (UIView *)maskView
{
    if (nil == _maskView) {
        _maskView = [[UIView alloc] init];
       // _alertWindow.windowLevel = UIWindowLevelAlert;
       // _alertWindow.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertWindowTapClick:)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}
- (UIView *)maskDateView
{
    if (nil == _maskDateView) {
        _maskDateView = [[UIView alloc] init];
        // _alertWindow.windowLevel = UIWindowLevelAlert;
        // _alertWindow.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskDateViewClick:)];
        [_maskDateView addGestureRecognizer:tap];
    }
    return _maskDateView;
}


- (void)alertWindowTapClick:(UIGestureRecognizer *)tap
{
    [self hiddenResponsibleView];
}
- (void)maskDateViewClick:(UIGestureRecognizer *)tap
{
    [self hiddenCreateDateView];
}
 /*

- (CMResponsibleView *)responsibleView
{
    if (nil == _responsibleView) {
        _responsibleView = [[CMResponsibleView alloc] init];
    }
    return _responsibleView;
}
*/
- (NSMutableArray<CMResponsibleModel *> *)responsibleArr
{
    if (nil == _responsibleArr) {
        _responsibleArr = [NSMutableArray array];
    }
    return _responsibleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建内部的子控件
    [self setupClientManagerSubviews];

    //创建顶部子控件
    [self setupClientManagerTopSubviews];
    // Do any additional setup after loading the view.
}
- (void)setupClientManagerSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 35) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    [self.view insertSubview:tableView atIndex:0];
    self.tableView = tableView;
    //底部的控件
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = ComFont;
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.backgroundColor = [UIColor orangeColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat bottomLabelX = 0;
    CGFloat bottomLabelY = SCREEN_HEIGHT - 35;
    CGFloat bottomLabelWidth = SCREEN_WIDTH;
    CGFloat bottomLabelHeight = 35;
    bottomLabel.frame = CGRectMake(bottomLabelX, bottomLabelY, bottomLabelWidth, bottomLabelHeight);
    [self.view addSubview:bottomLabel];
    bottomLabel.text = @"客户数:100个";
    self.bottomLabel = bottomLabel;

    //测试数据
    [self.clientModelArr removeAllObjects];
    for (NSInteger i = 0; i < 30; i ++) {
        CMClientModelFrame *modelFrame = [[CMClientModelFrame alloc] init];
        CMClientModel *model = [[CMClientModel alloc] init];
        model.custName = @"杭州阿里巴巴集团有限公司";
        model.managerDescription = @"迪丽热巴.买买提.阿拉丁神灯";
        model.coordinateAddress = @"中国浙江省杭州市慈溪路788号阿里巴巴科技大厦";
        model.returnDays = @"8";
        model.visitCount = @"1356789009";
        model.noVisitDays = @"32";
        modelFrame.model = model;
        [self.clientModelArr addObject:modelFrame];
    }
    [self.tableView reloadData];
    
}
#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMClientModelFrame *modelFrame = self.clientModelArr[indexPath.row];
    CMClientModel *model = modelFrame.model;
    NSLog(@"model.title = %@,indexPath.row = %ld",model.custName,indexPath.row);
    TakeNotesViewController *takeNoteVC = [[TakeNotesViewController alloc] init];
    [self.navigationController pushViewController:takeNoteVC animated:YES];
}

#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clientModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMClientTableViewCell *cell = [CMClientTableViewCell clientTableViewCellWithTableView:tableView];
    CMClientModelFrame *modelFrame = self.clientModelArr[indexPath.row];
    cell.modelFrame = modelFrame;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


/**
 顶部子控件的初始化
 */
- (void)setupClientManagerTopSubviews
{
    self.topViewType = CMTopViewTypeResonsible;//默认
    UIView *clientTopView = [[UIView alloc] init];
    clientTopView.backgroundColor = [UIColor whiteColor];
    CGFloat clientTopViewX = 0;
    CGFloat clientTopViewY = 64;
    CGFloat clientTopViewWidth = SCREEN_WIDTH;
    CGFloat clientTopViewHeight = 44;
    clientTopView.frame = CGRectMake(clientTopViewX, clientTopViewY, clientTopViewWidth, clientTopViewHeight);
    [self.view addSubview:clientTopView];
    self.clientTopView = clientTopView;
    
    CGFloat btnWidth = SCREEN_WIDTH / 3;
    //我负责的
    CustomButtom *responsibleBtn = [CustomButtom buttonWithType:UIButtonTypeCustom];
    [responsibleBtn setTitle:@"我负责的" forState:UIControlStateNormal];
    [responsibleBtn setImage:[UIImage imageNamed:@"cell_down"] forState:UIControlStateNormal];
    responsibleBtn.imageView.contentMode = UIViewContentModeCenter;
    [responsibleBtn setTitleColor:ClientDefaultColor forState:UIControlStateNormal];
    responsibleBtn.titleLabel.font = ComFont;
    responsibleBtn.titleLabel.textColor = [UIColor darkGrayColor];

    responsibleBtn.contentMode = UIViewContentModeCenter;
    responsibleBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //responsibleBtn.backgroundColor = [UIColor redColor];
    CGFloat responsibleBtnX = 0;
    CGFloat responsibleBtnY = 0;
    CGFloat responsibleBtnWidth = btnWidth;
    CGFloat responsibleBtnHeight = clientTopViewHeight;
    responsibleBtn.frame = CGRectMake(responsibleBtnX, responsibleBtnY, responsibleBtnWidth, responsibleBtnHeight);
    CGSize responsibleBtnSize = [responsibleBtn.currentTitle sizeWithFont:ComFont];
    self.responsibleOriginX = (responsibleBtnWidth - responsibleBtnSize.width) / 2;
    
    
    
    [responsibleBtn addTarget:self action:@selector(responsibleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [clientTopView addSubview:responsibleBtn];
    self.responsibleBtn = responsibleBtn;
    //创建时间
    CustomButtom *createDateBtn = [CustomButtom buttonWithType:UIButtonTypeCustom];
    [createDateBtn setTitle:@"创建时间" forState:UIControlStateNormal];
    [createDateBtn setImage:[UIImage imageNamed:@"cell_down"] forState:UIControlStateNormal];
    createDateBtn.imageView.contentMode = UIViewContentModeCenter;
    createDateBtn.contentMode = UIViewContentModeCenter;
   // createDateBtn.backgroundColor = [UIColor orangeColor];
    createDateBtn.titleLabel.font = ComFont;
    createDateBtn.titleLabel.textColor = [UIColor darkGrayColor];
    
    [createDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGFloat createDateBtnX = btnWidth;
    CGFloat createDateBtnY = 0;
    CGFloat createDateBtnWidth = btnWidth;
    CGFloat createDateBtnHeight = clientTopViewHeight;
    createDateBtn.frame = CGRectMake(createDateBtnX, createDateBtnY, createDateBtnWidth, createDateBtnHeight);
    self.createDateOriginX = responsibleBtnWidth + self.responsibleOriginX;
    
    [createDateBtn addTarget:self action:@selector(createDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [clientTopView addSubview:createDateBtn];
    self.createDateBtn = createDateBtn;
    //筛选
    CustomButtom *filtrateBtn = [CustomButtom buttonWithType:UIButtonTypeCustom];
    [filtrateBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [filtrateBtn setImage:[UIImage imageNamed:@"filters"] forState:UIControlStateNormal];
    [filtrateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    filtrateBtn.contentMode = UIViewContentModeCenter;
    filtrateBtn.imageView.contentMode = UIViewContentModeCenter;
    filtrateBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //filtrateBtn.backgroundColor = [UIColor blueColor];
    filtrateBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    filtrateBtn.titleLabel.font = ComFont;
    filtrateBtn.titleLabel.textColor = [UIColor darkGrayColor];

    CGFloat filtrateBtnX = btnWidth * 2;
    CGFloat filtrateBtnY = 0;
    CGFloat filtrateBtnWidth = btnWidth;
    CGFloat filtrateBtnHeight = clientTopViewHeight;
    filtrateBtn.frame = CGRectMake(filtrateBtnX, filtrateBtnY, filtrateBtnWidth, filtrateBtnHeight);
    [filtrateBtn addTarget:self action:@selector(filtrateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [clientTopView addSubview:filtrateBtn];
    self.filtrateBtn = filtrateBtn;
    
    //底部分割线
    UIView *topUnderLine = [[UIView alloc] init];
    topUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat topUnderLineX = 0;
    CGFloat topUnderLineY = clientTopViewHeight - 0.4;
    CGFloat topUnderLineWidth = SCREEN_WIDTH;
    CGFloat topUnderLineHeight = 0.4;
    topUnderLine.frame = CGRectMake(topUnderLineX, topUnderLineY, topUnderLineWidth, topUnderLineHeight);
    [clientTopView addSubview:topUnderLine];

    
}
/**
 点击我负责的按钮处理

 @param sender <#sender description#>
 */
- (void)responsibleBtnClick:(CustomButtom *)sender
{
    self.createDateBtn.isIgnore = YES;
    self.filtrateBtn.isIgnore = YES;
    self.topViewType = CMTopViewTypeResonsible;
    //隐藏其他弹出的列表
    [self hiddenCreateDateView];
    
    if (sender.isIgnore == YES) {
        
        self.isResponsibleSelected = sender.isIgnore;
    }
    self.isResponsibleSelected = !self.isResponsibleSelected;
    
    [sender setTitleColor:ClientDefaultColor forState:UIControlStateNormal];
    
    [self.filtrateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.createDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    if (sender.isIgnore  || self.isResponsibleSelected == NO) {
//        //隐藏下拉弹出的菜单栏
//        [self hiddenResponsibleView];
//    }
    //弹出下拉菜单
    if (sender.isIgnore == NO) {
        [self showResponsibleView];

    }
    
    sender.isIgnore = NO;


}
/**
 创建时间点击
 
 @param sender <#sender description#>
 */
- (void)createDateBtnClick:(CustomButtom *)sender
{
    self.responsibleBtn.isIgnore = YES;
    self.filtrateBtn.isIgnore = YES;
   // self.isResponsibleSelected = YES;
    
    if (sender.isIgnore == YES) {
        
        self.isCreateDateSelected = sender.isIgnore;
    }
    self.isCreateDateSelected = !self.isCreateDateSelected;
    
    [sender setTitleColor:ClientDefaultColor forState:UIControlStateNormal];
    
    [self.responsibleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.filtrateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //隐藏其他按钮弹出的菜单
    [self hiddenResponsibleView];
   
    
    if (sender.isIgnore == NO) {
        //弹出下拉菜单
        [self showCreateDateView];
        
    }
    
    
    sender.isIgnore = NO;
    
    
    
    
    
    
    
    
}
/**
 筛选点击按钮处理

 @param sender <#sender description#>
 */
- (void)filtrateBtnClick:(CustomButtom *)sender
{
    
    self.responsibleBtn.isIgnore = YES;
    self.createDateBtn.isIgnore = YES;
    if (sender.isIgnore == YES) {
        
        self.isFiltrateSelected = sender.isIgnore;
    }
    self.isFiltrateSelected = !self.isFiltrateSelected;

    [sender setTitleColor:ClientDefaultColor forState:UIControlStateNormal];
    [self.responsibleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.createDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //先隐藏其他打开的菜单
    [self hiddenResponsibleView];
    [self hiddenCreateDateView];
    //跳转相应的控制器
    CMFilterViewController *filterVC = [[CMFilterViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:filterVC];
   [GCSliderMenue popRightMenuController:navVC fromeParentNaviC:self.navigationController leftPadding:40 swipeRightClose:NO];
   // [self.navigationController pushViewController:filterVC animated:YES];
    
    
    

}
- (void)showResponsibleView
{
    NSArray *titleArr = @[@"我负责的",@"我相关的",@"我下属的",@"已赢单的",@"今天拜访联系的"];
    self.titleCount = titleArr.count;
    //[self.responsibleArr removeAllObjects];
    if(0 == self.responsibleArr.count){
        for (NSInteger i = 0; i < self.titleCount; i ++) {
            CMResponsibleModel *model = [[CMResponsibleModel alloc] init];
            NSString *title = titleArr[i];
            model.title = title;
            [self.responsibleArr addObject:model];
        }
            self.responsibleView.titleOffset = self.responsibleOriginX;

          self.responsibleView.responsibleArr = self.responsibleArr;
        
    }
    CGFloat maskViewX = 0;
    CGFloat maskViewY = 64 + 44;
    CGFloat maskViewWidth = SCREEN_WIDTH;;
    CGFloat maskViewHeight = SCREEN_HEIGHT - maskViewY;
    self.maskView.frame = CGRectMake(maskViewX, maskViewY, maskViewWidth, maskViewHeight);
    self.maskView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:self.maskView belowSubview:self.clientTopView];
    
    // self.alertWindow.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:214 / 255.0 blue:214 / 255.0 alpha:1.0];
    
    CGFloat responsibleX = 0;
    CGFloat responsibleY = - 108;
    CGFloat responsibleWidth = SCREEN_WIDTH;
    CGFloat responsibleHeight = 0;
    self.responsibleView.frame = CGRectMake(responsibleX, responsibleY, responsibleWidth, responsibleHeight);
    self.responsibleView.backgroundColor = [UIColor whiteColor];
    responsibleHeight = self.responsibleView.responsibleHeight;
    [self.view insertSubview:self.responsibleView aboveSubview:self.maskView];
    
    self.responsibleView.hidden = NO;
    
    __weak typeof(self)weakSelf = self;
    if (self.isResponsibleSelected) {
        self.maskView.alpha = 0.0;
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
            strongSelf.maskView.alpha = 0.3;
            self.responsibleView.frame = CGRectMake(0, 64 + 44, SCREEN_WIDTH, 44 * strongSelf.titleCount);
            
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [self hiddenResponsibleView];
        
    }
    
    
    self.responsibleView.responsibleBlock = ^(CMButton *sender) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CMResponsibleModel *model = sender.responsibleModel;
        NSString *title = model.title;
        if (title.length > 4) {
            
            title = [title substringWithRange:NSMakeRange(0, 4)];
        }
        [strongSelf.responsibleBtn setTitle:title forState:UIControlStateNormal];
        NSLog(@"点击了-->%@",model.title);
        [strongSelf hiddenResponsibleView];
        
        // [strongSelf.responsibleArr removeAllObjects];
        NSLog(@"responsibleView.frame = %@",NSStringFromCGRect(strongSelf.responsibleView.frame));
    };

}
- (void)hiddenResponsibleView
{
    self.isResponsibleSelected = NO;
    //self.isCreateDateSelected = NO;
    self.responsibleView.frame = CGRectMake(0, 64 + 44, SCREEN_WIDTH, 44 * 5);
    self.maskView.alpha = 0.3;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.maskView.alpha = 0.0;
        strongSelf.responsibleView.frame = CGRectMake(0, -(108 + 44 * 5), SCREEN_WIDTH, 44 * 5);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.maskView.frame = CGRectMake(0, 108, SCREEN_WIDTH, 0);
        [strongSelf.responsibleView removeFromSuperview];
        [strongSelf.maskView removeFromSuperview];
        
    }];

}

- (void)showCreateDateView
{
    NSArray *titleArr = @[@"创建时间倒序",@"距离远近正序",@"拜访次序正序"];
    NSInteger count = titleArr.count;
    //[self.responsibleArr removeAllObjects];
    if(0 == self.createDateArr.count){
        for (NSInteger i = 0; i < count; i ++) {
            CMCreateDateModel *model = [[CMCreateDateModel alloc] init];
            NSString *title = titleArr[i];
            model.title = title;
            [self.createDateArr addObject:model];
        }
        self.createDateView.titleOffset = self.createDateOriginX;
        
        self.createDateView.createDateArr = self.createDateArr;
        
    }
    
    CGFloat maskViewX = 0;
    CGFloat maskViewY = 64 + 44;
    CGFloat maskViewWidth = SCREEN_WIDTH;;
    CGFloat maskViewHeight = SCREEN_HEIGHT - maskViewY;
    self.maskDateView.frame = CGRectMake(maskViewX, maskViewY, maskViewWidth, maskViewHeight);
    self.maskDateView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:self.maskDateView belowSubview:self.clientTopView];
    
    // self.alertWindow.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:214 / 255.0 blue:214 / 255.0 alpha:1.0];
    
    CGFloat responsibleX = 0;
    CGFloat responsibleY = - 108;
    CGFloat responsibleWidth = SCREEN_WIDTH;
    CGFloat responsibleHeight = 0;
    self.createDateView.frame = CGRectMake(responsibleX, responsibleY, responsibleWidth, responsibleHeight);
    self.createDateView.backgroundColor = [UIColor whiteColor];
    responsibleHeight = self.createDateView.createDateHeight;
    [self.view insertSubview:self.createDateView aboveSubview:self.maskDateView];
    
    self.createDateView.hidden = NO;
    
    __weak typeof(self)weakSelf = self;
    if (self.isCreateDateSelected) {
        self.maskDateView.alpha = 0.0;
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
            strongSelf.maskDateView.alpha = 0.3;
            self.createDateView.frame = CGRectMake(0, 64 + 44, SCREEN_WIDTH, 44 * 3);
            
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [self hiddenCreateDateView];
        
    }
    
    
    self.createDateView.createBlock = ^(CMButton *sender) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CMCreateDateModel *model = sender.createDateModel;
        NSString *title = model.title;
        if (title.length > 4) {
            title = [title substringWithRange:NSMakeRange(0, 4)];
        }
        [strongSelf.createDateBtn setTitle:title forState:UIControlStateNormal];
        NSLog(@"点击了-->%@",model.title);
        [strongSelf hiddenCreateDateView];
        
        // [strongSelf.responsibleArr removeAllObjects];
        NSLog(@"responsibleView.frame = %@",NSStringFromCGRect(strongSelf.responsibleView.frame));
    };


}
- (void)hiddenCreateDateView
{
   // self.isResponsibleSelected = NO;
    self.isCreateDateSelected = NO;
    
    self.createDateView.frame = CGRectMake(0, 64 + 44, SCREEN_WIDTH, 44 * 3);
    self.maskDateView.alpha = 0.3;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.maskDateView.alpha = 0.0;
        strongSelf.createDateView.frame = CGRectMake(0, -(108 + 44 * 3), SCREEN_WIDTH, 44 * 3);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.maskDateView.frame = CGRectMake(0, 108, SCREEN_WIDTH, 0);
        [strongSelf.createDateView removeFromSuperview];
        [strongSelf.maskDateView removeFromSuperview];
        
    }];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
