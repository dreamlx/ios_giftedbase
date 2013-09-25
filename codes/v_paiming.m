//
//  v_paiming.m
//  tcxly
//
//  Created by Li yi on 13-9-11.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_paiming.h"
#import "UIView+iTextManager.h"
#import "UIView+iAnimationManager.h"

@implementation v_paiming

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
       p0=  [self addImageView:self
                     image:@"pm_bg1.png"
                  position:CGPointMake(70, 73)];
        
       p1= [self addImageView:self
                     image:@"pm_bg2.png"
                  position:CGPointMake(70, 768)];
        
        
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
    
    NSData *jsonData = [r responseData];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *items=(NSDictionary*)jsonObject;
    
    
    NSArray *rank=(NSArray*)[items objectForKey:@"user_rankings"];
    
    NSLog(@"%d",[rank count]);
    

    for (int i=0; i<3; i++) {
        
        id aid=[[rank objectAtIndex:i] objectForKey:@"avatar_id"];
        
        UIImageView *im;
       
        
        if(aid && ![aid isKindOfClass:[NSNull class]])
        {
            im=[self addImageView:p0
                            image:[NSString stringWithFormat:@"avatar_%@.jpg",aid]
                         position:CGPointMake(40, 83+i*122)];
        }
        else
        {
            im=[self addImageView:p0
                            image:@"avatar_1.jpg"
                         position:CGPointMake(40, 83+i*122)];
        }

        
        CGRect f=im.frame;
        f.size.width=f.size.height=110;
        im.frame=f;
        
        
        
        //名字
        UILabel *un=[self addLabel:p0
                             frame:CGRectMake(161, 115+i*120, 180, 50)
                              font:[UIFont boldSystemFontOfSize:20]
                              text:[[[rank objectAtIndex:i] objectForKey:@"user"] objectForKey:@"username"]
                             color:[UIColor blackColor]
                               tag:0];
        
        un.textAlignment=UITextAlignmentCenter;
        
        

        
        
        //成绩
        un=[self addLabel:p0
                    frame:CGRectMake(368, 115+i*120, 180, 50)
                     font:[UIFont boldSystemFontOfSize:20]
                     text:[NSString stringWithFormat:@"%d",[[[rank objectAtIndex:i] objectForKey:@"total_point"] integerValue]]
                    color:[UIColor blackColor]
                      tag:0];
        
        un.textAlignment=UITextAlignmentCenter;
        
        
        
        
        //排名
        un=[self addLabel:p0
                    frame:CGRectMake(572, 115+i*120, 121, 50)
                     font:[UIFont boldSystemFontOfSize:20]
                     text:[NSString stringWithFormat:@"第%d名",i+1]
                    color:[UIColor blackColor]
                      tag:0];
        
        un.textAlignment=UITextAlignmentCenter;
        
    }
    
    
    
    //第四名
    if([items count]>3)
    {
        
        id aid=[[rank objectAtIndex:3] objectForKey:@"avatar_id"];
        
        UIImageView *im;
        
        
        if(aid && ![aid isKindOfClass:[NSNull class]])
        {
            im=[self addImageView:p1
                            image:[NSString stringWithFormat:@"avatar_%@.jpg",aid]
                         position:CGPointMake(40, 83)];
        }
        else
        {
            im=[self addImageView:p1
                            image:@"avatar_1.jpg"
                         position:CGPointMake(40, 83)];
        }
        
        
        CGRect f=im.frame;
        f.size.width=f.size.height=110;
        im.frame=f;
        
        
        
        
        
        //名字
        UILabel *un=[self addLabel:p1
                             frame:CGRectMake(161, 115, 180, 50)
                              font:[UIFont boldSystemFontOfSize:20]
                              text:[[[rank objectAtIndex:3] objectForKey:@"user"] objectForKey:@"username"]
                             color:[UIColor blackColor]
                               tag:0];
        
        un.textAlignment=UITextAlignmentCenter;
        
        

        //成绩
        un=[self addLabel:p1
                    frame:CGRectMake(368, 115, 180, 50)
                     font:[UIFont boldSystemFontOfSize:20]
                     text:[NSString stringWithFormat:@"%d",[[[rank objectAtIndex:3] objectForKey:@"total_point"] integerValue]]
                    color:[UIColor blackColor]
                      tag:0];
        
        un.textAlignment=UITextAlignmentCenter;
        

        //排名
        un=[self addLabel:p1
                    frame:CGRectMake(572, 115, 121, 50)
                     font:[UIFont boldSystemFontOfSize:20]
                     text:[NSString stringWithFormat:@"第%d名",100]
                    color:[UIColor blackColor]
                      tag:0];
        
        
        un.textAlignment=UITextAlignmentCenter;
        
        [self addLabel:p1
                 frame:CGRectMake(582, 20, 260, 50)
                  font:[UIFont boldSystemFontOfSize:20]
                  text:[NSString stringWithFormat:@"在线学员：%d",[[[rank objectAtIndex:3] objectForKey:@"users_count"] integerValue]]
                 color:[UIColor whiteColor]
                   tag:0];


        [UIView animateWithDuration:1
                         animations:^{
                    
                            p1.center=[self LeftPointToCenter:CGPointMake(70, 550) view:p1];
                             
                         }];
    }
    
}



//请求回调 ---------------------------------------------------------------------------------------------------
- (void)requestFailed:(ASIHTTPRequest *)r
{
    NSError *error = [r error];
    NSLog(@"reg:%@",error);
}


-(void)loadCurrentPage:(int)cmd
{

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
