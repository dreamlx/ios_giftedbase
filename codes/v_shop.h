//
//  v_shop.h
//  tcxly
//
//  Created by Terry on 13-8-16.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"
#import "ASIHTTPRequest.h"

@interface v_shop : iPageView<UIAlertViewDelegate>

{
    NSArray *varr;
    int _vid;
    ASIHTTPRequest *request;
}

-(void)loadInfo:(NSArray*)arr vid:(int)v;

@end
