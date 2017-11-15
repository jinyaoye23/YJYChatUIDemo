//
//  InputView.h
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputView;
@protocol InputViewDelegate <NSObject>

-(void)inputView:(InputView *)inputView sendMessage:(NSString *)message;
-(void)inputView:(InputView *)inputView sendPicture:(UIImage *)image;
-(void)inputView:(InputView *)inputView sendVoice:(NSDate *)voice time:(NSInteger)secondes;

@end

@interface InputView : UIView

@property (nonatomic, strong) UIButton         *btnSendMessage;
@property (nonatomic, strong) UIButton         *btnChangeVoicState;
@property (nonatomic, strong) UIButton         *btnVoiceRecord;;
@property (nonatomic, strong) UITextView       *textViewInput;
@property (nonatomic, strong) UIViewController *superVC;
@property (nonatomic, weak)   id<InputViewDelegate> delegate;

-(instancetype)initWithSuperVC:(UIViewController *)superVC;

@end
