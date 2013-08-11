//
//  registChooseSex.m
//  tcxly
//
//  Created by Terry on 13-7-20.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "registChooseSex.h"
#import "uploadPhoto.h"

@implementation registChooseSex

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        [self addImageView:self
                     image:@"reg_txt.png"
                  position:CGPointMake(262, 473)
         ];
        
        UIImageView *man = [self addButtonWithImageView:self
                               image:@"reg_man.png"
                           highlight:@"reg_man_1.png"
                            position:CGPointMake(188, 166)
                                   t:1001
                              action:@selector(menuClick:)
         ];
        
        [self addButtonWithImageView:self
                               image:@"reg_woman.png"
                           highlight:@"reg_woman_1.png"
                            position:CGPointMake(544, 166)
                                   t:1002
                              action:@selector(menuClick:)
         ];
        man.highlighted = YES;
        
        lg = [self addImageView:self
                     image:@"regboard.png"
                  position:CGPointMake(-500, -500)
              ];
        lg.center = man.center;
        
        CALayer *l2 = [[CALayer alloc] init];
        [l2 setBounds:CGRectMake(0, 0, 262, 525)];
        [l2 setAnchorPoint:CGPointMake(0.5, 0.5)];
        [l2 setPosition:CGPointMake(lg.frame.origin.x - 30, lg.frame.origin.y)];
        [l2 setContents:(UIImage*)[UIImage imageNamed:@"regrot.png"].CGImage];
        [[lg layer] setMask:l2];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anim.cumulative = YES;
        anim.toValue = [NSNumber numberWithFloat:-.1*M_PI];
        anim.repeatCount = HUGE_VALF;
        
        [l2 addAnimation:anim forKey:@"animateLayer"];
        
        [self addButton:self
                  image:@"findPsw_next.png"
               position:CGPointMake(425, 568)
                    tag:1003
                 target:self
                 action:@selector(nextClick:)
         ];
    }
    return self;
}

-(void)menuClick:(UIGestureRecognizer*)e {
    lg.center = e.view.center;
    for (int i = 1001; i <= 1002; i++) {
        UIImageView *img = (UIImageView*)[self viewWithTag:i];
        
        [UIView animateWithDuration:.5
                         animations:^{
                             img.highlighted = e.view.tag == i ? YES : NO;
                         }
         ];
    }
    switch (e.view.tag) {
        case 1001:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"m"
                                                      forKey:@"sex"];
        }
            break;
            
        case 1002:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"f"
                                                      forKey:@"sex"];
        }
            break;
    }
}

-(void)nextClick:(UIButton*)e {
    uploadPhoto *up = [[uploadPhoto alloc]initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:up duration:.5];
    [up loadCurrentPage:0];
}

@end
