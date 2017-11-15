//
//  InputView.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "InputView.h"

@interface InputView ()

@property (nonatomic, assign) BOOL    isBeginRecord;

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
        self.textViewInput.text = @"Input the contents here";
        self.textViewInput.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.textViewInput];
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    }
    
    
    return self;
}

#pragma mark -- Action -- 
-(void)beginRecordVoice:(UIButton *)sender
{

}
-(void)endRecordVoice:(UIButton *)sender
{

}
-(void)cancelRecordVoice:(UIButton *)sender
{
    
}
-(void)remindDragExit:(UIButton *)sender
{

}
-(void)remindDragEnter:(UIButton *)sender
{
    
}
-(void)countVoiceTime
{
    
}
-(void)sendMessage:(UIButton *)sender
{

}

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


@end
