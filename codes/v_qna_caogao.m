//
//  v_qna_caogao.m
//  tcxly
//
//  Created by Li yi on 13-8-14.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_qna_caogao.h"

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
        case 0:
        {
            r=0.f;
            g=0.f;
            b=0.f;
        }
            break;
            
        default:
            break;
    }
    
}


-(void)onDown:(UIButton*)sender
{
    
    
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
        
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r,g,b, 1.0);
        
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
