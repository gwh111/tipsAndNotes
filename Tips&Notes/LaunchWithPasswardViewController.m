//
//  LaunchWithPasswardViewController.m
//  Tips&Notes
//
//  Created by apple on 16/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "LaunchWithPasswardViewController.h"
#import "ViewController.h"

@interface LaunchWithPasswardViewController ()

@end

NSString *passwardString;
UITextField *passWardTextField;

@implementation LaunchWithPasswardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [passWardTextField becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    navImageView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:navImageView];
    
    passWardTextField=[[UITextField alloc]initWithFrame:CGRectMake(40, 100, self.view.bounds.size.width-80, 50)];
    passWardTextField.backgroundColor=[UIColor clearColor];
    passWardTextField.placeholder=@"Type Passward:";
    passWardTextField.textAlignment=NSTextAlignmentCenter;
    passWardTextField.keyboardType=UIKeyboardTypeNumberPad;
    passWardTextField.secureTextEntry=YES;
    passWardTextField.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:passWardTextField];
    [passWardTextField becomeFirstResponder];
    
    UIButton *bt1=[UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame=CGRectMake(50, 160, self.view.bounds.size.width-100, 44);
    [bt1 setTitle:@"Enter" forState:UIControlStateNormal];
    [bt1 setBackgroundColor:[UIColor clearColor]];
    bt1.titleLabel.font=[UIFont systemFontOfSize:12];
    [bt1 setTitleColor:[UIColor colorWithRed:99/255.f green:184/255.f blue:255 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:bt1];
    [bt1 addTarget:self action:@selector(bt1) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NeedPassward"]==nil) {
        ViewController *view=[[ViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }
    
    UIButton *rateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rateButton.backgroundColor=[UIColor clearColor];
    [rateButton setBackgroundImage:[UIImage imageNamed:@"rate.png"] forState:UIControlStateNormal];
    rateButton.frame=CGRectMake(0, 20, 50, 50);
    [rateButton addTarget:self action:@selector(rateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rateButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bt1{
    passwardString=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Passward" ]];
    if ([passWardTextField.text isEqualToString:passwardString]) {
        passWardTextField.text=@"";
        [passWardTextField resignFirstResponder];
        ViewController *view=[[ViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Passward is Wrong" delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil, nil];
        [alt show];
        passWardTextField.text=@"";
    }
}

- (void)rateButtonTapped{
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Please Help to Rate if You Like!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Got to Rate", nil];
    [alt show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        double version = [[UIDevice currentDevice].systemVersion doubleValue];
        if (buttonIndex==1) {
            if (version<7) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=930357625"]];
            }
            else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id930357625"]];
            }
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
