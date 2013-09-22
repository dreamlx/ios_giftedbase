//
//  v_unit.h
//  tcxly
//
//  Created by Terry on 13-5-5.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"


@protocol loadMapDelegate;

@interface v_unit : iPageView

{
    UIView *mapv;
    UIScrollView *uv;
    
    UIImageView *curu, *vhand;
    
    NSMutableArray *larr;
    
    UIView *svv;
    
    float scalePos;
    
    NSArray *allArray, *gbArr;
    
    int curvtag;
    
    int pointnum;
    
    UIButton *gy;
    
    UIButton *backButton, *userBtn;
    
    NSArray *stages;
    int cirID;
}

-(void)loadInfo:(NSArray*)arr idx:(int)cmd;

@property (nonatomic,strong) id<loadMapDelegate> delegate;


@end


//-----
@protocol loadMapDelegate <NSObject>

@optional
    -(void)onLoadMapFinish;
@end