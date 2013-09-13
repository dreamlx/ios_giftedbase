//
//  profile.m
//  tcxly
//
//  Created by Li yi on 13-9-12.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "profile.h"
#import "v_paiming.h"
@implementation profile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        [self addImageView:self
                     image:@"avatar_12.jpg"
                  position:CGPointMake(196, 116)];

        [self addImageView:self
                     image:@"profile_0.jpg"
                  position:CGPointMake(196, 323)];
        
        
        
        [self addButton:self
                  image:@"qq_back.png"
               position:CGPointMake(30, 30)
                    tag:1003
                 target:self
                 action:@selector(backClick:)
         ];
        
        
        
        NSMutableArray *pos=[NSMutableArray array];
        
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(510, 116)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(510, 233)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(510, 349)]];
        [pos addObject:[NSValue valueWithCGPoint:CGPointMake(510, 466)]];
        
        
        
        for (int i=0; i<[pos count]; i++) {
            CGPoint p=[[pos objectAtIndex:i] CGPointValue];
            
            [self addButton:self
                      image:[NSString stringWithFormat:@"profile_bt%d.png",i]
                   position:p
                        tag:1000+i
                     target:self
                     action:@selector(onDown:)];
          
        }
        
    }
    return self;
}


-(void)onDown:(UIButton*)sender
{
    
    switch (sender.tag) {
        case 1000:
        {
            
        }
            break;
        case 1001:
        {
            v_paiming *p=[[v_paiming alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
            [p loadCurrentPage:0];
            [self fadeInView:p duration:.5];
        }
            break;
        case 1002:
        {
            
        }
            break;
        case 1003:
        {
            
        }
            break;
    }
    
    
}

-(void)loadCurrentPage:(int)cmd
{
    
    
    
    
}

@end