//
//  uploadPhoto.h
//  sq
//
//  Created by Li yi on 13-7-20.
//
//

#import "iPageView.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"

@interface uploadPhoto : iPageView<MBProgressHUDDelegate>
{

    UIImageView *av;
    
    UITextField *UserName;
    ASIFormDataRequest *regRequest;
    
     MBProgressHUD *HUD;
    id an;
    UIImageView *avatar;
}

-(void)updateAvatar;

@end
