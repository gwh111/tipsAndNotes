//
//  TipsViewController.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "TipsViewController.h"
#import "TipsTableViewCell.h"
#import "DKCircleButton.h"
#import "NewTipsView.h"
#import "EditTipsView.h"
#import "HistoryViewController.h"
#import "GADBannerView.h"
@interface TipsViewController ()<GADBannerViewDelegate>

@end

NSMutableDictionary *tipsPlist;
NSArray *heightArray;
//newTips
UILabel *hiLabel;
id deleteObj;
GADBannerView *banner;

@implementation TipsViewController
@synthesize mainTableView;

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
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    
    hiLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-50, self.view.bounds.size.width, 100)];
    hiLabel.text=@"Hi, I'm Empty !\n\n!!^_^";
    hiLabel.numberOfLines=3;
    hiLabel.backgroundColor=[UIColor clearColor];
    hiLabel.textColor=[UIColor grayColor];
    hiLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:hiLabel];
    
    heightArray=[[NSArray alloc]init];
    tipsPlist=[[NSMutableDictionary alloc]init];
    [self readPlistFile];
    [self getTextViewHeight];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navImageView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:navImageView];
    
    UIButton *historyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    historyButton.backgroundColor=[UIColor clearColor];
    historyButton.frame=CGRectMake(self.view.bounds.size.width-50, 22, 44, 44);
    [historyButton setBackgroundImage:[UIImage imageNamed:@"more1.png"] forState:UIControlStateNormal];
    [historyButton addTarget:self action:@selector(historyButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyButton];
    
    UIButton *homeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    homeButton.frame=CGRectMake(0, 20, 50, 50);
    [self.view addSubview:homeButton];
    [homeButton addTarget:self action:@selector(homeButton) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text=@"Tips";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 65, self.view.bounds.size.width-10, self.view.bounds.size.height-180)];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    
    DKCircleButton *addButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    addButton.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height-80);
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [addButton setTitle:@"New" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton setTitleColor:[UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1] forState:UIControlStateSelected];
    [addButton setTitleColor:[UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1] forState:UIControlStateHighlighted];
    addButton.tag=0;
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(renew:) name:@"NewTips" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(edit:) name:@"EditTips" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(delet:) name:@"DeleteTips" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(complete:) name:@"CompleteTips" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(remove:) name:@"Remove" object:nil];
    
    banner = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    banner.adUnitID = @"ca-app-pub-5564518885724507/7530478472";
    banner.rootViewController = self;
    GADRequest *request;
    request.testDevices = @[ GAD_SIMULATOR_ID,@"MY_TEST_DEVICE_ID" ];
    banner.delegate=self;
    [banner loadRequest:request];
    [self.view addSubview:banner];
}

- (void)readPlistFile{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"Tips.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    tipsPlist=data;
    if ([[tipsPlist objectForKey:@"text"]count]==0) {
        hiLabel.alpha=1;
    }else{
        hiLabel.alpha=0;
    }
}
- (void)writePlistFile{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"Tips.plist"];
    //输入写入
    [tipsPlist writeToFile:filename atomically:YES];
}
- (void)deletePlistFile:(int)tag{
    for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
//        NSLog(@"info=%@",noti.userInfo);
        if ([[noti.userInfo objectForKey:[[tipsPlist objectForKey:@"notifyName"]objectAtIndex:tag]]isEqualToString:[tipsPlist objectForKey:@"notifyName"]]) {
            NSLog(@"cancel");
            [[UIApplication sharedApplication] cancelLocalNotification:noti];
        }
    }    
    [[tipsPlist objectForKey:@"text"]removeObjectAtIndex:tag];
    [[tipsPlist objectForKey:@"time"]removeObjectAtIndex:tag];
    [[tipsPlist objectForKey:@"color"]removeObjectAtIndex:tag];
    [[tipsPlist objectForKey:@"notifyName"]removeObjectAtIndex:tag];
    [self writePlistFile];
    tipsPlist=[[NSMutableDictionary alloc]init];
    [self readPlistFile];
    [self getTextViewHeight];
    [mainTableView reloadData];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[tipsPlist objectForKey:@"text"]count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50;
    }else{
        return [[heightArray objectAtIndex:indexPath.section-1]floatValue]+65;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsTableViewCell *cell = (TipsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TipsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (indexPath.section==0) {
        UIImageView *whiteImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 55)];
        whiteImageView.backgroundColor=[UIColor whiteColor];
        [cell addSubview:whiteImageView];
        [cell addSubview:banner];
    }else{
        cell.contentTextView.text=[[tipsPlist objectForKey:@"text"]objectAtIndex:indexPath.section-1];
        cell.timeLabel.text=[[tipsPlist objectForKey:@"time"]objectAtIndex:indexPath.section-1];
        cell.upButton.tag=indexPath.section-1;
        cell.backgroundColor=[self myColor:[[[tipsPlist objectForKey:@"color"]objectAtIndex:indexPath.section-1]intValue]];
        [cell.layer setMasksToBounds:YES];
        [cell.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [mainTableView deselectRowAtIndexPath:[mainTableView indexPathForSelectedRow] animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 5)];
    return view;
}

