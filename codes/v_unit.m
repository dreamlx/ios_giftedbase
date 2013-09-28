//
//  v_unit.m
//  tcxly
//
//  Created by Terry on 13-5-5.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_unit.h"
#import "v_qna.h"
#import "v_shop.h"
#import "UIView+iTextManager.h"
#import "UIImageView+WebCache.h"
#import "v_enter.h"
#import "profile.h"
#import "personal.h"

@implementation v_unit

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=[UIColor blackColor];
        
        pointnum = 8;
        //
        mapv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2048, 1536)];
        mapv.center = CGPointMake(512, 384);
        mapv.transform = CGAffineTransformMakeScale(.5, .5);
        [self addSubview:mapv];
        
//        [self addImageView:mapv
//                     image:@"ut_bg.jpg"
//                  position:CGPointMake(0, 0)
//         ];
        
        svv = [[UIView alloc]initWithFrame:CGRectMake(0, -130, 1024, 134)];
        [self addSubview:svv];
        
        [self addImageView:svv
                     image:@"ut_black.png"
                  position:CGPointMake(0, 0)];
        
        uv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 134)];
        [uv setBounces:YES];
        [svv addSubview:uv];
        
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(pinchPiece:)];
        [self addGestureRecognizer:pinchGesture];
        
        
        userBtn = [self addButton:self
                                  image:@"userSenterMenu.png"
                               position:CGPointMake(30, 30)
                                    tag:1006
                                 target:self
                                 action:@selector(centerClick:)
                         ];
        
        backButton= [self addButton:self
                              image:@"qq_back.png"
                           position:CGPointMake(906, 30)
                                tag:1004
                             target:self
                             action:@selector(backClick:)
                     ];
        
        
        vhand = [self addImageView:self image:@"ut_hand.png" position:CGPointMake(900, 660)];
        vhand.alpha = 0;
        
    }
    return self;
}

-(void)centerClick:(UIButton*)e {

    NSLog(@"用户中心");
    
    
    personal *p=[[personal alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [p loadCurrentPage:0];
    [self fadeInView:p duration:.5];

}

-(void)backClick:(UIButton*)e {
    
//
//    v_enter *vp = [[v_enter alloc] initWithFrame:self.frame];
//    [self.superview fadeInView:self
//         withNewView:vp duration:.5];
//    [vp  loadCurrentPage:0];
    
     [self.superview fadeOutView:self duration:.5];
    
}


-(void)gyClick:(UIButton*)e {
    v_shop *vp = [[v_shop alloc] initWithFrame:self.frame];
    [self fadeInView:vp duration:.5];
    [vp loadCurrentPage:0];
    [vp loadInfo:stages vid:cirID];
}

//放大缩小
- (void)pinchPiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan ) {
		scalePos=gestureRecognizer.scale;
    }
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded)
	{
		//NSLog(@"%f,%f",scalePos,gestureRecognizer.scale);
		
		if(scalePos>gestureRecognizer.scale)
        {
            [self clearPoint:-1];
            [UIView animateWithDuration:.5
                             animations:^{
                                 mapv.transform = CGAffineTransformMakeScale(.5, .5);
                                 mapv.center = CGPointMake(512, 384);
                             }];
            [UIView animateWithDuration:.5 animations:^{
                svv.frame = CGRectMake(0, -130, 1024, 134);
                svv.alpha = 0;
                backButton.alpha = 1;
                userBtn.alpha = 1;
                gy.alpha = 0;
                vhand.alpha = 0;
            
            }];

        }
	}
}

-(void)setcurunit:(int)i {
    curvtag = i;
    UIImageView *ut = (UIImageView*)[self viewWithTag:1000 + i];
    UIImageView *board = (UIImageView*)[self viewWithTag:8787];
    board.center = ut.center;
    board.alpha = 1;
}

-(void)utClick:(UIGestureRecognizer*)e {
    [self setcurunit:e.view.tag - 1000];
}

-(void)lrClick:(UIButton*)e {
    
}

