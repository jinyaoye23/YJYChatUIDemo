//
//  MessageFrameModel.h
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ChatMargin 10        //间隔
#define ChatIconWH 44        //头像的宽高
#define ChatPicWD  200       //图片的宽高
#define ChatContextW 200     //内容的宽度
#define ChatTimeMarginW 15   //时间文本与边框的间隔宽度
#define ChatTimeMarginH 10   //时间文本与边框的间隔高度
#define ChatContentTop  15   //文本内容与气泡上边的间隔
#define ChatContentLet  15
#define ChatContentBottom 10
#define ChatContentRight  15

#define ChatTimeFont [UIFont systemFontOfSize:11]   //时间字体
#define ChatContentFont [UIFont systemFontOfSize:14]//内容字体

@class MessageModel;
@interface MessageFrameModel : NSObject

@property (nonatomic, strong) MessageModel *messageModel;

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect nickFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect airViewFrame;
@property (nonatomic, strong) NSMutableAttributedString *attMessage;

@property (nonatomic, assign) CGFloat cellHeiht;
@property (nonatomic, assign) BOOL    showTime;
@end
