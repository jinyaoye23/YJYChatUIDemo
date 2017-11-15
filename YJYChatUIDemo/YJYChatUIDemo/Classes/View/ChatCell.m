//
//  ChatCell.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "ChatCell.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"

@interface ChatCell ()

@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *contentLB;
@property (nonatomic, strong) UILabel *messageLB;
@property (nonatomic, strong) UIImageView *airIV;


@end

@implementation ChatCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconIV];
        [self.contentView addSubview:self.airIV];
        [self.contentView addSubview:self.contentLB];
    }
    return self;
}

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"chatCell";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}
-(void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    self.contentLB.text = messageModel.content;
}
-(void)setFrameModel:(MessageFrameModel *)frameModel{
    _frameModel = frameModel;
    self.iconIV.image = frameModel.messageModel.userType ? [UIImage imageNamed:@"1.png"] : [UIImage imageNamed:@"2.jpg"];
    self.iconIV.frame = frameModel.iconFrame;
    self.contentLB.frame = frameModel.contentFrame;
    self.contentLB.text = frameModel.messageModel.content;
    self.airIV.image = frameModel.messageModel.userType ? [UIImage strechableImage:@"chat_send_nor"] : [UIImage strechableImage:@"chat_receive_nor_p"];
    self.airIV.frame = frameModel.airViewFrame;
}


-(UIImageView *)iconIV{
    if (_iconIV == nil) {
        _iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        _iconIV.contentMode = UIViewContentModeScaleAspectFit;
        _iconIV.backgroundColor = [UIColor brownColor];
        _iconIV.layer.cornerRadius = 22;
        [_iconIV.layer setMasksToBounds:YES];
    }
    return _iconIV;
}
-(UILabel *)contentLB{
    if (_contentLB == nil) {
        _contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
        _contentLB.textColor = [UIColor darkTextColor];
        _contentLB.font = [UIFont systemFontOfSize:15];
        _contentLB.numberOfLines = 0;
        _contentLB.backgroundColor = [UIColor clearColor];
    }
    return _contentLB;
}
-(UILabel *)messageLB{
    if (_messageLB == nil) {
        _messageLB = [[UILabel alloc]init];
        _messageLB.textColor = [UIColor blackColor];
        _messageLB.numberOfLines = 0;
        _messageLB.backgroundColor = [UIColor clearColor];
    }
    return _messageLB;
}
-(UIImageView *)airIV{
    if (_airIV == nil) {
        _airIV = [[UIImageView alloc]init];
    }
    return _airIV;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
