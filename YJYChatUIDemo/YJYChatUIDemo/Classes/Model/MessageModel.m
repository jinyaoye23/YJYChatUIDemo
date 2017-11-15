//
//  MessageModel.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(void)setUserType:(UserType)userType{
    _userType = userType;
    _iconName = userType ? @"1": @"2.jpg";
}

@end
