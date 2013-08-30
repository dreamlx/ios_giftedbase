//
//  selectAvatar.m
//  tcxly
//
//  Created by Li yi on 13-8-31.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "selectAvatar.h"
#import "uploadPhoto.h"
@implementation selectAvatar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
          [self addBackground:@"et_bg.png"];
        
        
    }
    return self;
}

-(void)loadCurrentPage:(int)cmd
{
    
    [self addImageView:self
                 image:@"avatar_t.png"
              position:CGPointMake(456, 37)];
    
    
    NSMutableArray *pos=[NSMutableArray array];
    
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(123, 129)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(319, 129)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(516, 129)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(712, 129)]];
    
    
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(123, 323)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(319, 323)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(516, 323)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(712, 323)]];
    
    
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(123, 518)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(319, 518)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(516, 518)]];
    [pos addObject:[NSValue valueWithCGPoint:CGPointMake(712, 518)]];
    
    for (int i=0; i<[pos count]; i++) {
        CGPoint p=[[pos objectAtIndex:i] CGPointValue];
        
      UIButton *bt=  [self addButtonWithImageView:self
                               image:[NSString stringWithFormat:@"avatar_%d.jpg",i]
                           highlight:nil
                            position:p
                                   t:1000+i
                              action:@selector(onTap:)];
 
    }
    
    
    [self bringSubviewToFront:[self viewWithTag:1000+cmd]];
    [self viewWithTag:1000+cmd].transform=CGAffineTransformMakeScale(1.2, 1.2);
      
    
    
    [self addButton:self
              image:@"qq_back.png"
           position:CGPointMake(30, 30)
                tag:8888
             target:self
             action:@selector(backClick:)
     ];
}

-(void)backClick:(UIButton*)sender
{
    uploadPhoto *p=(uploadPhoto*)self.superview;
    [p updateAvatar];
    
    
    [self fadeOutView:self duration:.5];
    
    
}


-(void)onTap:(UIGestureRecognizer*)sender
{
    
    for (int i=0; i<12; i++) {
        [self viewWithTag:1000+i].transform=CGAffineTransformMakeScale(1, 1);
    }
    
    
    [UIView animateWithDuration:.5
                     animations:^{
                         UIView *bt=[self viewWithTag:sender.view.tag];
                         
                         [self bringSubviewToFront:bt];
                         bt.transform=CGAffineTransformMakeScale(1.2, 1.2);
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",sender.view.tag-1000]
                                                                   forKey:@"avatar"];
                         
                     }];
    
    
}

@end
