//
//  UIImage+Extension.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/14.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


+(instancetype)imageWithOriginName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
+(instancetype)strechableImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
}


@end
