//
//  v_shop.m
//  tcxly
//
//  Created by Terry on 13-8-16.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_shop.h"
#import "v_pay.h"

@implementation v_shop

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"sp_bg.jpg"];
        
        [self addButton:self
                  image:@"sp_buy.png"
               position:CGPointMake(856, 63)
                    tag:5000
                 target:self
                 action:@selector(buyClick:)
         ];
        
        [self addImageView:self
                     image:@"sp_borad.png"
                  position:CGPointMake(354, 418)
         ];
        
        [self addButton:self
                  image:@"sp_play.png"
               position:CGPointMake(473, 555)
                    tag:4500
                 target:self
                 action:@selector(playMovie:)
         ];
        
        [self addImageView:self
                     image:@"sp_text.png"
                  position:CGPointMake(77, 66)
         ];
    }
    return self;
}

-(void)loadCurrentPage:(int)cmd {
    
}

-(void)buyClick:(UIButton*)e {
    v_pay *vp = [[v_pay alloc] initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:vp duration:.5];
    [vp loadCurrentPage:0];
}

-(void)playMovie:(UIButton*)e {
    
}

@end
