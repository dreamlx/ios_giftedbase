//
//  v_qna.m
//  tcxly
//
//  Created by Terry on 13-5-5.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "v_qna.h"
#import "v_unit.h"
#import "v_score.h"
#import "UIView+iTextManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSObject+SBJson.h"

@implementation v_qna

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        timenum = 3;
        
        postArr = [NSMutableArray array];
        
        [self addBackground:@"qq_bg.jpg"];
        
        qnav = [[UIView alloc]initWithFrame:self.frame];
        [self addSubview:qnav];
        
        qupv = [[UIView alloc]initWithFrame:CGRectMake(0, 96, 1024, 668)];
        [self addSubview:qupv];
        qupv.alpha = 0;
        
        [self addButton:qnav
                  image:@"qq_back.png"
               position:CGPointMake(10, 36)
                    tag:8888
                 target:self
                 action:@selector(backClick:)
         ];
        
        vbar = [[UIView alloc]initWithFrame:CGRectMake(121, 31, 645, 46)];
        [qnav addSubview:vbar];
        
        [self addImageView:vbar
                     image:@"qq_bar.png"
                  position:CGPointMake(0, 15)];
        
        for (int i = 0; i < 90; i ++) {
            [self addImageView:vbar image:@"qq_100.png" position:CGPointMake(7 + i * 7, 20) tag:9000+i];
        }
        
        arrow = [self addImageView:vbar image:@"qq_arrow.png" position:CGPointMake(0, 27)];
        lrtxt = [self addLabel:vbar
                         frame:CGRectMake(0, 0, 20, 20)
                          font:[UIFont systemFontOfSize:8]
                          text:@""
                         color:[UIColor colorWithRed:28.f / 255.f green:200.f / 255.f blue:194.f / 255.f alpha:1]
                           tag:8001];
        centertxt = [self addLabel:vbar
                         frame:CGRectMake(0, 0, 20, 20)
                          font:[UIFont systemFontOfSize:8]
                          text:@""
                         color:[UIColor colorWithRed:28.f / 255.f green:200.f / 255.f blue:194.f / 255.f alpha:1]
                           tag:8002];
        [self addImageView:qnav
                     image:@"qq_time.png"
                  position:CGPointMake(781, 30)];
        timetxt = [self addLabel:qnav
                           frame:CGRectMake(800, 41, 100, 32)
                            font:[UIFont systemFontOfSize:25]
                            text:@""
                           color:[UIColor colorWithRed:81.f/255.f green:244.f/255.f blue:233.f/255.f alpha:1]
                             tag:5670
                   ];
        
        [self addTapEvent:timetxt target:self action:@selector(pauseClick:)];
        
        [self addButton:qnav
                  image:@"qq_submit.png"
               position:CGPointMake(895, 27)
                    tag:5000
                 target:self
                 action:@selector(tjClick:)
         ];
        
        //图片加载区域
        imgv = [[UIView alloc] initWithFrame:CGRectMake(500, 250, 500, 500)];
        [qnav addSubview:imgv];
        //问题 回答
        ansv = [[UIView alloc]initWithFrame:CGRectMake(19, 132, 850, 500)];
        [qnav addSubview:ansv];
        //test
//        [self addImageView:ansv
//                     image:@"qq_txt.png"
//                  position:CGPointMake(0, 0)];
        
//        [self addImageView:ansv
//                     image:@"qq_ansb.png"
//                  position:CGPointMake(0, 150)];
        
        //pan
        for (int i = 1; i < 4; i++) {
            [self addButton:qnav
                      image:[NSString stringWithFormat:@"qq_pan%d.png", i]
                   position:CGPointMake(916, 137 + (i - 1) * 100)
                        tag:4000 + i
                     target:self
                     action:@selector(panClick:)
             ];
        }
        //
        [self addButton:qnav
                  image:@"qq_upq.png"
               position:CGPointMake(917, 468)
                    tag:3001
                 target:self
                 action:@selector(queClick:)
         ];
        [self addButton:qnav
                  image:@"qq_dnq.png"
               position:CGPointMake(917, 616)
                    tag:3002
                 target:self
                 action:@selector(queClick:)
         ];
        
        [self addQupAnyThing];
        
    }
    return self;
}


//pause
-(void)pauseClick:(UIGestureRecognizer*)e {
    NSLog(@"pause timer");
    
    if(timenum <= 0) {
        return;
    }
    
    if(timer) {
        timenum --;
        [timer invalidate];
        timer = nil;
        UIView *mskmc = [[UIView alloc] initWithFrame:self.frame];
        mskmc.tag = 909090;
        mskmc.alpha = .5;
        [self addSubview:mskmc];
        mskmc.backgroundColor = [UIColor blackColor];
        [self addTapEvent:mskmc target:self action:@selector(startClick:)];
    }
}