//notification
- (void) renew:(NSNotification*) notification{
    
    id obj = [notification object];//获取到传递的对象
    if ([obj isEqualToString:@"NewTips"]) {
        NSLog(@"NewTips");
        tipsPlist=[[NSMutableDictionary alloc]init];
        [self readPlistFile];
        [self getTextViewHeight];
        [mainTableView reloadData];
    }
}
- (void) edit:(NSNotification*) notification{
    id obj = [notification object];//获取到传递的对象
    NSLog(@"butt=%@",obj);
    EditTipsView *newTipsView=[[EditTipsView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height) andTag:[NSString stringWithFormat:@"%d",[obj intValue]]];
    [self.view addSubview:newTipsView];
    
    [UIView animateWithDuration:0.5f animations:^{
        newTipsView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            newTipsView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        } completion:^(BOOL finished) {
        }];
    }];
}
- (void) delet:(NSNotification*) notification{
    id obj = [notification object];//获取到传递的对象
    NSLog(@"butt=%@",obj);
    
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"This Process Can Not Be Recovered, Are You Sure To Delet?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [alt show];
    deleteObj=obj;
}
- (void) complete:(NSNotification*) notification{
    id obj = [notification object];//获取到传递的对象
    NSLog(@"butt=%@",obj);
    int tag=[obj intValue];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"History.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    [[data objectForKey:@"text"]addObject:[[tipsPlist objectForKey:@"text"]objectAtIndex:tag]];
    [[data objectForKey:@"time"]addObject:[[tipsPlist objectForKey:@"time"]objectAtIndex:tag]];
    [data writeToFile:filename atomically:YES];
    
    [self deletePlistFile:tag];
}
- (void) remove:(NSNotification*) notification{
    NSUInteger tag=[[tipsPlist objectForKey:@"notifyName"]indexOfObject:[NSString stringWithFormat:@"%@",[notification object]]];
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"History.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    [[data objectForKey:@"text"]addObject:[[tipsPlist objectForKey:@"text"]objectAtIndex:tag]];
    [[data objectForKey:@"time"]addObject:[[tipsPlist objectForKey:@"time"]objectAtIndex:tag]];
    [data writeToFile:filename atomically:YES];
    
    [[tipsPlist objectForKey:@"text"]removeObjectAtIndex:tag];
    [[tipsPlist objectForKey:@"time"]removeObjectAtIndex:tag];
    [[tipsPlist objectForKey:@"color"]removeObjectAtIndex:tag];
    [[tipsPlist objectForKey:@"notifyName"]removeObjectAtIndex:tag];
    [self writePlistFile];
    tipsPlist=[[NSMutableDictionary alloc]init];
    [self readPlistFile];
    [self getTextViewHeight];
    [mainTableView reloadData];
    
}

- (UIColor*) myColor:(int)colorNumber{
    UIColor *color=[UIColor clearColor];
    if (colorNumber==1) {
        color=[UIColor colorWithRed:255 green:174/255.f blue:185/255.f alpha:0.9];
    }else if (colorNumber==2){
        color=[UIColor colorWithRed:255 green:246/255.f blue:143/255.f alpha:0.9];
    }else if (colorNumber==3){
        color=[UIColor colorWithRed:154/255.f green:255 blue:154/255.f alpha:0.9];
    }else if (colorNumber==4){
        color=[UIColor colorWithRed:99/255.f green:184/255.f blue:255 alpha:0.9];
    }
    return color;
}

- (void)getTextViewHeight{
    heightArray=[[NSArray alloc]init];
    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(0, 100, 300, 40)];
    text.font=[UIFont systemFontOfSize:14];
    NSUInteger num=[[tipsPlist objectForKey:@"text"]count];
    for (int i=0; i<num; i++) {
        text.text=[[tipsPlist objectForKey:@"text"]objectAtIndex:i];
        
        CGFloat fixedWidth = text.frame.size.width;
        CGSize newSize = [text sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = text.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        NSString *height=[NSString stringWithFormat:@"%f",newFrame.size.height];
        
        heightArray=[heightArray arrayByAddingObject:height];
    }
    NSLog(@"tips=%@content=%@",[tipsPlist objectForKey:@"text"],heightArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonTapped:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==0) {
        NSLog(@"add");
        NewTipsView *newTipsView=[[NewTipsView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view addSubview:newTipsView];

        [UIView animateWithDuration:0.5f animations:^{
            newTipsView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                newTipsView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
            } completion:^(BOOL finished) {
            }];
        }];
    }
}

- (void)historyButton{
    HistoryViewController *history=[[HistoryViewController alloc]init];
    [self.navigationController pushViewController:history animated:YES];
}

- (void)homeButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Lock" object:@"Lock"];
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
        [self deletePlistFile:[deleteObj intValue]];
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Delet sucess!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
    }
}

@end
