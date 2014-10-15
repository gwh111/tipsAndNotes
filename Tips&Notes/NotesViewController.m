//
//  NotesViewController.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "NotesViewController.h"
#import "DKCircleButtonNote.h"
#import "NotesAddViewController.h"
#import "NotesDetailViewController.h"
#import "NotesTableViewCell.h"

@interface NotesViewController ()

@end

NSMutableDictionary *notesPlist;
UITableView *mainNotesTableView;

@implementation NotesViewController

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
    self.view.backgroundColor=[UIColor colorWithRed:228/255.f green:228/255.f blue:228/255.f alpha:1];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navImageView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:navImageView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text=@"Notes";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    DKCircleButtonNote *addButton = [[DKCircleButtonNote alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    addButton.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height-80);
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [addButton setTitle:@"New" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton setTitleColor:[UIColor colorWithRed:126/255.f green:39/255.f blue:39/255.f alpha:1] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithRed:126/255.f green:39/255.f blue:39/255.f alpha:1] forState:UIControlStateSelected];
    [addButton setTitleColor:[UIColor colorWithRed:126/255.f green:39/255.f blue:39/255.f alpha:1] forState:UIControlStateHighlighted];
    addButton.tag=0;
    
    notesPlist=[[NSMutableDictionary alloc]init];
    
    mainNotesTableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 65, self.view.bounds.size.width-10, self.view.bounds.size.height-180)];
    mainNotesTableView.delegate=self;
    mainNotesTableView.dataSource=self;
    mainNotesTableView.backgroundColor=[UIColor clearColor];
    mainNotesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainNotesTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"Notes.plist"];
    //读出来看看
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    notesPlist=data;
    [mainNotesTableView reloadData];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[notesPlist objectForKey:@"text"]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NotesTableViewCell *cell = (NotesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.contentLabel.text=[[notesPlist objectForKey:@"text"]objectAtIndex:indexPath.section];
    cell.contentLabel.numberOfLines=2;
    cell.timeLabel.text=[[notesPlist objectForKey:@"time"]objectAtIndex:indexPath.section];
    cell.titleImageView.image=[self myImage:[[[notesPlist objectForKey:@"img"]objectAtIndex:indexPath.section]intValue]];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [mainNotesTableView deselectRowAtIndexPath:[mainNotesTableView indexPathForSelectedRow] animated:NO];
    NotesDetailViewController *detail=[[NotesDetailViewController alloc]init];
    detail.contentString=[NSString stringWithFormat:@"%@",[[notesPlist objectForKey:@"text"]objectAtIndex:indexPath.section]];
    detail.tagStringEdit=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 5)];
    return view;
}

- (UIImage*) myImage:(int)imageNumber{
    UIImage *myImage;
    if (imageNumber==1) {
        myImage=[UIImage imageNamed:@"mark1_h.png"];
    }else if (imageNumber==2){
        myImage=[UIImage imageNamed:@"mark2_h.png"];
    }else if (imageNumber==3){
        myImage=[UIImage imageNamed:@"mark3_h.png"];
    }else if (imageNumber==4){
        myImage=[UIImage imageNamed:@"mark4_h.png"];
    }else if (imageNumber==5){
        myImage=[UIImage imageNamed:@"mark5_h.png"];
    }
    return myImage;
}

- (void)buttonTapped{
    NotesAddViewController *add=[[NotesAddViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
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

@end
