//
//  OMOrderEditInfoViewController.m
//  ClientManager
////////////可编辑的商品信息控制器//////////////
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMOrderEditInfoViewController.h"
#import "OMOrderModel.h"
#import "OMOrderEditScrollView.h"
#import "OMOrderEditTextField.h"
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface OMOrderEditInfoViewController ()<UIScrollViewDelegate>
/**
 滚动视图背景
 */
@property (nonatomic,weak) OMOrderEditScrollView *orderEditScrollView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMOrderModel *model;

@property (assign,nonatomic) BOOL isSwitchKeyboard;
@property (assign,nonatomic) CGFloat keyboardHeight;

@end

@implementation OMOrderEditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品信息";
    //创建模拟数据
    [self createOrderInfoData];
    //初始化视图背景
    [self setupOrderEditInfoViewControllerSubviews];

    // Do any additional setup after loading the view.
}
- (void)createOrderInfoData
{
    OMOrderModel *model = [[OMOrderModel alloc] init];
    model.commodityName = @"iphone8s";
    model.specs = @"台";
    model.price = @"6888";
    model.brand = @"Apple Inc";
    model.category = @"科技产品";
    model.productArea = @"美国加州库比蒂诺";
    model.stock = @"8900";
    model.remarks = @"Apple 致力于设计、开发和销售消费电子产品、计算机软件、在线服务和个人计算机，总部位于美国加利福尼亚州库比蒂诺。凭借 iPhone、iPad、Mac、Apple Watch、iOS、MacOS、watchOS 等产品推动了全球创新。你可以访问网站，了解和购买产品，并获得技术支持。";
    self.model = model;
}
/**
 初始化视图背景
 */
- (void)setupOrderEditInfoViewControllerSubviews
{
    OMOrderEditScrollView *orderEditScrollView = [[OMOrderEditScrollView alloc] init];
    orderEditScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
    orderEditScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    orderEditScrollView.model = self.model;
    orderEditScrollView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderEditScrollViewTapClick:)];
    tap.numberOfTapsRequired = 1;
    [orderEditScrollView addGestureRecognizer:tap];
    __weak typeof(self) weakSelf = self;
    orderEditScrollView.orderEditBlock = ^(OMOrderEditTextField *editField, BOOL isInput) {
        __strong typeof(weakSelf)strongSelf = weakSelf;

        if ([editField.fieldType isEqualToString:@"price"] && isInput == NO) {
            NSString *message = @"只能输入整数或两位小数";
            [strongSelf OrderEditInfoaAlertViewWithMessage:message];
        }else if([editField.fieldType isEqualToString:@"buyNum"] && isInput == NO){
            NSString *message = @"只能输入0或正整数";
            [strongSelf OrderEditInfoaAlertViewWithMessage:message];

        }
    };

    [self.view addSubview:orderEditScrollView];
    self.orderEditScrollView = orderEditScrollView;
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderEditInfoViewControllerKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //底部的控件
    UIView *editCtrlContentView = [[UIView alloc] init];
    editCtrlContentView.backgroundColor = [UIColor whiteColor];
    editCtrlContentView.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [self.view addSubview:editCtrlContentView];
    
    //赠品按钮
    UIButton *donationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    donationBtn.frame = CGRectMake(10, 0, 109, 50);
    [donationBtn setTitle:@"此为赠品" forState:UIControlStateNormal];
    [donationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    donationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [donationBtn addTarget:self action:@selector(donationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [editCtrlContentView addSubview:donationBtn];
    
    UIButton *saveInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat saveInfoBtnWidth = 109;
    saveInfoBtn.frame = CGRectMake(SCREEN_WIDTH - saveInfoBtnWidth, 0, saveInfoBtnWidth, 50);
    [saveInfoBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveInfoBtn setBackgroundColor:[AppColor appMainColor]];
    saveInfoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [saveInfoBtn addTarget:self action:@selector(saveInfoBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [editCtrlContentView addSubview:saveInfoBtn];

}
/**
 选中此为赠品按钮

 @param sender <#sender description#>
 */
- (void)donationBtnClick:(UIButton *)sender
{
    self.orderEditScrollView.currentRateField.text = @"0.00";
}
/**
 点击保存按钮

 @param sender <#sender description#>
 */
- (void)saveInfoBtnBtnClick:(UIButton *)sender
{
    
}
- (void)orderEditScrollViewTapClick:(UIGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    self.orderEditScrollView.y = 0;

}

- (void)orderEditInfoViewControllerKeyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        NSLog(@"keyboardRect.origin.y = %f",keyboardRect.origin.y);
        self.orderEditScrollView.y = keyboardRect.origin.y - self.orderEditScrollView.height;
        NSLog(@"self.orderEditScrollView.y = %f",self.orderEditScrollView.y);

    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.orderEditScrollView.y = 0;
}
/**
 提示弹出框
 
 @param message <#message description#>
 */
- (void)OrderEditInfoaAlertViewWithMessage:(NSString *)message
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark---UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    self.orderEditScrollView.y = 0;
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