-(void)startClick:(UIGestureRecognizer*)e {
    [[self viewWithTag:909090] removeFromSuperview];
    timer=[NSTimer scheduledTimerWithTimeInterval:1
                                           target:self
                                         selector:@selector(update)
                                         userInfo:nil
                                          repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)update
{
    timeall = timeall - 1 > 0 ? timeall - 1 : 0;
    timetxt.text = [self getTime];
}

-(NSString*)getTime {
    
    int imin = (int)(timeall / 60);
    int isec = (int)(timeall % 60);
    
    NSString *min = [NSString stringWithFormat:@"%@%d", imin < 10 ? @"0" : @"", imin];
    NSString *sec = [NSString stringWithFormat:@"%@%d", isec < 10 ? @"0" : @"", isec];
    
    NSString *addTime = [NSString stringWithFormat:@"%@:%@", min, sec];
    
    return addTime;
}

-(void)ansClick:(UIButton*)e {
    
//    UILabel *lb = (UILabel*)[self viewWithTag:e.tag + 500];
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = (UIButton*)[self viewWithTag:7000 + i];
        if(btn.tag == e.tag) {
            btn.alpha = 1;
            [postArr replaceObjectAtIndex:questionID withObject:[NSString stringWithFormat:@"%d", i + 1]];
        }else {
            btn.alpha = .3;
        }
    }
    
    [self updateQuestionState];
}

-(void)readInfo:(NSDictionary*)qlist questionID:(int)qid {
    
    questionList = [[qlist objectForKey:@"question_groups"][0] objectForKey:@"question_line_items"];
    questionID = qid;
    
    unitid = [[qlist objectForKey:@"id"] integerValue];
    
    timeall = [[qlist objectForKey:@"exam_minutes"] integerValue] * 60;
    timer=[NSTimer scheduledTimerWithTimeInterval:1
                                           target:self
                                         selector:@selector(update)
                                         userInfo:nil
                                          repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSDictionary *questions = [[NSDictionary alloc]init];
    questions = [questionList[questionID] objectForKey:@"question"];
    NSArray *oparr = [NSArray array];
    oparr = [questions objectForKey:@"single_choice_options"];
    
    NSLog(@"%@", oparr);
    
    opnum = [oparr count];
    
    for (int i = 0; i < opnum; i++) {
        UIView *ansview = [[UIView alloc]initWithFrame:CGRectMake(80, 250 + i * 80, 150, 50)];
        [qnav addSubview:ansview];
        ansview.tag = 50000 + i;
        
        UIButton *btn = [self addButton:ansview
                                  image:[NSString stringWithFormat:@"qpcc%d.png", i]
                               position:CGPointMake(0, 0)
                                    tag:7000 + i
                                 target:self
                                 action:@selector(ansClick:)
                         ];
        btn.transform = CGAffineTransformMakeScale(.5, .5);
        btn.center = CGPointMake(25, 25);
        btn.alpha = .5;
        
        [self addLabel:ansview
                 frame:CGRectMake(70, 10, 500, 32)
                  font:[UIFont systemFontOfSize:26]
                  text:[oparr[i] objectForKey:@"content"]
                 color:[UIColor blackColor]
                   tag:7500 + i
         ];
    }
    
    for (int i = 0; i < [questionList count]; i++) {
        [postArr addObject:[NSString stringWithFormat:@"100"]];
    }
    
    qnumtxt = [self addLabel:qnav
                            frame:CGRectMake(20, 135, 40, 24)
                             font:[UIFont fontWithName:@"Arial" size:22]
                             text:@""
                            color:[UIColor colorWithRed:85.f/255.f green:107.f/255.f blue:131.f/255.f alpha:1]
                              tag:12001
                    ];
    qnumtxt.shadowOffset=CGSizeMake(0, 1);
    qnumtxt.shadowColor=[UIColor whiteColor];
    qnumtxt.textAlignment = NSTextAlignmentCenter;
    
    
    quetxt = [self addLabel:qnav
                      frame:CGRectMake(84, 135, 750, 26)
                       font:[UIFont systemFontOfSize:24]
                       text:@""
                      color:[UIColor blackColor]
                        tag:12002
              ];
//    quetxt.numberOfLines = 3;
    quetxt.shadowOffset=CGSizeMake(0, 1);
    quetxt.shadowColor=[UIColor whiteColor];
    
    
    anstxt = [[UITextView alloc]initWithFrame:CGRectMake(83, -282, 782, 132)];
    anstxt.backgroundColor=[UIColor clearColor];
    anstxt.returnKeyType = UIReturnKeyDone;
    anstxt.font = [UIFont systemFontOfSize:20];
    anstxt.textColor = [UIColor blackColor];
    anstxt.tag=80000;
    anstxt.delegate = self;
    [anstxt setKeyboardType:UIKeyboardTypeNumberPad];
    [qnav addSubview:anstxt];
    
    [self setQuestion];
}

-(void)textViewDidChange:(UITextView *)textView {
    [postArr replaceObjectAtIndex:questionID withObject:textView.text];
}

-(void)setQuestion {
    
    anstxt.text = [postArr objectAtIndex:questionID];
    NSDictionary *questions = [[NSDictionary alloc]init];
    questions = [questionList[questionID] objectForKey:@"question"];
    qnumtxt.text = [NSString stringWithFormat:@"%d :", questionID + 1];
    quetxt.text = [NSString stringWithFormat:@"%@", [questions objectForKey:@"subject"]];
    
    for (int i = 0; i < opnum; i++) {
        UIButton *btn = (UIButton*)[self viewWithTag:7000 + i];
        UILabel *ub = (UILabel*)[self viewWithTag:7500 + i];
        ub.text = [NSString stringWithFormat:@"%@", [[questions objectForKey:@"single_choice_options"][i] objectForKey:@"content"]];
//        if([ub.text isEqualToString:postArr[questionID]]) {
        if(i == [postArr[questionID] integerValue] - 1) {
            btn.alpha = 1;
        }else {
            btn.alpha = .3;
        }
    }
    
    for (int i = 0; i < 90; i ++) {
        UIImageView *bar = (UIImageView*)[self viewWithTag:9000 + i];
        if((int)(questionID * 90 / [questionList count]) + 1 >= i) {
            bar.alpha = 1;
        }else {
            bar.alpha = 0;
        }
    }
    arrow.frame = CGRectMake((int)(questionID * 622 / [questionList count]) + 5, arrow.frame.origin.y, arrow.frame.size.width, arrow.frame.size.height);
    
    for(UIView *sview in imgv.subviews) {
        [sview removeFromSuperview];
        NSLog(@"clear image");
    }
    
    NSString *imgurl = [questions objectForKey:@"thumb_image_url"];
    if(imgurl) {
        NSLog(@"load image");
        NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imgurl]];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
        UIImageView *imgview = [[UIImageView alloc]initWithImage:image];
        [imgv addSubview:imgview];
    }
}

