//
//  ChatCell.h
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel, MessageFrameModel;
@interface ChatCell : UITableViewCell

@property (nonatomic, strong) MessageModel *messageModel;
@property (nonatomic, strong) MessageFrameModel *frameModel;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
