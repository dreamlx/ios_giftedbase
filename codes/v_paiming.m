//
//  v_paiming.m
//  tcxly
//
//  Created by Li yi on 13-9-11.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_paiming.h"

@implementation v_paiming

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        [self addImageView:self
                     image:@"pm_bg1.png"
                  position:CGPointMake(70, 73)];
        
        [self addImageView:self
                     image:@"pm_bg2.png"
                  position:CGPointMake(70, 542)];
        
        
        [self addButton:self
                  image:@"qq_back.png"
               position:CGPointMake(30, 30)
                    tag:1003
                 target:self
                 action:@selector(backClick:)
         ];

    }
    return self;
}

- (void)requestFinished:(ASIHTTPRequest *)r
{
    NSLog(@"%@",[r responseString]);
}



//请求回调 ---------------------------------------------------------------------------------------------------
- (void)requestFailed:(ASIHTTPRequest *)r
{
    NSError *error = [r error];
    NSLog(@"reg:%@",error);
}


-(void)loadCurrentPage:(int)cmd
{
  //  http://127.0.0.1:3000/api/ranks/ranking.json?auth_token=L1M1NXGpFayafaQasky7 -d "grade_id=1"
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://gifted-center.com/api/ranks/ranking.json?auth_token=%@&grade_id=1",token]];
    
    NSLog(@"%@",url);
    
    
    request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setRequestMethod:@"GET"];
    request.timeOutSeconds=60;
    [request startAsynchronous];
    
    
    
    
}

-(void)backClick:(UIButton*)sender
{
    [self fadeOutView:self
             duration:.5];
}








@end
