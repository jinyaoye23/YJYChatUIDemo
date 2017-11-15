//
//  MessageFrameModel.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "MessageFrameModel.h"
#import "MessageModel.h"

@implementation MessageFrameModel

-(void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    
    //1.计算时间的高度
    if (_showTime) {
        
    }
    //2.计算头像的位置
    CGFloat iconX = ChatMargin;
    if (messageModel.userType == userTypeMe) {
        iconX = SCREEN_WIDTH-ChatMargin-ChatIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + ChatMargin;
    _iconFrame = CGRectMake(iconX, iconY, ChatIconWH, ChatIconWH);
    
    //3.计算内容
    CGFloat airViewX = CGRectGetMaxX(_iconFrame) + ChatMargin;
    CGFloat airViewY = iconY;
    CGFloat contentX = airViewX+ChatContentLet;
    CGFloat contentY = iconY+ChatMargin;
    
    CGSize airViewSize;
    CGSize contentSize;
    switch (_messageModel.messageType) {
        case MessageTypeText:
            contentSize = [messageModel.content boundingRectWithSize:CGSizeMake(ChatContextW, MAXFLOAT) options:1 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
            airViewSize = CGSizeMake(contentSize.width+ChatContentLet+ChatContentRight, contentSize.height+ChatContentTop+ChatContentBottom);
            break;
        case MessageTypePicture:
            contentSize = CGSizeMake(ChatPicWD-ChatMargin, ChatPicWD-ChatMargin);
            airViewSize = CGSizeMake(ChatPicWD, ChatPicWD);
            break;
        case MessageTypeVoice:
            contentSize = CGSizeMake(120, 20);
            airViewSize = contentSize;
        default:
            break;
    }
    
    if (_messageModel.userType == userTypeMe) {
        airViewX = iconX - airViewSize.width  - ChatContentRight-ChatContentLet;
        contentX = airViewX+ChatContentRight;
    }
    _contentFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    _airViewFrame = CGRectMake(airViewX, airViewY, airViewSize.width, airViewSize.height);
    
    _cellHeiht = CGRectGetMaxY(_airViewFrame) + ChatMargin;
}

@end
