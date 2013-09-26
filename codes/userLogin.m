//
//  userLogin.m
//  sq
//
//  Created by Li yi on 13-7-20.
//
//

#import "userLogin.h"
#import "ASIFormDataRequest.h"
#import "v_enter.h"
#import "registChooseSex.h"
#import "v_enter.h"
@implementation userLogin

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
    
    
    UIImageView *im = [self addImageView:self
                                   image:@"login_frame.png"
                                position:CGPointMake(189, 82)];
    
    im.userInteractionEnabled=YES;
    
    UserName=[self addTextField:im
                          frame:CGRectMake(214, 122, 357, 35)
                           font:[UIFont systemFontOfSize:15]
                          color:[UIColor blackColor]
                    placeholder:nil
                            tag:1000];
    
    
    
    UserName.placeholder=@"电子邮件";
    
    
    Password=[self addTextField:im
                          frame:CGRectMake(214, 185, 357, 35)
                           font:[UIFont systemFontOfSize:15]
                          color:[UIColor blackColor]
                    placeholder:nil
                            tag:1001];
    
    
    Password.placeholder=@"6-10位";
    Password.secureTextEntry = YES;
    
    
    [self addButton:im
              image:@"login_bt.png"
           position:CGPointMake(464, 247)
                tag:2000
             target:self
             action:@selector(onLoginDown:)];
    
    
    [self addButton:im
              image:@"reg_bt.png"
           position:CGPointMake(300, 247)
                tag:2001
             target:self
             action:@selector(onRegDown:)];
  
    
    
    [self addButton:self
              image:@"qq_back.png"
           position:CGPointMake(906, 30)
                tag:1003
             target:self
             action:@selector(backClick:)
     ];

}


-(void)backClick:(id)sender
{
    [((v_enter*)self.superview) showMenu];
    [self fadeOutView:self duration:.5];
}




//请求回调 ---------------------------------------------------------------------------------------------------
- (void)requestFailed:(ASIHTTPRequest *)r
{
    NSError *error = [r error];
    NSLog(@"reg:%@",error);
    
    
    //失败
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"用户名或密码错，请重试！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];

    
    //停止查询
    [r clearDelegatesAndCancel];
    r=nil;
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    // Use when fetching binary data
    NSData *jsonData = [request responseData];
    
    NSLog(@"%@",responseString);
    
    //解析JSon
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    
    BOOL success = [[jsonObject objectForKey:@"success"] boolValue];
    


    if (success){
       
        [[NSUserDefaults standardUserDefaults] setObject:[jsonObject objectForKey:@"auth_token"]
                                                        forKey:@"token"];
       
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登入成功。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];

    }
    else
    {
        //失败
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"用户名或密码错，请重试！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
    
    request=nil;
     
}

-(void)onRegDown:(id*)sender
{
    [Password endEditing:YES];
    [UserName endEditing:YES];
    
    registChooseSex *ur = [[registChooseSex alloc]initWithFrame:self.frame];
    
    [ur loadCurrentPage:0];
    
    [self.superview fadeInView:self
                   withNewView:ur
                      duration:.5];
      
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //成功
    v_enter *ve = (v_enter*)(self.superview);
    [ve showList];
    [self fadeOutView:self duration:.5];
}


//footer -----------------------------------
-(void)onLoginDown:(id*)sender
{
    NSLog(@"登入");
    
    
    //开始提交
    NSString *msg=@"ok";
    
    
    /*
    if(UserName.text.length==0)
    {
        msg=@"请输入用户名";
    }
    
    else if(Password.text.length==0)
    {
        msg=@"请输入密码";
    }  
  
    
    
    
    NSString *usernname=[NSString stringWithFormat:@"%@@%@",[self uniqueString],@"gifted.com"];
    
    
    
    
    if ([msg isEqualToString:@"ok"]) {
        
        NSString *ss=[NSString stringWithFormat:@"http://gifted-center.com/users/sign_in.json?user[username]=test99&user[login]=%@&user[password]=%@",usernname,@"11111111"];
        
        NSURL *url = [NSURL URLWithString:[ss stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
        NSLog(@"通过验证，可提交 url=%@",url);
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        
        [request setDelegate:self];
        
        [request startAsynchronous];
    }
    else
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
      */
}


@end
