//
//  ProgressHUD.h
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/15.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressHUD : UIView

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *subTitleLB;

+ (void)show;

+ (void)dismissWithSuccess:(NSString *)str;

+ (void)dismissWithError:(NSString *)str;

+ (void)changeSubTitle:(NSString *)str;

@end
