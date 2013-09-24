//
//  v_enter.m
//  tcxly
//
//  Created by Terry on 13-5-4.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_enter.h"
#import "v_intive.h"
#import "v_unit.h"
#import "v_level.h"
#import "userReg.h"
#import "userLogin.h"
#import "registChooseSex.h"
#import "setting.h"

@implementation v_enter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];
        
        vid = 0;
        
        UIImageView *light = [self addImageView:self
                                          image:@"et_light.png"
                                       position:CGPointMake(286, 0)
                              ];
        
        CAKeyframeAnimation *rock;
        rock = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        [rock setDuration:3];
        [rock setRepeatCount:HUGE_VALF];
        [rock setFillMode:kCAFillModeForwards];
        
        NSMutableArray *values = [NSMutableArray array];
        
        [values addObject:[NSNumber numberWithFloat:1.0]];
        [values addObject:[NSNumber numberWithFloat:1.5]];
        [values addObject:[NSNumber numberWithFloat:1.0]];
        
        [rock setValues:values];
        
        [[light layer] addAnimation:rock forKey:@"transform"];
        
        //flash
        sf=[[iSequenceFrameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        sf.animationView.image=[UIImage imageNamed:@"idx_0.png"];
        [self addSubview:sf];
        sf.delegate=self;
        
        sf.time = 1.0/30.0;
        
        NSMutableArray *testArray=[NSMutableArray array];
        [testArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"idx_",@"fileName",
                              @"1",@"dir",
                              @"0",@"startFrame",
                              @"abc",@"endPlace",
                              @"png",@"type",nil]];
        
        [sf setStepArray:testArray];
        
        UIImageView *jqr = [self addImageView:self
                                        image:@"et_jqr.png"
                                     position:CGPointMake(743, 316)
                            ];
        
        [self startAnimation:jqr
                        sPos:CGPointMake(jqr.center.x + 50, jqr.center.y)
                        ePos:jqr.center
                      sAlpha:0
                      eAlpha:1
                      sScale:CGPointMake(1, 1)
                      eScale:CGPointMake(1, 1)
                    duration:.5
                       delay:2
                      option:UIViewAnimationOptionAllowAnimatedContent
         ];
        
        btnv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [self addSubview:btnv];
        
        [self showMenu];
        
        UIImageView *ball = [self addImageView:self
                                        image:@"et_ball.png"
                                     position:CGPointMake(389, 668)
                            ];
        ball.center = CGPointMake(ball.center.x - 100, ball.center.y);
        ball.transform = CGAffineTransformMakeRotation(10);
        ball.alpha = 0;
        
        UIImageView *dog = [self addImageView:self
                                        image:@"et_dog.png"
                                     position:CGPointMake(360, 668)
                            ];
        dog.alpha = 0;
        dog.center = CGPointMake(dog.center.x + 30, dog.center.y);
        
        [UIView animateWithDuration:2
                              delay:.5
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             ball.center = CGPointMake(ball.center.x + 100, ball.center.y);
                             ball.transform = CGAffineTransformMakeRotation(0);
                             ball.alpha = 1;
                         }completion:^(BOOL finished) {
                             [UIView animateWithDuration:.5
                                              animations:^{
                                                  dog.alpha = 1;
                                                  dog.center = CGPointMake(dog.center.x - 30, dog.center.y);
                                              }
                              ];
                         }
         ];
    }
    return self;
}

//fuck fuck fuck

-(void)showMenu {
    
    [self addButton:btnv
              image:@"et_1.png"
           position:CGPointMake(329, 436)//436)
                tag:1001
             target:self
             action:@selector(menuClick:)
     ];
    [self addButton:btnv
              image:@"et_2.png"
           position:CGPointMake(329, 547)
                tag:1002
             target:self
             action:@selector(menuClick:)
     ];
    
    for (int i = 1; i < 3; i++) {
        
        UIButton *btn = (UIButton*)[self viewWithTag:1000 + i];
        
        btn.alpha = 0;
        btn.transform = CGAffineTransformMakeScale(.5, .5);
        
        [UIView animateWithDuration:.5
                              delay:i * .2
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             btn.alpha = 1;
                             btn.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                         }];
    }
}

-(void)loadCurrentPage:(int)cmd {
    vid = cmd;
}

-(void)iSequenceFrameViewEndAnimation:(iSequenceFrameView *)sender {
    [sf unloadCurrentPage];
}

-(void)showLight:(UIButton*)btn {
    
    UIImageView *lgh = [self setLight:self
              View:btn
              Mask:@"et_btnw.png"
             Light:@"0_light.png" 
          duration:3
     ];
    lgh.tag = 1000 + btn.tag;
}

-(void)showList {
    vl = [[v_level alloc]initWithFrame:CGRectMake(0, 343, 1024, 328)];
    vl.tag = 11111;
    [self fadeInView:vl duration:.5];
    
    [self addButton:self
              image:@"qq_back.png"
           position:CGPointMake(30, 30)
                tag:11112
             target:self
             action:@selector(backClick:)
     ];
}

-(void)backClick:(UIButton*)e {
    [vl clearSelf];
    [[self viewWithTag:11112] removeFromSuperview];
    [self showMenu];
}

-(void)menuClick:(UIButton*)e {
    
    if(e.tag == 1001) {
        
        for(UIView *subv in btnv.subviews) {
            [subv removeFromSuperview];
        }
      

        //没有登入过得，去登入
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        NSLog(@"token====%@",token);
        
        
        token=nil;
        
        //
        if(token==nil)
        {
            registChooseSex *p=[[registChooseSex alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
            [self fadeInView:p duration:.5];
            [p loadCurrentPage:0];
        }
        else
        {
            [self showList]; 
        }
        

        return;

        if(vid != 1) {
            registChooseSex *ur = [[registChooseSex alloc]initWithFrame:self.frame];
            [self fadeInView:ur duration:.5];
            [ur loadCurrentPage:0];
        }
         
       // [self showList];
        
    }else if(e.tag == 1002){
        
        
        
        NSLog(@"setting");
        
        for(UIView *subv in btnv.subviews) {
            [subv removeFromSuperview];
        }

        
        
        setting *ur = [[setting alloc]initWithFrame:self.frame];
        [self fadeInView:ur duration:.5];
        [ur loadCurrentPage:0];
        
        
        
        
    }else {
//        [sf unloadCurrentPage];
//        v_intive *vi = [[v_intive alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
//        [self.superview fadeInView:self
//                       withNewView:vi
//                          duration:.5
//         ];
//        [vi loadCurrentPage:0];
    }
}
@end
