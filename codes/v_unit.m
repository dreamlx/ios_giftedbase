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
        [svv addSubview:uv];
        
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(pinchPiece:)];
        [self addGestureRecognizer:pinchGesture];
        
        
        
        
        
        backButton= [self addButton:self
                              image:@"qq_back.png"
                           position:CGPointMake(30, 30)
                                tag:1004
                             target:self
                             action:@selector(backClick:)
                     ];
        
        vhand = [self addImageView:self image:@"ut_hand.png" position:CGPointMake(900, 660)];
        vhand.alpha = 0;
        
        
    }
    return self;
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
    [vp loadInfo:gbArr];
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
    [self.superview fadeInView:self
                   withNewView:vq
                      duration:.5
     ];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", curvtag] forKey:@"menutag"];
    [vq readInfo:allArray[curvtag] questionID:0];
    [vq loadInfo:allArray menuIndex:curvtag];
    NSLog(@"+++++%d", curvtag);
    
}

-(void)loadInfo:(NSArray*)arr idx:(int)cmd {
    gbArr = [arr[cmd] objectForKey:@"stages"];
    int mapcount = [[arr[cmd] objectForKey:@"pictures"] count];
    
    NSString *imgurl = [[arr[cmd] objectForKey:@"pictures"][mapcount - 1] objectForKey:@"image_url"];
    if(imgurl) {
        NSLog(@"load map");
        
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

    
    
    
    NSArray *stages=[arr[cmd] objectForKey:@"stages"];
    
   
    
    NSArray *pos=[stages[stages.count-1] objectForKey:@"map_places"];
    
    
    NSLog(@"%@",[pos objectAtIndex:1]);
    
    
        
    
    for (int i = 0; i < [pos count]; i++) {
        
        
        
        
        CGPoint p =CGPointMake([[[pos objectAtIndex:i] objectForKey:@"x"] integerValue],[[[pos objectAtIndex:i] objectForKey:@"y"] integerValue]);
        
        UIButton *cir = [self addButton:mapv
                                  image:[NSString stringWithFormat:@"ut_cir%d.png", i]
                               position:CGPointMake(p.x * 2, p.y * 2)
                                    tag:2000 + i
                                 target:self
                                 action:@selector(cirClick:)
                         ];
        
        cir.alpha = 0;
        cir.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        [UIView animateWithDuration:.5
                              delay:i * .2
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             cir.alpha = 1;
                             cir.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             [self showCir:cir];
                         }];
    }
    
    int allnum = [[[arr[cmd] objectForKey:@"stages"][0] objectForKey:@"units"] count];
    NSLog(@"allnum = %d", allnum);
    
    if(allnum == 0) return;
    
    uv.contentSize = CGSizeMake(170 * allnum, 134);
    
    svv.alpha = 0;
    
    allArray = [NSArray array];
    allArray = [[arr[cmd] objectForKey:@"stages"][0] objectForKey:@"units"];
    
    for (int i = 0; i < allnum; i++) {
        UIImageView *unitbtn = [self addButtonWithImageView:uv
                                                      image:@"ut_cls1.png"
                                                  highlight:nil
                                                   position:CGPointMake(7 + i * 170, 13)
                                                          t:1000 + i
                                                     action:@selector(utClick:)
                                ];
        
        UILabel *utname = [self addLabel:unitbtn
                                   frame:CGRectMake(0, 15, 158, 20)
                                    font:[UIFont systemFontOfSize:14]
                                    text:[NSString stringWithFormat:@"%@", [[[arr[cmd] objectForKey:@"stages"][0] objectForKey:@"units"][i] objectForKey:@"name"]]
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
    
}

-(void)cirClick:(UIButton*)e {
    
    backButton.alpha=0;
    
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
    
    [UIView animateWithDuration:.3 animations:^{
        svv.frame = CGRectMake(0, 9, 1024, 134);
        svv.alpha = 1;
    }];
    
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
