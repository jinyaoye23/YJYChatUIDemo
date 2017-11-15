//
//  RootViewController.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/13.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "RootViewController.h"
#import "ChatCell.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"
#import "InputView.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) InputView      *inputView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContaints;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configData];
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.inputView = [[InputView alloc]initWithSuperVC:self];
    [self.view addSubview:self.inputView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- UITableViewDelegation & DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *cell = [ChatCell createCellWithTableView:tableView];
    cell.frameModel = self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFrameModel *frameModel = self.dataArr[indexPath.row];
    return [frameModel cellHeiht];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

#pragma mark -- Notification --
-(void)keyboardChange:(NSNotification *)noti
{
    NSDictionary *userInfo = [noti userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    if (noti.name == UIKeyboardWillShowNotification) {
        self.bottomContaints.constant = keyboardEndFrame.size.height+40;
    }else{
        self.bottomContaints.constant = 40;
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = self.inputView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    self.inputView.frame = newFrame;
    
    [UIView commitAnimations];

}
-(void)configData{
    self.dataArr = [NSMutableArray array];
    NSArray *contentArr = @[@"今天天气好凉爽，出去爬山吧,今天天气好凉爽，出去爬山吧",@"今天天气好凉爽，出去爬山吧,今天天气好凉爽，出去爬山吧",@"窗前明月光，疑似地上霜。举头望明月，低头思故乡",@"你好啊你好啊你好啊你好啊你好啊你好啊你好啊"];
    NSInteger index = arc4random()%contentArr.count;
    MessageModel *model1 = [[MessageModel alloc]init];
    model1.content = contentArr[index];
    model1.userType = userTypeMe;
    MessageFrameModel *frameModel1 = [[MessageFrameModel alloc]init];
    frameModel1.messageModel = model1;
    [self.dataArr addObject:frameModel1];
    
    MessageModel *model2 = [[MessageModel alloc]init];
    model2.content = contentArr [index];
    model2.userType = userTypeOther;
    MessageFrameModel *frameModel2 = [[MessageFrameModel alloc]init];
    frameModel2.messageModel = model2;
    [self.dataArr addObject:frameModel2];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
