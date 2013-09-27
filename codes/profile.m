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
#import "selectAvatar1.h"
#import "personal.h"

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
                            frame:CGRectMake(102, 27, 300, 30)
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
        
        

        
        
        avatar=[self addButtonWithImageView:pa
                                      image:@"avatar_1.jpg"
                                  highlight:nil
                                   position:CGPointMake(20, 20)
                                          t:3000
                                     action:@selector(onADown:)];


        

        [self addButton:self
                  image:@"qq_back.png"
               position:CGPointMake(906, 30)
                    tag:1003
                 target:self
                 action:@selector(backClick:)];
        
        
        
        [self addImageView:sv
                     image:@"profile_0_list.png"
                  position:CGPointMake(0, 0)];
        
        
        
        //年月日
        year= [self addTextField:sv
                           frame:CGRectMake(102, 162, 114, 30)
                            font:[UIFont systemFontOfSize:25]
                           color:[UIColor blackColor]
                     placeholder:nil
                             tag:0];
        
        
        month=[self addTextField:sv
                           frame:CGRectMake(257, 162, 50, 30)
                            font:[UIFont systemFontOfSize:25]
                           color:[UIColor blackColor]
                     placeholder:nil
                             tag:0];
        
        
        day=[self addTextField:sv
                         frame:CGRectMake(345, 162, 50, 30)
                          font:[UIFont systemFontOfSize:25]
                         color:[UIColor blackColor]
                   placeholder:nil
                           tag:0];
        
        
        
         year.keyboardType=UIKeyboardTypeNumberPad;
         month.keyboardType=UIKeyboardTypeNumberPad;
         day.keyboardType=UIKeyboardTypeNumberPad;
        
        
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
                           tag:1100+i];
        }
        
        qq=(UITextField*)[self viewWithTag:1100];
        qq.keyboardType=UIKeyboardTypeNumberPad;
        
        
        email=(UITextField*)[self viewWithTag:1101];
        homeName=(UITextField*)[self viewWithTag:1102];
        homeAddress=(UITextField*)[self viewWithTag:1103];
        schoolName=(UITextField*)[self viewWithTag:1104];
        schoolAddress=(UITextField*)[self viewWithTag:1105];
        

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


-(void)onADown:(id)sender
{
    selectAvatar1 *p=[[selectAvatar1 alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [p loadCurrentPage:0];
    [self fadeInView:p duration:.5];
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
    
    
    //头像
    aid=[p objectForKey:@"avatar_id"];
    
    if(aid && ![aid isKindOfClass:[NSNull class]])
    {
        avatar.image=[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%@.jpg",aid]];
    }
    else
    {
        aid=@"1";
    }
    

    
    
    //生日
    id birthday=[p objectForKey:@"birthday"];
    
    if(birthday && ![birthday isKindOfClass:[NSNull class]])
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        
        NSDate *ld= [dateFormatter dateFromString:birthday];
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        comps = [calendar components:unitFlags fromDate:ld];

        
        int yy = [comps year];
        int mm = [comps month];
        int dd = [comps day];

        
        year.text=[NSString stringWithFormat:@"%d",yy];
        month.text=[NSString stringWithFormat:@"%d",mm];
        day.text=[NSString stringWithFormat:@"%d",dd];
    
    }
    
    
    //qq
    id q=[p objectForKey:@"qq"];
    
    if(q && ![q isKindOfClass:[NSNull class]])
    {
        qq.text=q;
    }
    
    id ha=[p objectForKey:@"home_address"];
    
    if(ha && ![ha isKindOfClass:[NSNull class]])
    {
        homeAddress.text=ha;
    }
    
    id hn=[p objectForKey:@"parent_name"];
    
    if(hn && ![hn isKindOfClass:[NSNull class]])
    {
        homeName.text=ha;
    }
    
    id sa=[p objectForKey:@"school_address"];
    
    if(sa && ![sa isKindOfClass:[NSNull class]])
    {
        schoolAddress.text=sa;
    }
    
    id sn=[p objectForKey:@"school_name"];
    
    if(sn && ![sn isKindOfClass:[NSNull class]])
    {
        schoolName.text=sn;
    }
    
    id em=[p objectForKey:@"email"];
    
    if(em && ![em isKindOfClass:[NSNull class]])
    {
        email.text=em;
    }

    
}


-(void)updateAvatar:(int)a
{
    avatar.image=[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d.jpg",a]];
    aid=[NSString stringWithFormat:@"%d",a];
}



-(void)onDown:(UIButton*)sender
{
    
    NSString *dateString =[NSString stringWithFormat:@"%@-%@-%@",year.text,month.text,day.text];
 
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://gifted-center.com/api/profiles.json?auth_token=%@&avatar_id=%@&birthday=%@&home_address=%@&parent_name=%@&school_address=%@&school_name=%@&qq=%@&email=%@",
                                       token,
                                       aid,
                                       dateString,
                                       homeAddress.text,
                                       homeName.text,
                                       schoolAddress.text,
                                       schoolName.text,
                                       qq.text,
                                       email.text]];
    
    NSLog(@"%@",url);
    
    
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setRequestMethod:@"PUT"];
    request.timeOutSeconds=60;
    [request startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)r
{
    NSLog(@"%@",[r responseString]);
    
    NSData *jsonData = [r responseData];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    //NSLog(@"%@",jsonObject);
    

    //已经存在帐户了

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    NSMutableArray *testArray=[[NSMutableArray alloc] init];
    [testArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"accountArray"]];

    for (int i=0; i<[testArray count]; i++) {
        
        NSString *tk=  [[testArray objectAtIndex:i] objectForKey:@"token"];
        
        if([tk isEqualToString:token])
        {
            //重要！！
            
            NSDictionary *item =[testArray objectAtIndex:i];
            NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
            [mutableItem setObject:aid forKey:@"avatar"];
            [testArray setObject:mutableItem atIndexedSubscript:i];
            
            break;
        }
    }

    [[NSUserDefaults standardUserDefaults] setObject:testArray
                                              forKey:@"accountArray"];
    
    [[NSUserDefaults standardUserDefaults] setObject:aid forKey:@"avatar"];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"修改成功！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
    
}

-(void)backClick:(UIButton*)sender
{

    personal *p=(personal*)self.superview;
    [p updateAvatar];
    [self fadeOutView:self duration:.5];
    
}


@end
