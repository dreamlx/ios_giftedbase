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
        
        [self addButtonWithImageView:self
                               image:@"reg_man.png"
                           highlight:nil
                            position:CGPointMake(188, 166)
                                   t:1001
                              action:@selector(menuClick:)
         ];
        
        [self addButtonWithImageView:self
                               image:@"reg_woman.png"
                           highlight:nil
                            position:CGPointMake(544, 166)
                                   t:1002
                              action:@selector(menuClick:)];
        
        lg = [self addImageView:self
                     image:@"reg_light.png"
                  position:CGPointMake(-500, -500)
              ];
        lg.center = [self viewWithTag:1001].center;
        
        CAKeyframeAnimation *rock;
        rock = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        [rock setDuration:1];
        [rock setRepeatCount:HUGE_VALF];
        [rock setFillMode:kCAFillModeForwards];
        
        NSMutableArray *values = [NSMutableArray array];
        
        [values addObject:[NSNumber numberWithFloat:1]];
        [values addObject:[NSNumber numberWithFloat:.5]];
        [values addObject:[NSNumber numberWithFloat:1]];
        
        [rock setValues:values];
        
        [[lg layer] addAnimation:rock forKey:@"alpha"];
        
        
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
    
    
    
    
    lg.center = e.view.center;
}

-(void)nextClick:(UIButton*)e {
    uploadPhoto *up = [[uploadPhoto alloc]initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:up duration:.5];
    [up loadCurrentPage:0];
}

@end
