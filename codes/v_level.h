//
//  v_level.h
//  tcxly
//
//  Created by Terry on 13-5-4.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"
#import "iCarousel.h"

@interface v_level : iPageView<iCarouselDelegate,iCarouselDataSource>

{
    
    iCarousel *carousel;
    NSMutableArray *items;
    
    int num;
    
    NSArray *allArray;
}

@end
