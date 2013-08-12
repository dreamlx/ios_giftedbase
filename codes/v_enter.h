//
//  v_enter.h
//  tcxly
//
//  Created by Terry on 13-5-4.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"
#import "iSequenceFrameView.h"

@interface v_enter : iPageView<iSequenceFrameViewDelegate>

{
    iSequenceFrameView *sf;
    int vid;
    
    UIView *btnv;
}

-(void)showMenu;
-(void)showList;

@end
