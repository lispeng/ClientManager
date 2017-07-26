//
//  LSPFoldViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/26.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "LSPFoldViewController.h"
#import "Model.h"
#import "ModelFrame.h"
#import "LSPFoldTableViewCell.h"
#import "Groups.h"
#import "LSPHeaderView.h"
@interface LSPFoldViewController ()<UITableViewDelegate,UITableViewDataSource,LSPHeaderViewClickedNameView>
/**
 UITableView
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *datas;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *sectionDatas;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIImageView *imageView;
/**
 <#annotation#>
 */
@property (nonatomic,assign) NSInteger sectionSign;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *isRefresh;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *valueClick;

@end

@implementation LSPFoldViewController

- (NSMutableArray *)datas
{
    if (nil == _datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (NSMutableArray *)sectionDatas
{
    
    if (nil == _sectionDatas) {
        
        _sectionDatas = [NSMutableArray array];
        
    }
    
    return _sectionDatas;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFoldViewControllerSubviews];
    [self requestFoldViewControllerData];
    // Do any additional setup after loading the view.
}
- (void)requestFoldViewControllerData
{
    [self.sectionDatas removeAllObjects];
    [self.datas removeAllObjects];
    
    for (NSInteger i = 0; i < 30; i ++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSString *key = [NSString stringWithFormat:@"key-%ld",i];
        NSString *value = [NSString stringWithFormat:@"Google-%ld",i + 1];
        dict[key] = value;
        
        Groups *group = [[Groups alloc] init];
        group.name = value;
        
        NSMutableArray *tempArr = [NSMutableArray array];
        NSInteger count = arc4random() % 121;
        for (NSInteger j = 0; j < count; j ++) {
            ModelFrame *modelFrame = [[ModelFrame alloc] init];
            Model *model = [[Model alloc] init];
            model.imageUrl = [NSString stringWithFormat:@"%ld.jpg",(j % 19) + 1];
            model.name = [NSString stringWithFormat:@"Apple-Google-%ld",j + i + 1];
            model.info = [NSString stringWithFormat:@"Apple International Tecchnolegy is very company ,Google is same -> %ld",j + 11];
            modelFrame.model = model;
            [tempArr addObject:modelFrame];
        }
        //NSString *keyArr = [NSString stringWithFormat:@"keyModel%ld",i + 1];
       // dict[keyArr] = tempArr;
        group.modelArray = tempArr;
        [self.sectionDatas addObject:group];
    }
    [self.tableView reloadData];
}
- (void)setupFoldViewControllerSubviews
{
    self.title = @"折叠选项";
    self.isRefresh = @"no";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [AppColor appTableViewBackgroundColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

   
    
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return self.sectionDatas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    Groups *group = self.sectionDatas[section];
    return (group.open ? group.modelArray.count : 0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPFoldTableViewCell *cell = [LSPFoldTableViewCell foldTableViewCellWithTableView:tableView];
    Groups *group = self.sectionDatas[indexPath.section];
    ModelFrame *modelFrame = group.modelArray[indexPath.row];
    cell.modelFrame = modelFrame;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    LSPHeaderView *header = [LSPHeaderView headerViewWithTableView:tableView];
    header.delegate = self;
    header.group = self.sectionDatas[section];
    return header;
}
- (void)headerViewClickedNameViewWithHeaderView:(LSPHeaderView *)headerView
{
    [self.tableView reloadData];
}
#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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
