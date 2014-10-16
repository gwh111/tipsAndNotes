//
//  HistoryViewController.m
//  Tips&Notes
//
//  Created by apple on 14/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "HistoryViewController.h"
#import "TipsHistoryTableViewCell.h"

@interface HistoryViewController ()

@end

NSMutableDictionary *tipsPlist_history;
NSArray *heightArray_history;

UITableView *mainHistoryTableView;
UILabel *historyLabel;

@implementation HistoryViewController

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
    self.view.backgroundColor=[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    
    historyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-50, self.view.bounds.size.width, 100)];
    historyLabel.text=@"Hi, History Box is Empty !\n\n!!^_^";
    historyLabel.numberOfLines=3;
    historyLabel.backgroundColor=[UIColor clearColor];
    historyLabel.textColor=[UIColor grayColor];
    historyLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:historyLabel];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navImageView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:navImageView];
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 20, 60, 50);
    [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    heightArray_history=[[NSArray alloc]init];
    tipsPlist_history=[[NSMutableDictionary alloc]init];
    [self readPlistFile];
    [self getTextViewHeight];
    
    mainHistoryTableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 65, self.view.bounds.size.width-10, self.view.bounds.size.height-180)];
    mainHistoryTableView.delegate=self;
    mainHistoryTableView.dataSource=self;
    mainHistoryTableView.backgroundColor=[UIColor clearColor];
    mainHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainHistoryTableView];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(delet:) name:@"DeleteHistory" object:nil];
}

- (void)readPlistFile{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"History.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    tipsPlist_history=data;
    
    if ([[tipsPlist_history objectForKey:@"text"]count]==0) {
        historyLabel.alpha=1;
    }else{
        historyLabel.alpha=0;
    }
}

- (void)getTextViewHeight{
    heightArray_history=[[NSArray alloc]init];
    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(0, 100, 300, 40)];
    text.font=[UIFont systemFontOfSize:14];
    NSUInteger num=[[tipsPlist_history objectForKey:@"text"]count];
    for (int i=0; i<num; i++) {
        text.text=[[tipsPlist_history objectForKey:@"text"]objectAtIndex:i];
        
        CGFloat fixedWidth = text.frame.size.width;
        CGSize newSize = [text sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = text.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        NSString *height=[NSString stringWithFormat:@"%f",newFrame.size.height];
        
        heightArray_history=[heightArray_history arrayByAddingObject:height];
    }
    NSLog(@"content=%@",heightArray_history);
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[tipsPlist_history objectForKey:@"text"]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[heightArray_history objectAtIndex:indexPath.section]floatValue]+65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsHistoryTableViewCell *cell = (TipsHistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TipsHistoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.contentHistoryTextView.text=[[tipsPlist_history objectForKey:@"text"]objectAtIndex:indexPath.section];
    cell.timeHistoryLabel.text=[[tipsPlist_history objectForKey:@"time"]objectAtIndex:indexPath.section];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    cell.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    cell.deletButton.tag=indexPath.section;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [mainHistoryTableView deselectRowAtIndexPath:[mainHistoryTableView indexPathForSelectedRow] animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 5)];
    return view;
}

- (void)backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)writePlistFile{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"History.plist"];
    //输入写入
    [tipsPlist_history writeToFile:filename atomically:YES];
}

- (void)deletePlistFile:(int)tag{

    [[tipsPlist_history objectForKey:@"text"]removeObjectAtIndex:tag];
    [[tipsPlist_history objectForKey:@"time"]removeObjectAtIndex:tag];
    [self writePlistFile];
    tipsPlist_history=[[NSMutableDictionary alloc]init];
    [self readPlistFile];
    [self getTextViewHeight];
    [mainHistoryTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) delet:(NSNotification*) notification{
    id obj = [notification object];//获取到传递的对象
    NSLog(@"butt=%@",obj);
    [self deletePlistFile:[obj intValue]];
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

@end
