//
//  v_qna_caogao.m
//  tcxly
//
//  Created by Li yi on 13-8-14.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_qna_caogao.h"
#import "v_qna.h"

@implementation v_qna_caogao

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addImageView:self
                     image:@"qq_write.png"
                  position:CGPointMake(0, 0)];
        
        canvas=[[UIImageView alloc] initWithFrame:CGRectMake(14, 50, 437, 622)];
        
        
        
        //测试用时打开  canvas.backgroundColor=[UIColor grayColor];
        
        
        
        
        [self addSubview:canvas];

        
        
        //拖动----------
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(panPiece:)];
        [canvas addGestureRecognizer:panGesture];
        [panGesture setMaximumNumberOfTouches:1];
        
        
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upload:)];
        [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [swipeGesture setNumberOfTouchesRequired:2];
        [canvas addGestureRecognizer:swipeGesture];
        
        
        
        canvas.userInteractionEnabled=YES;

        
        [self addButton:self
                  image:@"qq_qna_caogao_close.png"
               position:CGPointMake(410, 20)
                    tag:1000
                 target:self
                 action:@selector(onDown:)];
        
        
        
    }
    return self;
}

-(void)loadCurrentPage:(int)cmd
{
    
    //笔触换颜色
    switch (cmd) {
        case 1:
        {
            r=67.f;
            g=216.f;
            b=241.f;
        }
            break;
        case 2: {
            r=135.f;
            g=135.f;
            b=135.f;
        }
            break;
        case 3: {
            r=255.f;
            g=0.f;
            b=0.f;
        }
        default:
            break;
    }
    
}


-(void)onDown:(UIButton*)sender
{
    
    v_qna *vq = (v_qna*)(self.superview);
    [vq clearcaogao];
    [self removeFromSuperview];
}



-(void)panPiece:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint translation;
    
    if([gestureRecognizer state]==UIGestureRecognizerStateBegan)
    {
        translation=[gestureRecognizer locationInView:gestureRecognizer.view];
        lastPoint=translation;
        
        
        NSLog(@"%f %f",translation.x,translation.y);
    }
    
    if([gestureRecognizer state]==UIGestureRecognizerStateChanged)
    {
        
        
        translation=[gestureRecognizer locationInView:gestureRecognizer.view];
        
        UIGraphicsBeginImageContext(canvas.frame.size);
        [canvas.image drawInRect:CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
        
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r/255.f,g/255.f,b/255.f, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),  lastPoint.x,  lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), translation.x,translation.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        lastPoint=translation;
        
        
        NSLog(@"%f %f",translation.x,translation.y);
        
    }
    
}

@end
