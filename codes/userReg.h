//
//  userReg.h
//  sq
//
//  Created by Li yi on 13-7-9.
//
//

#import <UIKit/UIKit.h>
#import "iPageView.h"
#import "UIView+iTextManager.h"
#import "MBProgressHUD.h"
#import "ASIFormDataRequest.h"

@interface userReg : iPageView<UIAlertViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
{
    UITextField *Password;
    UITextField *ConfirmPassword;
    UITextField *UserName;
    UIImageView *im;
    
    ASIFormDataRequest *regRequest;
    ASIFormDataRequest *photoRequest;
    
    MBProgressHUD *HUD;
}

@end
