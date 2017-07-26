//
//  TakeNotesViewController.m
//  ClientManager
//****************写记录主控制器***********************
//  Created by iOS－MacBook on 2017/7/19.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "TakeNotesViewController.h"
#import "ShowAudioModel.h"
#import "PlayAudioView.h"
#import "LGAudioKit.h"
#import "ShowAudioView.h"
#define RecordH 60
@interface TakeNotesViewController ()<UITextViewDelegate,UIScrollViewDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIScrollView *scrollView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *tabBar;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITextView *textView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *recordView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) ShowAudioView *audioView;
/**
 <#annotation#>
 */
@property (nonatomic,weak)  PlayAudioView *playView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *bottomViewLine;

@end

@implementation TakeNotesViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //监听键盘弹出
    [self monitorKeyboardNotification];
 
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTakeNotesViewControllerNavigationBar];
    [self setupTakeNotesViewControllerSubvies];
    // Do any additional setup after loading the view.
}
- (void)setupTakeNotesViewControllerNavigationBar
{
    UIBarButtonItem *saveLeftItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveLeftBarButonItem)];
    self.navigationItem.rightBarButtonItem = saveLeftItem;
    
}
/**
 保存按钮
 */
- (void)saveLeftBarButonItem
{
    NSLog(@"保存错写的记录");
}
- (void)setupTakeNotesViewControllerSubvies
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewWidth = SCREEN_WIDTH;
    CGFloat scrollViewHeight = SCREEN_HEIGHT;
    scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewWidth, scrollViewHeight);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 20);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //UITextView
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    CGFloat textViewX = 0;
    CGFloat textViewY = 0;
    CGFloat textViewWidth = SCREEN_WIDTH;
    CGFloat textViewHeight = SCREEN_HEIGHT / 3;
    textView.frame = CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight);
    textView.delegate = self;
    textView.font = ComFont;
    [self.scrollView addSubview:textView];
    self.textView = textView;
    
    /*
    UIView *bottomViewLine = [[UIView alloc] init];
    bottomViewLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat bottomViewLineX = 0;
    CGFloat bottomViewLineY = textViewHeight;
    CGFloat bottomViewLineWidth = textViewWidth;
    CGFloat bottomViewLineHeight = 0.4;
    bottomViewLine.frame = CGRectMake(bottomViewLineX, bottomViewLineY, bottomViewLineWidth, bottomViewLineHeight);
    [self.scrollView addSubview:bottomViewLine];
    self.bottomViewLine = bottomViewLine;
    */
    
    
    
    
    
    //工具条
    UIView *tabBar = [[UIView alloc] init];
    CGFloat tabBarWidth = SCREEN_WIDTH;
    CGFloat tabBarHeight = 50;
    CGFloat tabBarX = 0;
    CGFloat tabBarY = SCREEN_HEIGHT - tabBarHeight;
    tabBar.frame = CGRectMake(tabBarX, tabBarY, tabBarWidth, tabBarHeight);
    tabBar.backgroundColor = [AppColor appTableViewBackgroundColor];
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat topLineX = 0;
    CGFloat topLineY = 0;
    CGFloat topLineWidth = tabBarWidth;
    CGFloat topLineHeight = 0.4;
    topLine.frame = CGRectMake(topLineX, topLineY, topLineWidth, topLineHeight);
    [self.tabBar addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat bottomLineX = 0;
    CGFloat bottomLineY = tabBarHeight - 0.4;
    CGFloat bottomLineWidth = tabBarWidth;
    CGFloat bottomLineHeight = 0.4;
    bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineWidth, bottomLineHeight);
    [self.tabBar addSubview:bottomLine];


    
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat recordBtnWidth = tabBarHeight;
    CGFloat recordBtnHeight = tabBarHeight;
    CGFloat recordBtnX = tabBarWidth - recordBtnWidth - ComMargin;
    CGFloat recordBtnY = 0;
    recordBtn.frame = CGRectMake(recordBtnX, recordBtnY, recordBtnWidth, recordBtnHeight);
    [recordBtn addTarget:self action:@selector(takeNotesTecordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    recordBtn.backgroundColor = [UIColor blueColor];
    [self.tabBar addSubview:recordBtn];
    //self.textView.inputAccessoryView = tabBar;
   // self.textView.inputView = tabBar;
  
    UIView *recordView = [[UIView alloc] init];
    recordView.backgroundColor = [UIColor whiteColor];
    CGFloat recordWidth = SCREEN_WIDTH;
    CGFloat recordHeight = SCREEN_HEIGHT / 2 - 100;
    CGFloat recordViewX = SCREEN_WIDTH;
    CGFloat recordViewY = SCREEN_HEIGHT - recordHeight;
    recordView.frame = CGRectMake(recordViewX, recordViewY, recordWidth, recordHeight);
  //  recordView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:recordView];
    self.recordView = recordView;
    
    UIView *topRecordLine = [[UIView alloc] init];
    topRecordLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat topRecordLineX = 0;
    CGFloat topRecordLineY = 0;
    CGFloat topRecordLineWidth = recordWidth;
    CGFloat topRecordLineHeight = 0.4;
    topRecordLine.frame = CGRectMake(topRecordLineX, topRecordLineY, topRecordLineWidth, topRecordLineHeight);
    [self.recordView addSubview:topRecordLine];

    //录音控件
    CGFloat audioViewWidth = 105;
    CGFloat audioViewHeight = audioViewWidth;
    CGFloat audioViewX = (SCREEN_WIDTH - audioViewWidth) / 2;
    CGFloat audioViewY = 55;
    
    ShowAudioView *audioView = [[ShowAudioView alloc]initWithFrame:CGRectMake(audioViewX, audioViewY, audioViewWidth, audioViewHeight)];
    audioView.layer.cornerRadius = audioViewWidth / 2;
    audioView.layer.masksToBounds = YES;
    audioView.backgroundColor = [UIColor orangeColor];
    // audioView.backgroundColor = [UIColor lightGrayColor];
    __weak typeof(self)weakSelf = self;
    audioView.recordFinishBlock = ^(NSString *mp3FileName) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf recordViewCatfootedDisappear];
        
        PlayAudioView *playView = [[PlayAudioView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, 60)];
        strongSelf.tabBar.hidden = YES;
        playView.deleteAudioBlock = ^{
          //  __strong typeof(weakSelf)strongSelf = weakSelf;
          //  [strongSelf.audioView deleteRecordAudio];
            
            strongSelf.tabBar.hidden = NO;
            strongSelf.audioView.isDeleteAudio = YES;
            [strongSelf.playView removeFromSuperview];
            
        };
        //playView.backgroundColor = [UIColor lightGrayColor];
        [strongSelf.view addSubview:playView];
        strongSelf.playView = playView;
        
    };
    
    [self.recordView addSubview:audioView];
    self.audioView = audioView;
    
    //提示语
    NSString *hitStr = @"提示: 每次只能录制60秒语音";
    CGSize hitSize = [hitStr sizeWithFont:ComFont];
    UILabel *hitLabel = [[UILabel alloc] init];
    hitLabel.font = ComFont;
    hitLabel.textAlignment = NSTextAlignmentCenter;
    hitLabel.textColor = [UIColor lightGrayColor];
    CGFloat hitLabelX = 0;
    CGFloat hitLabelY = CGRectGetMaxY(audioView.frame) + 77 / 2;
    CGFloat hitLabelWidth = recordWidth;
    CGFloat hitLabelHeight = hitSize.height;
    hitLabel.frame = CGRectMake(hitLabelX, hitLabelY, hitLabelWidth, hitLabelHeight);
    hitLabel.text = hitStr;
    [self.recordView addSubview:hitLabel];


    
}
- (void)deleteRecordAudio
{
    
}
- (void)monitorKeyboardNotification
{
    //UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeNotesViewControllerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeNotesViewControllerKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //UIKeyboardDidShowNotification
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeNotesViewControllerKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}
- (void)takeNotesViewControllerKeyboardWillShow:(NSNotification *)notification
{
    [self recordViewCatfootedDisappear];
}
- (void)takeNotesViewControllerKeyboardWillChangeFrame:(NSNotification *)notification
{
    
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //self.keyboardHeight = keyboardRect.size.height;
       NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // CGRect inputFrame = self.inputView.frame;
    
    //  CGRect inputRect = [self.inputView convertRect:inputFrame toView:self.view];
    
    
   // self.scrollView.y = keyboardRect.origin.y - self.scrollView.height;
   // if (self.tabBar.hidden == NO) {
        
    
    [UIView animateWithDuration:duration animations:^{
        self.tabBar.y = keyboardRect.origin.y - self.tabBar.height;

    }];
   // }
    
    
    // self.tableView.contentInset = UIEdgeInsetsMake(0, 0, inputRect.size.height, 0);
    
    // if (keyboardY < receiverNumInputMaxY) {//keyboardY < receiverNumInputMaxY
    // [UIView animateWithDuration:duration animations:^{
    // NSLog(@"keyboardRect.origin.y = %f",keyboardRect.origin.y);
    //  self.scrollView.y = keyboardRect.origin.y - self.scrollView.height;
    
    // self.tableView.y = self.tableView.y - insectionHeight;
    // [self.tableView setContentOffset:CGPointMake(0, keyboardCoverHeight) animated:YES];
    
    
    //  }];
    
}
- (void)takeNotesViewControllerKeyboardDidShow:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardRect.size.height;
    self.textView.height = SCREEN_HEIGHT - keyboardH - RecordH;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.playView.y = keyboardRect.origin.y - RecordH;

    }];

}

- (void)takeNotesTecordBtnClick:(UIButton *)sender
{
    [self.textView resignFirstResponder];
    self.tabBar.hidden = YES;
    self.recordView.x = SCREEN_WIDTH;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.recordView.x = 0;
    }];
    
    
}
- (void)recordViewCatfootedDisappear
{

    if (0 == self.recordView.frame.origin.x) {
        
        self.tabBar.hidden = NO;

        self.recordView.x = 0;
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.recordView.x = SCREEN_WIDTH;
            
        }];

    }
    

}
#pragma mark---UITextViewDelegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
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
