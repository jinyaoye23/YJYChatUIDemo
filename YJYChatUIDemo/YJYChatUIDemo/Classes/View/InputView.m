//
//  InputView.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "InputView.h"

@interface InputView ()<UITextViewDelegate>

@property (nonatomic, assign) BOOL    isBeginRecord;
@property (nonatomic, assign) BOOL    isAbleSendMessage;
@property (nonatomic, strong) UILabel *placeholdLB;

@end

@implementation InputView

-(instancetype)initWithSuperVC:(UIViewController *)superVC
{
    self.superVC = superVC;
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //发送消息按钮
        self.btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSendMessage.frame = CGRectMake(SCREEN_WIDTH-40, 5, 30, 30);
        self.isBeginRecord = NO;
        [self.btnSendMessage setBackgroundImage:[UIImage imageNamed:@"Chat_take_picture"] forState:UIControlStateNormal];
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSendMessage];
        
        //改变状态（语音、文字）
        self.btnChangeVoicState = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChangeVoicState.frame = CGRectMake(5, 5, 30, 30);
        [self.btnChangeVoicState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        self.isBeginRecord = NO;
        [self.btnChangeVoicState addTarget:self action:@selector(voiceRecord:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChangeVoicState];
        
        //语音录入键
        self.btnVoiceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnVoiceRecord.frame = CGRectMake(70, 5, SCREEN_WIDTH-70*2, 30);
        self.btnVoiceRecord.hidden = YES;
        [self.btnVoiceRecord setBackgroundImage:[UIImage imageNamed:@"chat_message_back"] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [self.btnVoiceRecord setTitle:@"Hold to talk" forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitle:@"Ready to record" forState:UIControlStateHighlighted];
        [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [self.btnVoiceRecord addTarget:self action:@selector(remindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self.btnVoiceRecord addTarget:self action:@selector(remindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:self.btnVoiceRecord];
        
        //输入框
        self.textViewInput = [[UITextView alloc]initWithFrame:CGRectMake(45, 5, SCREEN_WIDTH-2*45, 30)];
        self.textViewInput.delegate = self;
        self.textViewInput.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        self.textViewInput.layer.cornerRadius = 3;
        self.textViewInput.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        self.textViewInput.layer.borderWidth = 1;
        [self addSubview:self.textViewInput];
        
        self.placeholdLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-2*45-20, 30)];
        self.placeholdLB.text = @"Input the contents here";
        self.placeholdLB.textColor = [UIColor lightGrayColor];
        self.placeholdLB.font = [UIFont systemFontOfSize:14];
        [self.textViewInput addSubview:self.placeholdLB];
        
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    }
    
    
    return self;
}

#pragma mark -- Action -- 
-(void)beginRecordVoice:(UIButton *)sender
{
    NSLog(@"begin record");
}
-(void)endRecordVoice:(UIButton *)sender
{
    NSLog(@"end record");
}
-(void)cancelRecordVoice:(UIButton *)sender
{
    NSLog(@"cancel record");
}
-(void)remindDragExit:(UIButton *)sender
{
    NSLog(@"remind drag Exit");
}
-(void)remindDragEnter:(UIButton *)sender
{
    NSLog(@"remind drag enter");
}
-(void)countVoiceTime
{
    
}
//发送信息图片
-(void)sendMessage:(UIButton *)sender
{
    
    if (self.isAbleSendMessage) {
        NSLog(@"message:\n%@", self.textViewInput.text);
        if ([self.delegate respondsToSelector:@selector(inputView:sendMessage:)]) {
            [self.delegate inputView:self sendMessage:self.textViewInput.text];
        }
        self.textViewInput.text = @"";
    }else{
        UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.superVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertSheet addAction:cameraAction];
        [alertSheet addAction:libraryAction];
        [alertSheet addAction:cancelAction];
        [self.superVC presentViewController:alertSheet animated:YES completion:nil];
    }
    
}
//改变输入文字或录音的状状态
-(void)voiceRecord:(UIButton *)sender
{
    self.btnVoiceRecord.hidden = !self.btnVoiceRecord.hidden;
    self.textViewInput.hidden = !self.textViewInput.hidden;
    self.isBeginRecord = !self.isBeginRecord;
    if (self.isBeginRecord) {
        [self.btnChangeVoicState setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        [self.textViewInput resignFirstResponder];
    }else{
        [self.btnChangeVoicState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        [self.textViewInput becomeFirstResponder];
    }
    
}

#pragma mark -- UITextViewDelegate --
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholdLB.hidden = textView.text.length;
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.placeholdLB.hidden = textView.text.length > 0;
    [self changeSendButtonWithPhoto:textView.text.length>0?NO:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.placeholdLB.hidden = textView.text.length > 0;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

-(void)changeSendButtonWithPhoto:(BOOL)isPhoto
{
    self.isAbleSendMessage = !isPhoto;
    [self.btnSendMessage setTitle:isPhoto?@"":@"发送" forState:UIControlStateNormal];
    self.btnSendMessage.frame = RECT_CHANGE_width(self.btnSendMessage, isPhoto?30:35);
    self.btnSendMessage.titleLabel.font = [UIFont systemFontOfSize:14];
    UIImage *image = [UIImage imageNamed:isPhoto?@"Chat_take_picture":@"chat_send_message"];
    [self.btnSendMessage setBackgroundImage:image forState:UIControlStateNormal];
}

@end
