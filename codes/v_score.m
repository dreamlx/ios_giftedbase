//
//  v_score.m
//  tcxly
//
//  Created by Terry on 13-5-5.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_score.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "v_enter.h"
#import "UIView+iTextManager.h"

@implementation v_score

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        UIImageView *light = [self addImageView:self
                                          image:@"et_light.png"
                                       position:CGPointMake(286, 0)
                              ];
        
        CAKeyframeAnimation *rock;
        rock = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        [rock setDuration:3];
        [rock setRepeatCount:HUGE_VALF];
        [rock setFillMode:kCAFillModeForwards];
        
        NSMutableArray *values = [NSMutableArray array];
        
        [values addObject:[NSNumber numberWithFloat:1.0]];
        [values addObject:[NSNumber numberWithFloat:1.5]];
        [values addObject:[NSNumber numberWithFloat:1.0]];
        
        [rock setValues:values];
        
        [[light layer] addAnimation:rock forKey:@"transform"];
        
        [self addImageView:self
                     image:@"se_dog.png"
                  position:CGPointMake(418, 533)];
        
        [self addButton:self
                  image:@"se_shouc.png"
               position:CGPointMake(736, 578)
                    tag:2000
                 target:self
                 action:@selector(scClick:)
         ];
        
    }
    return self;
}

-(void)scClick:(UIButton*)e {
    v_enter *ve = [[v_enter alloc] initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:ve duration:.5];
    [ve loadCurrentPage:1];
}

-(void)loadCurrentPage:(int)cmd {
    
    [self setLoading];
    
    NSLog(@"cmd = %d", cmd);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://gifted-center.com/api/exams/%d/finish_uploading.json?auth_token=L1M1NXGpFayafaQasky7", cmd]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.tag = 60001;
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
}

#pragma mark –
#pragma mark 请求完成 requestFinished

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    NSLog(@"failed");
    NSError *error = [request error];
    NSLog(@"login:%@",error);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"网络无法连接"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
}

- (void)requestFinished:(ASIHTTPRequest *)req
{
    
    if(req.tag == 60001) {
        NSLog(@"successed");
        NSLog(@"%@", [req responseString]);
        NSData *jsonData = [req responseData];
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://gifted-center.com/api/exams/%d.json?auth_token=L1M1NXGpFayafaQasky7", [[deserializedDictionary objectForKey:@"id"] integerValue ]]];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        [request startAsynchronous];
    }else {
        
        [self clearUnuseful];
        
        NSLog(@"%@", [req responseString]);
        NSData *jsonData = [req responseData];
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        NSArray *arr = [deserializedDictionary objectForKey:@"answers"];
        int anspoint = 0;
        for (int i = 0; i < [arr count]; i ++) {
            anspoint += [[arr[i] objectForKey:@"point"] integerValue];
        }
        
        NSLog(@"point = %d", anspoint);
        
        UILabel *txt = [self addLabel:self
                                frame:CGRectMake(0, 0, 1024, 768)
                                 font:[UIFont fontWithName:@"Gretoon" size:200]
                                 text:@""
                                color:[UIColor colorWithRed:19.f/255.f green:226.f/255.f blue:243.f/255.f alpha:1]
                                  tag:5000
                        ];
        txt.text = [NSString stringWithFormat:@"%d", anspoint];
        txt.shadowOffset=CGSizeMake(5, 5);
        txt.shadowColor=[UIColor colorWithWhite:-1 alpha:.5];
        txt.textAlignment = NSTextAlignmentCenter;
        txt.center = CGPointMake(512, 350);
        
        txt.transform = CGAffineTransformMakeScale(1.5, 1.5);
        txt.alpha = 0;
        
        [UIView animateWithDuration:.5
                         animations:^{
                             txt.transform = CGAffineTransformMakeScale(1, 1);
                             txt.alpha = 1;
                         }
         ];
    }
    
}

-(void)setLoading {
    UIView *ldv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    ldv.tag = 9997;
    ldv.backgroundColor = [UIColor blackColor];
    [self addSubview:ldv];
    ldv.alpha = .3;
    
    UIActivityIndicatorView *loginLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    [loginLoading setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height/2)];
    loginLoading.tag = 9991;
    [self addSubview:loginLoading];
    [loginLoading startAnimating];
    
    UILabel *txt = [self addLabel:self
                            frame:CGRectMake(0, 0, 200, 100)
                             font:[UIFont systemFontOfSize:18]
                             text:@"正在计算分数..."
                            color:[UIColor whiteColor]
                              tag:9992
                    ];
    txt.shadowColor = [UIColor blackColor];
    txt.textAlignment = UITextAlignmentCenter;
    txt.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height/2 + 50);
}

-(void)clearUnuseful {
    UIActivityIndicatorView *loginLoading = (UIActivityIndicatorView*)[self viewWithTag:9991];
    [loginLoading stopAnimating];
    [loginLoading removeFromSuperview];
    [[self viewWithTag:9992] removeFromSuperview];
    [[self viewWithTag:9997] removeFromSuperview];
}

@end
