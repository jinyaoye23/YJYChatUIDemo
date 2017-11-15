//
//  InputView.h
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

@property (nonatomic, strong) UIButton         *btnSendMessage;
@property (nonatomic, strong) UIButton         *btnChangeVoicState;
@property (nonatomic, strong) UIButton         *btnVoiceRecord;;
@property (nonatomic, strong) UITextView       *textViewInput;
@property (nonatomic, strong) UIViewController *superVC;

-(instancetype)initWithSuperVC:(UIViewController *)superVC;

@end
