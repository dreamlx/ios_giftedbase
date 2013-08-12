//
//  uploadPhoto.h
//  sq
//
//  Created by Li yi on 13-7-20.
//
//

#import "iPageView.h"

@interface uploadPhoto : iPageView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIPopoverController *popoverController;
    UIImageView *av;
}
@property (nonatomic,strong) UIPopoverController *popoverController;
@end
