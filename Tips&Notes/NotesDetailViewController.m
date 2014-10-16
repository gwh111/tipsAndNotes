//
//  NotesDetailViewController.m
//  Tips&Notes
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "NotesDetailViewController.h"

@interface NotesDetailViewController ()

@end

UITextView *notesTextView;
UIButton *bt1;
UIButton *bt2;
UIButton *bt3;
UIButton *bt4;
UIButton *bt5;
UIButton *nextButtonEdit;
NSMutableDictionary *notesPlist;
int imgDetail=1;

@implementation NotesDetailViewController
@synthesize tagStringEdit,contentString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"string=%@",tagStringEdit);
    self.view.backgroundColor=[UIColor colorWithRed:228/255.f green:228/255.f blue:228/255.f alpha:1];
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"Notes.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    imgDetail=[[[data objectForKey:@"img"]objectAtIndex:[tagStringEdit intValue]]intValue];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navImageView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:navImageView];
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 20, 60, 50);
    [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *deletButton=[UIButton buttonWithType:UIButtonTypeCustom];
    deletButton.backgroundColor=[UIColor clearColor];
    [deletButton setBackgroundImage:[UIImage imageNamed:@"trash2.png"] forState:UIControlStateNormal];
    deletButton.frame=CGRectMake(self.view.bounds.size.width-50, 20, 50, 50);
    [deletButton addTarget:self action:@selector(trashButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deletButton];
    
    notesTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width-20, self.view.bounds.size.height-180)];
    notesTextView.backgroundColor=[UIColor whiteColor];
    notesTextView.text=contentString;
    notesTextView.textColor=[UIColor blackColor];
    notesTextView.font=[UIFont systemFontOfSize:14];
    [notesTextView.layer setMasksToBounds:YES];
    [notesTextView.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:notesTextView];
    notesTextView.delegate=self;
    
    bt1=[UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame=CGRectMake(10, self.view.bounds.size.height-90, 30, 30);
    [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1_h.png"] forState:UIControlStateNormal];
    bt1.highlighted=NO;
    [bt1.layer setMasksToBounds:YES];
    [bt1.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:bt1];
    [bt1 addTarget:self action:@selector(colorButton:) forControlEvents:UIControlEventTouchUpInside];
    bt1.tag=1;
    
    bt2=[UIButton buttonWithType:UIButtonTypeCustom];
    bt2.frame=CGRectMake(50, self.view.bounds.size.height-90, 30, 30);
    [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
    bt2.highlighted=NO;
    [bt2.layer setMasksToBounds:YES];
    [bt2.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:bt2];
    [bt2 addTarget:self action:@selector(colorButton:) forControlEvents:UIControlEventTouchUpInside];
    bt2.tag=2;
    
    bt3=[UIButton buttonWithType:UIButtonTypeCustom];
    bt3.frame=CGRectMake(90, self.view.bounds.size.height-90, 30, 30);
    [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
    bt3.highlighted=NO;
    [bt3.layer setMasksToBounds:YES];
    [bt3.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:bt3];
    [bt3 addTarget:self action:@selector(colorButton:) forControlEvents:UIControlEventTouchUpInside];
    bt3.tag=3;
    
    bt4=[UIButton buttonWithType:UIButtonTypeCustom];
    bt4.frame=CGRectMake(130, self.view.bounds.size.height-90, 30, 30);
    [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
    bt4.highlighted=NO;
    [bt4.layer setMasksToBounds:YES];
    [bt4.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:bt4];
    [bt4 addTarget:self action:@selector(colorButton:) forControlEvents:UIControlEventTouchUpInside];
    bt4.tag=4;
    
    bt5=[UIButton buttonWithType:UIButtonTypeCustom];
    bt5.frame=CGRectMake(170, self.view.bounds.size.height-90, 30, 30);
    [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    bt5.highlighted=NO;
    [bt5.layer setMasksToBounds:YES];
    [bt5.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:bt5];
    [bt5 addTarget:self action:@selector(colorButton:) forControlEvents:UIControlEventTouchUpInside];
    bt5.tag=5;
    
    [self initColor];
    
    nextButtonEdit=[UIButton buttonWithType:UIButtonTypeCustom];
    nextButtonEdit.frame=CGRectMake(self.view.bounds.size.width-70, self.view.bounds.size.height-90, 60, 30);
    nextButtonEdit.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    nextButtonEdit.highlighted=NO;
    //    nextButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    //    nextButton.layer.borderWidth = 2;
    [nextButtonEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButtonEdit setTitle:@"Done" forState:UIControlStateNormal];
    [nextButtonEdit.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [nextButtonEdit.layer setMasksToBounds:YES];
    [nextButtonEdit.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self.view addSubview:nextButtonEdit];
    [nextButtonEdit addTarget:self action:@selector(colorButton:) forControlEvents:UIControlEventTouchUpInside];
    nextButtonEdit.tag=6;
}
- (void)initColor{
    if (imgDetail==1) {
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1_h.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (imgDetail==2){
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2_h.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (imgDetail==3){
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3_h.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (imgDetail==4){
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4_h.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (imgDetail==5){
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5_h.png"] forState:UIControlStateNormal];
    }
}
- (void)colorButton:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        imgDetail=1;
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1_h.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (button.tag==2){
        imgDetail=2;
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2_h.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (button.tag==3){
        imgDetail=3;
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3_h.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (button.tag==4){
        imgDetail=4;
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4_h.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5.png"] forState:UIControlStateNormal];
    }else if (button.tag==5){
        imgDetail=5;
        [bt1 setBackgroundImage:[UIImage imageNamed:@"mark1.png"] forState:UIControlStateNormal];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"mark2.png"] forState:UIControlStateNormal];
        [bt3 setBackgroundImage:[UIImage imageNamed:@"mark3.png"] forState:UIControlStateNormal];
        [bt4 setBackgroundImage:[UIImage imageNamed:@"mark4.png"] forState:UIControlStateNormal];
        [bt5 setBackgroundImage:[UIImage imageNamed:@"mark5_h.png"] forState:UIControlStateNormal];
    }else if (button.tag==6){
        if (notesTextView.text.length==0) {
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Sorry, Content Cannot Be Nil" delegate:nil cancelButtonTitle:@"Type Something" otherButtonTitles:nil, nil];
            [alt show];
        }else{
            NSLog(@"Done");
            //获取应用程序沙盒的Documents目录
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *plistPath = [paths objectAtIndex:0];
            //得到完整的文件名
            NSString *filename=[plistPath stringByAppendingPathComponent:@"Notes.plist"];
            //读出来看看
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
            
            [[data objectForKey:@"text"]removeObjectAtIndex:[tagStringEdit intValue]];
            [[data objectForKey:@"time"]removeObjectAtIndex:[tagStringEdit intValue]];
            [[data objectForKey:@"img"]removeObjectAtIndex:[tagStringEdit intValue]];
            
            [[data objectForKey:@"text"]addObject:notesTextView.text];
            
            NSDate* now = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
            NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            comps = [calendar components:unitFlags fromDate:now];
            NSInteger year=[comps year];
            NSInteger month=[comps month];
            NSInteger day=[comps day];
            NSInteger hour=[comps hour];
            NSInteger min=[comps minute];
            NSString *my=[NSString stringWithFormat:@"%ld %ld-%ld %ld:%ld",(long)year,(long)month,(long)day,(long)hour,(long)min];
            [[data objectForKey:@"time"]addObject:my];
            [[data objectForKey:@"img"]addObject:[NSString stringWithFormat:@"%d",imgDetail]];
            
            [data writeToFile:filename atomically:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)trashButtonTapped{
    
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"This Process Can Not Be Recovered, Are You Sure To Delet?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [alt show];

}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5f animations:^{
        notesTextView.frame=CGRectMake(10, 80, self.view.bounds.size.width-20, self.view.bounds.size.height-380);
        bt1.frame=CGRectMake(10, self.view.bounds.size.height-290, 30, 30);
        bt2.frame=CGRectMake(50, self.view.bounds.size.height-290, 30, 30);
        bt3.frame=CGRectMake(90, self.view.bounds.size.height-290, 30, 30);
        bt4.frame=CGRectMake(130, self.view.bounds.size.height-290, 30, 30);
        bt5.frame=CGRectMake(170, self.view.bounds.size.height-290, 30, 30);
        nextButtonEdit.frame=CGRectMake(self.view.bounds.size.width-70, self.view.bounds.size.height-290, 60, 30);
    } completion:^(BOOL finished) {

    }];
}
- (void)backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"del");
        
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *filename=[plistPath stringByAppendingPathComponent:@"Notes.plist"];
        //读出来看看
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
        
        [[data objectForKey:@"text"]removeObjectAtIndex:[tagStringEdit intValue]];
        [[data objectForKey:@"time"]removeObjectAtIndex:[tagStringEdit intValue]];
        [[data objectForKey:@"img"]removeObjectAtIndex:[tagStringEdit intValue]];
        [data writeToFile:filename atomically:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