-(void)backClick:(UIButton*)e {
    [UIView animateWithDuration:.5
                     animations:^{
                         qupv.alpha = 1;
                     }
     ];
}

-(void)queClick:(UIButton*)e {
    if(e.tag == 3001) {
        questionID = questionID - 1 < 0 ? 0 : questionID - 1;
    }else {
        questionID = questionID + 1 >= [questionList count] - 1 ? [questionList count] - 1 : questionID + 1;
    }
    [self setQuestion];
}

-(void)panClick:(UIButton*)e {
    
}

//
// 提交数据
//
-(void)tjClick:(UIButton*)e {
    
//    NSLog(@"%@", postArr);
    
    if(timer) {
        [timer invalidate];
        timer = nil;
    }
    
    NSMutableArray *postDic = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [postArr count]; i++) {
        
        int queid = [postArr[i] integerValue] - 1;
        NSLog(@"queid = %d", queid);
        
        NSArray *opdic = [[questionList[i] objectForKey:@"question"] objectForKey:@"single_choice_options"];
        if(queid != 99) {
            [postDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:[questionList[i] objectForKey:@"id"], @"question_line_item_id", [opdic[queid] objectForKey:@"id"], @"option_id", nil]];
        }
    }
    NSMutableDictionary *exams = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:unitid], @"unit_id", @"2013-07-13T00:12:30+08:00", @"started_at", @"2013-07-13T00:12:40+08:00", @"stopped_at", postDic, @"answers_attributes", nil];
    
    NSMutableDictionary *finalDic = [NSMutableDictionary dictionaryWithObject:exams forKey:@"exam"];
    
    NSString *newjson = [finalDic JSONRepresentation];
    
    NSLog(@"%@", newjson);
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://gifted-center.com/api/exams.json?auth_token=L1M1NXGpFayafaQasky7"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url2];
    request.tag = 60002;
    
