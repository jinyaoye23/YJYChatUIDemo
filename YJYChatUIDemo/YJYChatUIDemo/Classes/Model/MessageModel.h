//
//  MessageModel.h
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UserType) {
    userTypeOther = 0,
    userTypeMe
};
typedef NS_ENUM(NSUInteger, MessageType) {
    MessageTypeText = 0,
    MessageTypePicture,
    MessageTypeVoice
};

@interface MessageModel : NSObject

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) UserType userType;
@property (nonatomic, assign) MessageType messageType;
@end
