//
//  uploadPhoto.m
//  sq
//
//  Created by Li yi on 13-7-20.
//
//

#import "uploadPhoto.h"
#import "userReg.h"
#import "ASIFormDataRequest.h"
#import "MainViewController.h"





@implementation uploadPhoto

@synthesize popoverController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addBackground:@"et_bg.png"];

    }
    return self;
}

-(void)loadCurrentPage:(int)cmd
{
    
    [self addImageView:self
                 image:@"default_frame.png"
              position:CGPointMake(371, 128)];
    
    
    av= [self addImageView:self
                 image:@"default_avatar.png"
              position:CGPointMake(371+8, 128+8)];
    

    [self addButton:self
              image:@"uploadFromCamera_bt.png"
           position:CGPointMake(422, 450)
                tag:2000
             target:self
             action:@selector(onDown:)];
    
    [self addButton:self
              image:@"uploadFromAblum_bt.png"
           position:CGPointMake(422, 524)
                tag:2001
             target:self
             action:@selector(onDown:)];
    
    
    [self addButton:self
              image:@"findPsw_next.png"
           position:CGPointMake(422, 636)
                tag:2002
             target:self
             action:@selector(onDown:)];
    
}

-(void)onDown:(UIButton*)sender
{
    switch (sender.tag) {
        case 2000:
        {
            //拍照
            UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
            imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
            imagePickController.delegate=self;
            imagePickController.allowsEditing=NO;
            imagePickController.showsCameraControls=YES;
            
            [(MainViewController*)[self getManager]  presentModalViewController:imagePickController animated:YES];
            
            
            
            
            
            /*
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickController];
            self.popoverController = popover;
         
            [self.popoverController presentPopoverFromRect:CGRectMake(0, 0, 300, 0)
                                                    inView:self
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];*/
        }
            break;
            
        case 2001:
        {
            //从相册
            UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
            imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickController.delegate=self;
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickController];
            self.popoverController = popover;
            //popoverController.delegate = self;
            [self.popoverController presentPopoverFromRect:CGRectMake(0, 0, 0, 0)
                                     inView:self
                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                   animated:YES];
            
        }
            break;
            
        case 2002:
        {
            userReg *ur = [[userReg alloc]initWithFrame:self.frame];
            [self.superview fadeInView:self withNewView:ur duration:.5];
            [ur loadCurrentPage:0];
        }
            break;
    }

    
}


- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


#pragma mark –
#pragma mark 上传照片回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        float width=267/(float)originalImage.size.width;
        float height=267/(float)originalImage.size.height;
        
        float k=width>height?height:width;

        UIImage *img=[self reSizeImage:originalImage
                       toSize:CGSizeMake(originalImage.size.width*k, originalImage.size.height*k)];
        
        av.image=img;
        
        
        NSData* data = UIImageJPEGRepresentation(img, 1);
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:@"avatar"];
        
        
        [picker dismissViewControllerAnimated:YES
                                   completion:^{
            
        }];
    }
 
    
    
    
    
}

@end
