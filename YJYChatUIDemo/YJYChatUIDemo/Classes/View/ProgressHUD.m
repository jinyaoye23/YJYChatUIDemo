//
//  ProgressHUD.m
//  YJYChatUIDemo
//
//  Created by 叶进耀 on 2017/11/15.
//  Copyright © 2017年 叶进耀. All rights reserved.
//

#import "ProgressHUD.h"

@interface ProgressHUD ()

@property (nonatomic, strong) NSTimer   *myTimer;
@property (nonatomic, assign) int       angle;
@property (nonatomic, strong) UILabel   *centerLB;
@property (nonatomic, strong) UIImageView *edgeImageView;

@property (nonatomic, strong) UIWindow *overlayWindow;

@end

@implementation ProgressHUD

+ (ProgressHUD *)sharedView
{
    static ProgressHUD *sharedView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[ProgressHUD alloc]init];
        sharedView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    });
    return sharedView;
}

+ (void)show
{
    [[ProgressHUD sharedView] show];
}

- (void)show
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) {
            self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
            [self.overlayWindow addSubview:self];
        }
        if (!self.centerLB) {
            self.centerLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150,40)];
            self.centerLB.backgroundColor = [UIColor clearColor];
        }
        if (!self.subTitleLB) {
            self.subTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
            self.subTitleLB.backgroundColor = [UIColor clearColor];
        }
        if (!self.titleLB) {
            self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
            self.titleLB.backgroundColor = [UIColor clearColor];
        }
        if (!self.edgeImageView) {
            self.edgeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Chat_record_circle"]];
        }
        self.subTitleLB.center = CGPointMake(screenSize.width/2, screenSize.height/2+30);
        self.subTitleLB.text = @"Slide up to Cancel";
        self.subTitleLB.textAlignment = NSTextAlignmentCenter;
        self.subTitleLB.font = [UIFont systemFontOfSize:14];
        self.subTitleLB.textColor = [UIColor whiteColor];
        
        self.titleLB.center = CGPointMake(screenSize.width/2, screenSize.height/2-30);
        self.titleLB.text = @"Time Limit";
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.font = [UIFont systemFontOfSize:18];
        self.titleLB.textColor = [UIColor whiteColor];
        
        self.centerLB.center = CGPointMake(screenSize.width/2, screenSize.height/2);
        self.centerLB.text = @"60";
        self.centerLB.textAlignment = NSTextAlignmentCenter;
        self.centerLB.font = [UIFont systemFontOfSize:30];
        self.centerLB.textColor = [UIColor yellowColor];
        
        self.edgeImageView.frame = CGRectMake(0, 0, 154, 154);
        self.edgeImageView.center = self.centerLB.center;
        self.edgeImageView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.edgeImageView];
        [self addSubview:self.centerLB];
        [self addSubview:self.titleLB];
        [self addSubview:self.subTitleLB];
        
        if (self.myTimer) {
            [self.myTimer invalidate];
        }
        self.myTimer = nil;
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        [self setNeedsDisplay];
    });
}

-(void)startAnimation{
    self.angle -= 3;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.09];
    [UIView setAnimationRepeatAutoreverses:YES];
    self.edgeImageView.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180));
    float second = [self.centerLB.text floatValue];
    if (second <= 10.0) {
        self.centerLB.textColor = [UIColor redColor];
    }else{
        self.centerLB.textColor = [UIColor yellowColor];
    }
    self.centerLB.text = [NSString stringWithFormat:@"%0.1f", second-0.1];
    [UIView commitAnimations];
}

+(void)changeSubTitle:(NSString *)str
{
    [[ProgressHUD sharedView] setState:str];
}

-(void)setState:(NSString *)str
{
    self.subTitleLB.text = str;
}

+(void)dismissWithError:(NSString *)str
{
    [[ProgressHUD sharedView] dismiss:str];
}
+(void)dismissWithSuccess:(NSString *)str
{
    [[ProgressHUD sharedView] dismiss:str];
}

- (void)dismiss:(NSString *)state
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.subTitleLB.text = nil;
        self.titleLB.text = nil;
        self.centerLB.text = state;
        self.centerLB.textColor = [UIColor whiteColor];
        
        CGFloat timeLonger;
        if ([state isEqualToString:@"TootShort"]) {
            timeLonger = 1;
        }else{
            timeLonger = 0.6;
        }
        [UIView animateKeyframesWithDuration:timeLonger delay:0 options:UIViewAnimationCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (self.alpha == 0) {
                [self.centerLB removeFromSuperview];
                self.centerLB = nil;
                [self.edgeImageView removeFromSuperview];
                self.edgeImageView = nil;
                [self.subTitleLB removeFromSuperview];
                self.subTitleLB = nil;
                NSMutableArray *windows = [[NSMutableArray alloc]initWithArray:[UIApplication sharedApplication].windows];
                [windows removeObject:self.overlayWindow];
                self.overlayWindow = nil;
                [windows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    UIWindow *window = (UIWindow *)obj;
                    if ([obj isKindOfClass:[UIWindow class]] && [(UIWindow *)obj windowLevel] == UIWindowLevelNormal) {
                        [obj makeKeyWindow];
                        *stop = YES;
                    }
                }];
                
            }
        }];
    });
}

-(UIWindow *)overlayWindow{
    if (_overlayWindow == nil) {
        _overlayWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.userInteractionEnabled = NO;
        [_overlayWindow makeKeyAndVisible];
    }
    return _overlayWindow;
}

@end
