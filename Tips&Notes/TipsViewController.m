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

@interface TipsViewController ()

@end

NSMutableDictionary *tipsPlist;
//newTips
UITextView *tipsTextView;
UIButton *cancelButton;
UIButton *nextButton;
UITableView *mainTableView;

@implementation TipsViewController

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
    
    tipsPlist=[[NSMutableDictionary alloc]init];
    [self readPlistFile];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navImageView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:navImageView];
    
    mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 70, self.view.bounds.size.width-20, self.view.bounds.size.height-170)];
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
}

- (void)readPlistFile{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"tips.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    tipsPlist=data;
}
- (void)writePlistFile{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"tips.plist"];
    //输入写入
    [tipsPlist writeToFile:filename atomically:YES];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[tipsPlist objectForKey:@"text"]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsTableViewCell *cell = (TipsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TipsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.textLabel.text=[[tipsPlist objectForKey:@"text"]objectAtIndex:indexPath.section];
    cell.backgroundColor=[self myColor:[[[tipsPlist objectForKey:@"color"]objectAtIndex:indexPath.section]intValue]];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [mainTableView deselectRowAtIndexPath:[mainTableView indexPathForSelectedRow] animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 11)];
    return view;
}

- (void) renew:(NSNotification*) notification{
    
    id obj = [notification object];//获取到传递的对象
    if ([obj isEqualToString:@"NewTips"]) {
        NSLog(@"NewTips");
        tipsPlist=[[NSMutableDictionary alloc]init];
        [self readPlistFile];
        
        [mainTableView reloadData];
    }
}

- (UIColor*) myColor:(int)colorNumber{
    UIColor *color=[UIColor clearColor];
    if (colorNumber==1) {
        color=[UIColor colorWithRed:255 green:120/255.f blue:120/255.f alpha:1];
    }else if (colorNumber==2){
        color=[UIColor colorWithRed:255 green:255 blue:120/255.f alpha:1];
    }else if (colorNumber==3){
        color=[UIColor colorWithRed:120/255.f green:255 blue:120/255.f alpha:1];
    }else if (colorNumber==4){
        color=[UIColor colorWithRed:120/255.f green:120/255.f blue:255 alpha:1];
    }
    return color;
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
                newTipsView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            } completion:^(BOOL finished) {
            }];
        }];
    }
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
