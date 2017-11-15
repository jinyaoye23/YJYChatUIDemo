//
//  YJYImageAvatarBrowser.m
//  ImageAvatarBrowserDemo
//
//  Created by Yao on 2017/11/13.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "YJYImageAvatarBrowser.h"

static UIImageView *orginImageView;
@implementation YJYImageAvatarBrowser

+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image = avatarImageView.image;
    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    //window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //蒙板
    UIView *bgView = [[UIView alloc]initWithFrame:window.bounds];
    //将avatarImageView的坐标系转移到window上
    CGRect oldFrame = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    bgView.alpha = 1;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldFrame];
    imageView.image = image;
    imageView.tag = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [bgView addSubview:imageView];
    [window addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [bgView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.25 animations:^{
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        bgView.alpha = 1;
    }];
    
}

//隐藏图片
+(void)hideImage:(UITapGestureRecognizer *)tap{
    UIView *bgView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.25 animations:^{
        imageView.frame = [orginImageView convertRect:orginImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        orginImageView.alpha = 1;
        bgView.alpha = 0;
    }];
}


@end
