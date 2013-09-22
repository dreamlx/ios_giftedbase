//
//  v_enter.h
//  tcxly
//
//  Created by Terry on 13-5-4.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"
#import "iSequenceFrameView.h"
#import "v_level.h"

@interface v_enter : iPageView<iSequenceFrameViewDelegate>

{
    iSequenceFrameView *sf;
    int vid;
    v_level *vl;
    UIView *btnv;
}

-(void)showMenu;
-(void)showList;

@end
