//
//  profile.m
//  tcxly
//
//  Created by Li yi on 13-9-14.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "profile.h"
#import "UIView+iTextManager.h"

@implementation profile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        
        [self addImageView:self
                     image:@"profile_0_bg.jpg"
                  position:CGPointMake(56, 106)];
        
        
        
        [self addImageView:self
                     image:@"profile_0_0.png"
                  position:CGPointMake(407, 41)];
        
        
        
        
        [self addImageView:self
                     image:@"avatar_12.jpg"
                  position:CGPointMake(71, 116)];
        

        
        
        [self addButton:self
                  image:@"qq_back.png"
               position:CGPointMake(30, 30)
                    tag:1003
                 target:self
                 action:@selector(backClick:)
         ];
        
        
        
        [self addLabel:self
                 frame:CGRectMake(319, 137, 200, 60)
                  font:[UIFont boldSystemFontOfSize:25]
                  text:@"姓名："
                 color:[UIColor blackColor]
                   tag:0];
        
        
        [self addLabel:self
                 frame:CGRectMake(319, 137+80, 200, 60)
                  font:[UIFont boldSystemFontOfSize:25]
                  text:@"性别："
                 color:[UIColor blackColor]
                   tag:0];
        
        
        [self addLabel:self
                 frame:CGRectMake(319, 137+80*2, 200, 60)
                  font:[UIFont boldSystemFontOfSize:25]
                  text:@"QQ："
                 color:[UIColor blackColor]
                   tag:0];
        
        [self addLabel:self
                 frame:CGRectMake(319, 137+80*3, 200, 60)
                  font:[UIFont boldSystemFontOfSize:25]
                  text:@"邮箱地址："
                 color:[UIColor blackColor]
                   tag:0];
        
        
        [self addButton:self
                  image:@"profile_0_bt.png"
               position:CGPointMake(769, 650)
                    tag:1000
                 target:self
                 action:@selector(onDown:)];
        
        
    }
    return self;
}

-(void)onDown:(UIButton*)sender
{
    
}


-(void)backClick:(UIButton*)sender
{
    [self fadeOutView:self duration:.5];
}


@end
