//
//  userReg.m
//  sq
//
//  Created by Li yi on 13-7-9.
//
//

#import "userReg.h"
#import "userLogin.h"
#import "uploadPhoto.h"

@implementation userReg

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

    im = [self addImageView:self
                      image:@"reg_frame.png"
                   position:CGPointMake(123, 53)];
    
    im.userInteractionEnabled=YES;
    
    
    NSLog(@"y＝＝＝＝＝＝＝＝＝＝＝＝＝＝%f",im.center.y);
    
    //Add a UITextField
    UserName=[self addTextField:im
                          frame:CGRectMake(304, 169, 357, 35)
                           font:[UIFont systemFontOfSize:15]
                          color:[UIColor blackColor]
                    placeholder:nil
                            tag:1000];
    UserName.delegate=self;
    UserName.placeholder=@"电子邮件";
    
    Password=[self addTextField:im
                          frame:CGRectMake(304, 249, 357, 35)
                           font:[UIFont systemFontOfSize:15]
                          color:[UIColor blackColor]
                    placeholder:nil
                            tag:1001];
    
    Password.secureTextEntry = YES;
    Password.placeholder=@"6-10位";
    Password.delegate=self;
    
    ConfirmPassword=[self addTextField:im
                                 frame:CGRectMake(304, 336, 357, 35)
                                  font:[UIFont systemFontOfSize:15]
                                 color:[UIColor blackColor]
                           placeholder:nil
                                   tag:1002];
    
    ConfirmPassword.placeholder = @"请再次输入密码";
    ConfirmPassword.secureTextEntry = YES;
    ConfirmPassword.delegate=self;
    
    
    
    [self addButton:im
              image:@"reg_bt.jpg"
           position:CGPointMake(487, 422)
                tag:2000
             target:self
             action:@selector(onRegButtonDown:)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [self addButton:self
              image:@"back_step.jpg"
           position:CGPointMake(39, 653)
                tag:1003
             target:self
             action:@selector(backClick:)
     ];

    
}

