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
#import "registChooseSex.h"
#import "userLogin.h"
#import "selectAvatar.h"
#import "v_enter.h"


@implementation uploadPhoto



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
    
//    
//    an=  [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
//
//    
//    if(!an||[an isKindOfClass:[NSNull class]])
//    {
//        an=@"0";
//    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0"
                                              forKey:@"avatar"];

    
    
    
    avatar=[self addButtonWithImageView:self
                                  image:@"avatar_0.jpg"
                              highlight:nil
                               position:CGPointMake(413, 113)
                                      t:1100
                                 action:@selector(onSelect:)];
    
    
    
    [self addImageView:self
                 image:@"avatar_t0.png"
              position:CGPointMake(447, 61)];
    
    
    
    //输入矿
    [self addImageView:self
                 image:@"avatar_tf.jpg"
              position:CGPointMake(354, 350)];
    
    
    
    [self addButton:self
              image:@"avatar_ok.jpg"
           position:CGPointMake(663, 350)
                tag:2002
             target:self
             action:@selector(onDown:)
     ];
    
    
    
    UserName=[self addTextField:self
                          frame:CGRectMake(361, 360, 290, 40)
                           font:[UIFont systemFontOfSize:18]
                          color:[UIColor blackColor]
                    placeholder:nil
                            tag:1000];
    
    UserName.placeholder=@"输入昵称";
    
    
   // UserName.backgroundColor=[UIColor redColor];
    
    
    [self addButton:self
              image:@"back_step.jpg"
           position:CGPointMake(39, 653)
                tag:1003
             target:self
             action:@selector(backClick:)
     ];
     
    
}


-(void)onSelect:(id)s
{
     [UserName endEditing:YES];
    
    selectAvatar *p=[[selectAvatar alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [p loadCurrentPage:[an integerValue]];
    [self fadeInView:p duration:.5];
}

-(void)updateAvatar
{
    
    an=  [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
    
    
    if(!an||[an isKindOfClass:[NSNull class]])
    {
        an=@"0";
    }
    
    avatar.image=[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%@.jpg",an]];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",[request responseString]);
    
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
                
                
                
                //注册成功并保存token
                NSString *token=[jsonObject objectForKey:@"auth_token"];
                
                [[NSUserDefaults standardUserDefaults] setObject:token
                                                          forKey:@"token"];
                
                
                
                
                [HUD hide:YES];

                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"恭喜你注册成功了！"
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                

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
            
            
            
            
            request=nil;
    }
    
}



-(void)backClick:(UIButton*)e
{
    //回登入
    registChooseSex *up = [[registChooseSex alloc]initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:up duration:.5];
    [up loadCurrentPage:0];
}


//生成唯一编码
- (NSString *) uniqueString
{
    CFUUIDRef unique = CFUUIDCreate(kCFAllocatorDefault);
    NSString *result =(NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, unique));
    CFRelease(unique);
    return result;
}

-(void)onDown:(UIButton*)sender
{
    //开始提交
    NSString *msg=@"ok";
    
    
    [UserName endEditing:YES];
    
    if(UserName.text.length==0)
    {
        msg=@"请输入昵称";
    }
    else if(UserName.text.length>20)
    {
        msg=@"太长拉";
    }
    
    if ([msg isEqualToString:@"ok"]) {
        
        HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:HUD];
        HUD.labelText = @"正在提交，请稍等..."; 
        
        [HUD show:YES];
        
        
        //开始注册
        
        //性别
        NSString *sex=[[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
        
        
        //昵称
        NSString *nickname=UserName.text;
        

        
        NSString *s=[NSString stringWithFormat:@"http://gifted-center.com/users.json?user[username]=%@&user[email]=%@@gifted.com&user[password]=%@&user[password_confirmation]=%@&user[gender]=%@&user[avatarid]=%@",
                     nickname,
                     [self uniqueString],
                     @"11111111",
                     @"11111111",
                     sex,
                     [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]];
        
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

//
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //成功
    v_enter *ve = (v_enter*)(self.superview);
    [ve showList];
    [self fadeOutView:self duration:.5];
}



@end