-(void)boardClick:(UIGestureRecognizer*)e {
    v_qna *vq = [[v_qna alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    
    NSArray *unArr = [stages[cirID] objectForKey:@"units"];
    int unitid = [[unArr[curvtag] objectForKey:@"id"] integerValue];
    NSLog(@"unitid = %d", unitid);
    [vq loadCurrentPage:unitid];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", unitid] forKey:@"unitid"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", curvtag] forKey:@"menutag"];
    [self.superview fadeInView:self
                   withNewView:vq
                      duration:.5
     ];
    
}

-(void)loadInfo:(NSArray*)arr idx:(int)cmd {
    stages = [arr[cmd] objectForKey:@"stages"];
    
    NSLog(@"stages count = %d", [stages count]);
    NSLog(@"stages ->>%@", stages);
    
    int mapcount = [[arr[cmd] objectForKey:@"pictures"] count];
    NSLog(@"map count == %d", mapcount);
    NSString *imgurl = @"";
    if(mapcount > 0) {
        imgurl = [[arr[cmd] objectForKey:@"pictures"][mapcount - 1] objectForKey:@"image_url"];
    }
    if(imgurl) {
        NSLog(@"%@", imgurl);
        
        //NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imgurl]];
        //UIImage *image=[[UIImage alloc] initWithData:imageData];
        
        UIImageView *imgview = [self addImageView:mapv
                                            image:@"ut_wait.png"
                                         position:CGPointMake(0, 0)];
        
        
        imgview.alpha=0;
        
    
        [imgview setImageWithURL:[NSURL URLWithString:imgurl]
                placeholderImage:nil
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                           
                           [UIView animateWithDuration:.5
                                            animations:^{
                                                imgview.alpha=1;
                                                
                                                //[delegate onLoadMapFinish];
                                            
                                                
                                            }];
                       }];
    }
    
    
    gy = [self addButton:mapv
                   image:@"ut_gaiyao.png"
                position:CGPointMake(0, 0)
                     tag:78978
                  target:self
                  action:@selector(gyClick:)
          ];
    gy.alpha = 0;

    for (int i = 0; i < [stages count]; i++) {
        NSArray *pos=[stages[i] objectForKey:@"map_places"];
        CGPoint p =CGPointMake([[pos[0] objectForKey:@"x"] integerValue],[[pos[0] objectForKey:@"y"] integerValue]);
        
        NSString *state = [stages[i] objectForKey:@"purchase_state"];
        //测试
//        if(i > 2) state = @"unpaid";
        NSLog(@"state == > %@", state);
        //
        UIButton *cir = [self addButton:mapv
                                  image:[NSString stringWithFormat:@"ut_cir%d.png", i]
                               position:CGPointMake(p.x * 2, p.y * 2)
                                    tag:2000 + i
                                 target:self
                                 action:@selector(cirClick:)
                         ];
        if([state isEqualToString:@"paid"]) {
            NSString *cirname = [NSString stringWithFormat:@"%d", [[stages[i] objectForKey:@"position"] isKindOfClass:[NSNull class]] ? 0 : [[stages[i] objectForKey:@"position"] integerValue]];
            UILabel *txt = [self addLabel:cir
                                    frame:CGRectMake(0, 0, cir.frame.size.width, cir.frame.size.height)
                                     font:[UIFont fontWithName:@"Gretoon" size:32]
                                     text:cirname
                                    color:[UIColor blackColor]
                                      tag:2100 + i
                            ];
            txt.alpha = .5;
            txt.textAlignment = UITextAlignmentCenter;
            
        }else {
            [self addImageView:cir
                         image:@"ut_rock.png"
                      position:CGPointMake(0, 0)
             ];
        }
        cir.alpha = 0;
        cir.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        [UIView animateWithDuration:.5
                              delay:i * .2
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             cir.alpha = 1;
                             cir.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             if([state isEqualToString:@"paid"]) [self showCir:cir];
                         }];
    }
    
}