//    [request setPostValue:[NSNumber numberWithInt:unitid] forKey:@"exam[unit_id]"];
//    [request setPostValue:@"2013-07-12T21:49:43+08:00" forKey:@"exam[started_at]"];
//    [request setPostValue:@"2013-07-12T21:49:43+08:00" forKey:@"exam[stopped_at]"];
    
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[newjson dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
}

#pragma mark –
#pragma mark 请求完成 requestFinished

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    NSLog(@"failed");
    NSError *error = [request error];
    NSLog(@"login:%@",error);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"网络无法连接"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
}

- (void)requestFinished:(ASIHTTPRequest *)req
{
    
//    NSData *jsonData = [req responseData];
    NSLog(@"successed");
    NSLog(@"%@", [req responseString]);
    
    NSData *jsonData = [req responseData];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
    
    v_score *vs = [[v_score alloc]initWithFrame:self.frame];
    [self.superview fadeInView:self withNewView:vs duration:.5];
    [vs loadCurrentPage:[[deserializedDictionary objectForKey:@"id"] integerValue]];
}

//------qup anything

-(void)addQupAnyThing {
    
    UIImageView *bgd = [self addImageView:qupv
                 image:@"qp_wh.png"
              position:CGPointMake(0, 0)];
    bgd.frame = CGRectMake(0, 0, 1024, 672);
    
    sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 672)];
    [qupv addSubview:sv];
}

-(void)setcurunit:(int)i {
    UIImageView *ut = (UIImageView*)[self viewWithTag:1000 + i];
    UIImageView *board = (UIImageView*)[self viewWithTag:8787];
    board.center = ut.center;
    board.alpha = 1;
}

-(void)utClick:(UIGestureRecognizer*)e {
    [self setcurunit:e.view.tag - 1000];
}

-(void)loadInfo:(NSArray *)arr menuIndex:(int)mid {
    
    NSArray *question_groups = [[NSArray alloc]init];
    question_groups = [arr[mid] objectForKey:@"question_groups"];
    
    NSLog(@"%@", question_groups);
    
    question_line_items = [[NSArray alloc]init];
    question_line_items = [question_groups[0] objectForKey:@"question_line_items"];
    
    NSLog(@"question number = %d", [question_line_items count]);
    
    NSLog(@"%@", question_groups);
    
    //        return;
    
    for (int i = 0; i < [question_line_items count]; i ++) {
        
        UIView *txt = [[UIView alloc]initWithFrame:CGRectMake(0, 16 + i * 62, 1042, 42)];
        txt.tag = 2000 + i;
        [sv addSubview:txt];
        [self addTapEvent:txt target:self action:@selector(txtClick:)];
        
        [self addImageView:txt
                     image:@"qp_line.png"
                  position:CGPointMake(0, 40)
         ];
        
        UILabel *tum = [self addLabel:txt
                                frame:CGRectMake(15, 0, 40, 24)
                                 font:[UIFont fontWithName:@"Arial" size:22]
                                 text:[NSString stringWithFormat:@"%d :", i + 1]
                                color:[UIColor colorWithRed:85.f/255.f green:107.f/255.f blue:131.f/255.f alpha:1]
                                  tag:2998
                        ];
        tum.shadowOffset=CGSizeMake(0, 1);
        tum.shadowColor=[UIColor whiteColor];
        tum.textAlignment = NSTextAlignmentCenter;
        
        NSDictionary *questions = [[NSDictionary alloc]init];
        questions = [question_line_items[i] objectForKey:@"question"];
        
        UILabel *ques = [self addLabel:txt
                                 frame:CGRectMake(70, 5, 500, 16)
                                  font:[UIFont fontWithName:@"Calibri" size:10]
                                  text:[questions objectForKey:@"subject"]
                                 color:[UIColor redColor]
                                   tag:2999
                         ];
        ques.alpha = .5;
        ques.shadowOffset=CGSizeMake(0, 1);
        ques.shadowColor=[UIColor whiteColor];
        
        [sv setContentSize:CGSizeMake(1024, (i + 1) * 62)];
    }
}

//设置是否已经答题

-(void)updateQuestionState {
    UIView *hasAnswerTxt = [self viewWithTag:2000 + questionID];
    UILabel *curlabel = (UILabel*)[hasAnswerTxt viewWithTag:2999];
    curlabel.textColor = [UIColor blackColor];
    curlabel.alpha = 1;
}

-(void)txtClick:(UIGestureRecognizer*)e {
    [UIView animateWithDuration:.5
                     animations:^{
                         qupv.alpha = 0;
                     }
     ];
    questionID = e.view.tag - 2000;
    [self setQuestion];
}


@end
