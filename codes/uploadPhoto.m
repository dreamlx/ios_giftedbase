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
        
        NSData* data = UIImageJPEGRepresentation(img, .5);
        
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:@"avatar"];
        
        /*
        member_avatar *ppp=[[member_avatar alloc] init];
    
        ppp.title=@"头像";
        [picker pushViewController:ppp animated:YES];
        [ppp loadImage:originalImage];
         */
        
        [picker dismissViewControllerAnimated:YES
                                   completion:^{
            
        }];
        
      //  [picker dismissPopoverAnimated:YES];
    }
 
        //上传用的图片数据
//        UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
//        NSData* data = UIImageJPEGRepresentation(originalImage, .5);
        
        
        /*
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@UserPhotoUpload?desc=0",ServerURL]];
        NSLog(@"%@",url);
        
        uploadRequest = nil;
        uploadRequest = [ASIFormDataRequest requestWithURL:url];
        uploadRequest.delegate=self;
        [uploadRequest setRequestMethod:@"POST"];

        //照片
        [uploadRequest setData:data
                  withFileName:@"temp.jpg"
                andContentType:@"image/jpeg"
                        forKey:@"file"];
        
        
        [uploadRequest startAsynchronous];
        */

}
/*
//请求回调

- (void)requestFinished:(ASIHTTPRequest *)r
{
    NSLog(@"用户照片上传完成");

}

- (void)requestFailed:(ASIHTTPRequest *)r
{
       
    int statusCode=[r responseStatusCode];
    
    switch (statusCode) {
        case 401:
        {
            
            [[NSUserDefaults standardUserDefaults] setObject:nil
                                                      forKey:@"Value"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
            break;
            
        default:
        {
            //网络不好跳出提示

        }
            break;
    }
    
    [r clearDelegatesAndCancel];

    r=nil;
}

 */



@end