-(void)backClick:(UIButton*)e {
    //回登入
    uploadPhoto *up = [[uploadPhoto alloc]initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:up duration:.5];
    [up loadCurrentPage:0];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



-(void)keyboardWasHide:(NSNotification*) nf {
    [UIView animateWithDuration:.3
                     animations:^{
                         im.center = CGPointMake(im.center.x, 320);
                     }];
}

//请求回调 ---------------------------------------------------------------------------------------------------
- (void)requestFailed:(ASIHTTPRequest *)r
{
    [HUD hide:YES];
    
    NSError *error = [r error];
    NSLog(@"reg:%@",error);

    //停止查询
    [r clearDelegatesAndCancel];
    r=nil;

}

- (void)requestFinished:(ASIHTTPRequest *)request
{

    switch (request.tag) {
            
            //注册功能回调
        case 8000:
        {
            
            // Use when fetching binary data
            NSData *jsonData = [request responseData];

            //解析JSon
            NSError *error = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            
            
            BOOL success = [[jsonObject objectForKey:@"success"] boolValue];
            
            if (success){
                
                NSString *token=[jsonObject objectForKey:@"auth_token"];
                

                
                
                [HUD hide:YES];
                
            
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"恭喜你注册成功了！"
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                
                
                
                //去掉性别纪录
                [[NSUserDefaults standardUserDefaults] setObject:nil
                                                          forKey:@"sex"];

                
                return;

                
                //注册成功并保存token
                [[NSUserDefaults standardUserDefaults] setObject:token
                                                          forKey:@"token"];

                
                
                
                //然后开始提交照片
                NSString *s=[NSString stringWithFormat:@"http://gifted-center.com/api/profiles/upload_avatar.json?auth_token=%@",token];
                NSURL *url = [NSURL URLWithString:[s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                NSLog(@"上传照片 url=%@",url);
                
                photoRequest = [ASIFormDataRequest requestWithURL:url];
                photoRequest.tag=8001;
                NSData *data=[jsonObject objectForKey:@"avatar"];
                

                
                [photoRequest setData:data
                         withFileName:@"temp.jpg"
                       andContentType:@"image/jpeg"
                               forKey:@"avatar"];
                
                
                [photoRequest setRequestMethod:@"POST"];
                [photoRequest setDelegate:self];
                [photoRequest startAsynchronous];
                
                
                
                /*2013-08-17 01:37:18.794 tcxly[4615:907] <!DOCTYPE html>
                 <html>
                 <head>
                 <title>The change you wanted was rejected (422)</title>
                 <style type="text/css">
                 body { background-color: #fff; color: #666; text-align: center; font-family: arial, sans-serif; }
                 div.dialog {
                 width: 25em;
                 padding: 0 4em;
                 margin: 4em auto 0 auto;
                 border: 1px solid #ccc;
                 border-right-color: #999;
                 border-bottom-color: #999;
                 }
                 h1 { font-size: 100%; color: #f00; line-height: 1.5em; }
                 </style>
                 </head>
                 
                 <body>
                 <!-- This file lives in public/422.html -->
                 <div class="dialog">
                 <h1>The change you wanted was rejected.</h1>
                 <p>Maybe you tried to change something you didn't have access to.</p>
                 </div>
                 </body>
                 </html>
                 */
                
                
                
                
                
            }
            else
            {
                [HUD hide:YES];
                
                //注册失败
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"注册失败，重试。"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
            }

        }
            break;

            
            //照片提交成功回调
        case 8001:
        {
            [HUD hide:YES];
            
            
            // Use when fetching text data
            NSString *responseString = [request responseString];
            
            NSLog(@"%@",responseString);
        }
            break;
    }
    
      
    request=nil;
}


//footer -----------------------------------
-(void)onRegButtonDown:(id*)sender
{
    NSLog(@"注册");

    
    [UIView animateWithDuration:.3
                     animations:^{
                         im.center = CGPointMake(im.center.x, 320);
                     }];
    
    [UserName endEditing:YES];
    [Password endEditing:YES];
    [ConfirmPassword endEditing:YES];
    
    
    //开始提交
    NSString *msg=@"ok";
    
    
    if(UserName.text.length==0)
    {
        msg=@"请输入用户名";
    }
    
    else if(Password.text.length==0)
    {
        msg=@"请输入密码";
    }
    else if([Password.text isEqualToString:ConfirmPassword.text]==NO)
    {
        msg=@"密码输入不一致";
    }
    else if(Password.text.length<6||Password.text.length>20)
    {
        msg=@"请输入6－10位密码";
    }
    
    
    if ([msg isEqualToString:@"ok"]) {
        
        HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:HUD];
        HUD.labelText = @"正在提交，请稍等...";
        
        [HUD show:YES];
        
        //开始提交
        NSString *sex=[[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
        
        
        NSString *s=[NSString stringWithFormat:@"http://gifted-center.com/users.json?user[login]=%@&user[password]=%@&user[password_confirmation]=%@&user[gender]=%@",UserName.text,Password.text,ConfirmPassword.text,sex];
        
        NSURL *url = [NSURL URLWithString:[s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"通过验证，可提交 url=%@",url);
        
        regRequest = [ASIFormDataRequest requestWithURL:url];
        regRequest.tag=8000;
        [regRequest setRequestMethod:@"POST"];
        [regRequest setDelegate:self];
        [regRequest startAsynchronous];
        
    }
    else
    {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    userLogin *ul = [[userLogin alloc]initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:ul duration:.5];
    [ul loadCurrentPage:0];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
        
    int yy = im.center.y;
    
    if(yy < 321)
    {
        [UIView animateWithDuration:.3
                         animations:^{
                             im.center = CGPointMake(im.center.x,150);
                         }];
    }
    
    return YES;
}



@end
