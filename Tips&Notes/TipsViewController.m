//
//  TipsViewController.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "TipsViewController.h"
#import "TipsTableViewCell.h"

@interface TipsViewController ()

@end

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
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navImageView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:navImageView];
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(self.view.bounds.size.width/5*2, self.view.bounds.size.height-100, self.view.bounds.size.width/5, 44)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor blueColor]];
    [addButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    addButton.tag=0;
    
    UITableView *mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 70, self.view.bounds.size.width-20, self.view.bounds.size.height-170)];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
    cell.textLabel.text=@"my tips";
    cell.backgroundColor=[UIColor brownColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
    return view;
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
