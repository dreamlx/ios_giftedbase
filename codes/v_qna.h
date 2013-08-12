//
//  v_qna.h
//  tcxly
//
//  Created by Terry on 13-5-5.
//  Copyright (c) 2013年 Terry. All rights reserved.
//

#import "iPageView.h"

@interface v_qna : iPageView<UITextViewDelegate, UIAlertViewDelegate>

{
    UIView *vbar;
    UIImageView *arrow;
    
    UILabel *lrtxt;
    UILabel *centertxt;
    
    UIView *ansv;
    
    UILabel *qnumtxt;
    UILabel *quetxt;
    UILabel *timetxt;
    
    NSTimer *timer;
    
    int timeall;
    
    UITextView *anstxt;
    
    int questionID;
    NSArray *questionList;
    
    NSMutableArray *postAnswerArr;
    NSMutableArray *postIDArr;
    
    UIView *qupv;
    UIView *qnav;
    
    UIScrollView *uv;
    UIScrollView *sv;
    
    NSArray *question_line_items;
    
    UIView *imgv;
    
    int opnum;
    
    int timenum;
    
    int unitid;
    
    UIButton *backbtn;
}

-(void)readInfo:(NSDictionary*)qlist questionID:(int)qid;
-(void)loadInfo:(NSArray*)arr menuIndex:(int)mid;

@end
