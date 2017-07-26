//
//  OMClientViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMClientViewController.h"
#import "OMClientTableViewCell.h"
#import "OMClientModel.h"
@interface OMClientViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating, UISearchDisplayDelegate,UISearchBarDelegate>
{
    BOOL shouldShowSearchResults;
}
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *clientArray;
/**
 <#annotation#>
 */
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;
/**
 <#annotation#>
 */
@property (nonatomic,strong) UISearchController *searchController;

@end

@implementation OMClientViewController
- (NSMutableArray *)clientArray
{
    if (nil == _clientArray) {
        _clientArray = [NSMutableArray array];
    }
    return _clientArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择客户";
    //初始化内部的子控件
    [self setupClientViewControllerSubviews];
    [self requestClientViewControllerData];
    // Do any additional setup after loading the view.
}
/**
 初始化子控件
 */
- (void)setupClientViewControllerSubviews
{
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.placeholder = @"搜索";
    searchBar.layer.borderColor = [UIColor grayColor].CGColor;
    searchBar.layer.borderWidth = 0.5;
    searchBar.backgroundColor = [UIColor whiteColor];
   // self.tableView.tableHeaderView = searchBar;
    
//    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    self.searchDisplayController.searchResultsDataSource = self;
//    self.searchDisplayController.searchResultsDelegate = self;
//    self.searchDisplayController.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.translucent=NO;

    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"";
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"搜索";
    self.searchController.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchController.searchBar.layer.borderWidth = 0.5;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.barTintColor = [UIColor whiteColor];
     [self.searchController.searchBar sizeToFit];
    
    //1.
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
   
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
self.tableView.tableHeaderView = self.searchController.searchBar;

}
- (void)requestClientViewControllerData
{
    [self.clientArray removeAllObjects];
    for (NSInteger i = 0; i < 40; i ++) {
        OMClientModel *model = [[OMClientModel alloc] init];
        if (i % 2 == 0) {
            model.client = [NSString stringWithFormat:@"美国苹果科技公司-%ld",i];

        }else{
            model.client = [NSString stringWithFormat:@"美国Google科技公司-%ld",i];

        }
        [self.clientArray addObject:model];
    }
    [self.tableView reloadData];
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    shouldShowSearchResults = YES;
    [self.tableView reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    shouldShowSearchResults = NO;
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (!shouldShowSearchResults) {
        shouldShowSearchResults = YES;
        [self.tableView reloadData];
    }
    [self.searchController.searchBar resignFirstResponder];
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString * searchString = searchController.searchBar.text;
    NSPredicate * predicate = [NSPredicate  predicateWithFormat:@"SELF CONTAINS %@",searchString];
    //self.filteredArray = [[self.carNumberArray filteredArrayUsingPredicate:predicate] mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clientArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMClientTableViewCell *cell = [OMClientTableViewCell clientTableViewCellWithTableView:tableView];
    cell.model = self.clientArray[indexPath.row];
    return cell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return OMDetailH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMClientModel *model = self.clientArray[indexPath.row];
    if (self.clientBlock) {
        self.clientBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
