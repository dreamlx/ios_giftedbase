//
//  profile.m
//  tcxly
//
//  Created by Li yi on 13-9-14.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "profile.h"
#import "UIView+iTextManager.h"
#import "UIView+iAnimationManager.h"

@implementation profile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        
        
        [self addImageView:self
                     image:@"profile_0_0.png"
                  position:CGPointMake(407, 41)];
        
        
        UIImageView *pa = [self addImageView:self
                                       image:@"profile_0_bg.jpg"
                                    position:CGPointMake(56, 800)];
        
        pa.userInteractionEnabled=YES;
        
        
        
        UIScrollView *sv=[self addScrollView:pa
                                    delegate:self
                                       frame:CGRectMake(231, 22, 640, 480)
                                     bounces:YES
                                        page:NO
                                       showH:NO
                                       showV:YES];
 
        
        username = [self addLabel:sv
                            frame:CGRectMake(102, 27, 50, 30)
                             font:[UIFont systemFontOfSize:25]
                             text:@""
                            color:[UIColor blackColor]
                              tag:1000];
        
        sex = [self addLabel:sv
                       frame:CGRectMake(102, 100, 50, 30)
                        font:[UIFont systemFontOfSize:25]
                        text:@""
                       color:[UIColor blackColor]
                         tag:1000];

        
        sv.contentSize=CGSizeMake(640, 900);
        
        
        [self addImageView:pa
                     image:@"avatar_1.jpg"
                  position:CGPointMake(20, 20)];
        
        
        [self addButton:self
                  image:@"qq_back.png"
               position:CGPointMake(30, 30)
                    tag:1003
                 target:self
                 action:@selector(backClick:)];
        
        
        
        [self addImageView:sv
                     image:@"profile_0_list.png"
                  position:CGPointMake(0, 0)];
        
        
        
        //年月日
        UITextField *t= [self addTextField:sv
                                     frame:CGRectMake(102, 162, 114, 30)
                                      font:[UIFont systemFontOfSize:25]
                                     color:[UIColor blackColor]
                               placeholder:nil
                                       tag:0];

        
        [self addTextField:sv
                     frame:CGRectMake(257, 162, 50, 30)
                      font:[UIFont systemFontOfSize:25]
                     color:[UIColor blackColor]
               placeholder:nil
                       tag:0];
        
        
        [self addTextField:sv
                     frame:CGRectMake(345, 162, 50, 30)
                      font:[UIFont systemFontOfSize:25]
                     color:[UIColor blackColor]
               placeholder:nil
                       tag:0];
        
        
        NSMutableArray *pos=[NSMutableArray array];
        
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(123, 233)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(156, 306)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(156, 378)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(156, 450)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(156, 523)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(156, 596)]];

        
        for (int i=0; i<[pos count]; i++) {
            CGPoint p=[[pos objectAtIndex:i] CGPointValue];
            
            [self addTextField:sv
                         frame:CGRectMake(p.x, p.y, 246, 30)
                          font:[UIFont systemFontOfSize:25]
                         color:[UIColor blackColor]
                   placeholder:nil
                           tag:1000+i];
            
        }
        
        
        [self addButton:pa
                  image:@"profile_0_bt.png"
               position:CGPointMake(690, 520)
                    tag:1000
                 target:self
                 action:@selector(onDown:)];
        
        

        [UIView animateWithDuration:1
                         animations:^{
                             //106
                             pa.center=[self LeftPointToCenter:CGPointMake(56, 106) view:pa];
                             
                         }];
        
        
    }
    return self;
}


-(void)loadP:(NSDictionary*)p
{

    NSLog(@"%@",p);
    
    username.text=[p objectForKey:@"username"];
    
    if([[p objectForKey:@"gender"] isEqualToString:@"m"])
    {
        sex.text=@"男";
    }
    else
    {
        sex.text=@"女";
    }
    
    
    
    
    
}


-(void)onDown:(UIButton*)sender
{
//    url：http://0.0.0.0:3000/api/profiles.json?auth_token=7NZPuMgEWzBNjQ8EAcUc
//    
//    method：put
//    
//    新增参数：
//    
//    qq,parent_name, birthday(yy-mm-dd), school_address,school_name,home_address
//    
//    qq号码，家长名字，生日（年月日），学校地址，学校名字，家庭地址
//    
    
    /*
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://gifted-center.com/api/profiles.json?auth_token=%@&",token]];
    
    NSLog(@"%@",url);
    
    
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setRequestMethod:@"PUT"];
    request.timeOutSeconds=60;
    [request startAsynchronous];
     */
    
}


-(void)backClick:(UIButton*)sender
{
    [self fadeOutView:self duration:.5];
    
}


@end