-(void)cirClick:(UIButton*)e {
    
    for(UIView *sview in uv.subviews) {
        [sview removeFromSuperview];
    }
    
    svv.frame = CGRectMake(0, -130, 1024, 134);
    svv.alpha = 0;
    
    backButton.alpha=0;
    userBtn.alpha = 0;
    
    CGPoint pp;
    int px = self.frame.size.width * 1.5 - e.center.x;
    int py = self.frame.size.height * 1.5 - e.center.y;
    pp.x = px > 1024 ? 1024 : px < 0 ? 0 : px;
    pp.y = py > 768 ? 768 : py < 0 ? 0 : py;
    
    NSLog(@"%f---%f", pp.x, pp.y);
    gy.alpha = 0;
    
    
    
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         mapv.transform = CGAffineTransformMakeScale(1, 1);
                         mapv.center = pp;
                         vhand.alpha = 1;
                     } completion:^(BOOL finished) {
                         [self addPointAni:e.tag - 2001];
                         gy.center = CGPointMake(e.center.x, e.center.y + 120);
                         [UIView animateWithDuration:.5
                                          animations:^{
                                              gy.center = CGPointMake(gy.center.x, gy.center.y - 20);
                                              gy.alpha = 1;
                                          }
                          ];
                     }];
    
    
}

-(void)addPointAni:(int)cid {
    
    [self clearPoint:cid];
    
    int allnum = [[stages[cid + 1] objectForKey:@"units"] count];
    NSLog(@"allnum = %d", allnum);
    
    for(UIView *sview in uv.subviews) {
        [sview removeFromSuperview];
    }
    cirID = cid + 1;
    
    uv.contentSize = CGSizeMake(170 * allnum, 134);
    
    svv.alpha = 0;
    
    for (int i = 0; i < allnum; i++) {
        UIImageView *unitbtn = [self addButtonWithImageView:uv
                                                      image:@"ut_cls1.png"
                                                  highlight:nil
                                                   position:CGPointMake(7 + i * 170, 13)
                                                          t:1000 + i
                                                     action:@selector(utClick:)
                                ];
        NSArray *unArr = [stages[cid + 1] objectForKey:@"units"];
        UILabel *utname = [self addLabel:unitbtn
                                   frame:CGRectMake(0, 15, 158, 20)
                                    font:[UIFont systemFontOfSize:14]
                                    text:[NSString stringWithFormat:@"%@", [unArr[i] objectForKey:@"name"]]
                                   color:[UIColor blackColor]
                                     tag:878722
                           ];
        
        utname.textAlignment = UITextAlignmentCenter;
    }
    UIImageView *boards = [self addButtonWithImageView:uv
                                                 image:@"ut_board.png"
                                             highlight:nil
                                              position:CGPointMake(0, 0)
                                                     t:8787
                                                action:@selector(boardClick:)
                           ];
    boards.alpha = 0;
    [self setcurunit:0];
    NSString *pstr = [stages[cirID] objectForKey:@"purchase_state"];
    
    //pstr = cirID > 2 ? @"unpaid" : pstr;
    
    NSLog(@"%d", [[stages[cirID] objectForKey:@"id"] integerValue]);
    
    if([pstr isEqualToString:@"paid"]) {
        [UIView animateWithDuration:.3 animations:^{
            svv.frame = CGRectMake(0, 9, 1024, 134);
            svv.alpha = 1;
        }];
    }
    
}

-(void)clearPoint:(int)cid {
    for (int i = 0; i < 10; i++) {
        UIImageView *cc = (UIImageView*)[self viewWithTag:80000 + i];
        [cc removeFromSuperview];
    }
    
    for (int j = 0; j < pointnum; j++) {
        UIButton *cp = (UIButton*)[self viewWithTag:2000 + j];
        UIImageView *simg = (UIImageView*)[self viewWithTag:cp.tag + 777];
        
        if(cid == -1) {
            cp.alpha = 1;
            [simg.layer setHidden:NO];
        }else {
            if(j == cid + 1) {
                cp.alpha = 1;
                [simg.layer setHidden:NO];
            }else {
                cp.alpha = 1;
                [simg.layer setHidden:YES];
            }
        }
    }
}

-(void)showCir:(UIButton*)cir {
    UIImageView *simg = [self setShadowAnimtion:cir Image:@"ut_cirw2.png" time:.5];
    simg.tag = cir.tag + 777;
}

@end
