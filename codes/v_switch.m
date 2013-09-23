//
//  v_switch.m
//  tcxly
//
//  Created by Li yi on 13-9-22.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_switch.h"
#import "UIView+iTextManager.h"

@implementation v_switch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        
        [self addButton:self
                  image:@"qq_back.png"
               position:CGPointMake(30, 30)
                    tag:1003
                 target:self
                 action:@selector(backClick:)];
        
        
        sv=[self addScrollView:self
                      delegate:self
                         frame:CGRectMake(0, 300, 187, 250)
                       bounces:YES
                          page:NO
                         showH:NO
                         showV:NO];
        
        sv.center=CGPointMake(512, sv.center.y);
        sv.clipsToBounds=NO;
        
       // sv.backgroundColor=[UIColor redColor];
        
        
        [self addButton:sv
                  image:@"avatar_new.jpg"
               position:CGPointMake(0, 0)
                    tag:1000
                 target:self
                 action:@selector(onDown:)];
        
        
        
        id aa = [[NSUserDefaults standardUserDefaults] objectForKey:@"accountArray"];
        
        if(aa && ![aa isKindOfClass:[NSNull class]])
        {

            int count=[aa count];
            
            for (int i=0; i<count; i++) {
                
                NSDictionary *mm=[(NSArray*)aa objectAtIndex:i];
                
                int n=[[mm objectForKey:@"avatar"] integerValue];
                
                UIButton *bt= [self addButton:sv
                                        image:[NSString stringWithFormat:@"avatar_%d.jpg",n]
                                     position:CGPointMake(187*(i+1), 0)
                                          tag:1000
                                       target:self
                                       action:@selector(onDown:)];
                
                
                UILabel *tt= [self addLabel:sv
                                      frame:CGRectMake(0, 0, 187, 50)
                                       font:[UIFont boldSystemFontOfSize:18]
                                       text:@"阿地方看见拉"
                                      color:[UIColor blackColor]
                                        tag:0];
                
                tt.textAlignment=UITextAlignmentCenter;
                
                tt.center=CGPointMake(bt.center.x, 200);
                
            }
            
            
            [sv setContentSize:CGSizeMake(187*count, 250)];
            
        }
    }
    return self;
}


-(void)onDown:(UIButton*)sender
{
    
    
    
}


-(void)backClick:(UIButton*)sender
{
    [self fadeOutView:self
             duration:.5];
}

@end
