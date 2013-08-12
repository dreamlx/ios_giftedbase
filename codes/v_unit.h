//
//  v_unit.h
//  tcxly
//
//  Created by Terry on 13-5-5.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"

@interface v_unit : iPageView

{
    UIView *mapv;
    UIScrollView *uv;
    
    UIImageView *curu;
    
    NSMutableArray *larr;
    
    UIView *svv;
    
    float scalePos;
    
    NSArray *allArray;
    
    int curvtag;
    
    int pointnum;
}

-(void)loadInfo:(NSArray*)arr idx:(int)cmd;

@end
