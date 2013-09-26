//
//  profile.h
//  tcxly
//
//  Created by Li yi on 13-9-14.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"
#import "ASIFormDataRequest.h"
@interface profile : iPageView
{
    ASIFormDataRequest *request;
    UILabel *username,*sex;
    UIImageView *avatar;
    
    UITextField *year,*month,*day,*homeAddress,*homeName,*schoolAddress,*schoolName,*qq,*email;
    
    id aid;

    id an;
    
   
}

-(void)updateAvatar:(int)a;
-(void)loadP:(NSDictionary*)p;
@end
