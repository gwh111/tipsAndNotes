//
//  FirstLaunchViewController.m
//  Tips&Notes
//
//  Created by apple on 16/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "FirstLaunchViewController.h"
#import "ViewController.h"
@interface FirstLaunchViewController ()

@end

int passwardCount=0;
NSString *passwardString;
UITextField *passWardTextField;

@implementation FirstLaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    passwardCount=0;
    [passWardTextField becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    
    UIImageView *navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    navImageView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:navImageView];
    
//    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 50)];
//    label1.text=@"Enter A Passward:";
//    label1.textAlignment=NSTextAlignmentCenter;
//    label1.textColor=[UIColor grayColor];
//    label1.backgroundColor=[UIColor clearColor];
//    label1.font=[UIFont boldSystemFontOfSize:20];
//    [self.view addSubview:label1];
    
    passWardTextField=[[UITextField alloc]initWithFrame:CGRectMake(40, 100, self.view.bounds.size.width-80, 50)];
    passWardTextField.backgroundColor=[UIColor clearColor];
    passWardTextField.placeholder=@"Set A New Passward:";
    passWardTextField.textAlignment=NSTextAlignmentCenter;
    passWardTextField.keyboardType=UIKeyboardTypeNumberPad;
    passWardTextField.secureTextEntry=YES;
    passWardTextField.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:passWardTextField];

    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textFieldShouldReturn)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [passWardTextField setInputAccessoryView:topView];
    
    UIButton *bt1=[UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame=CGRectMake(50, 160, self.view.bounds.size.width-100, 44);
    [bt1 setTitle:@"Enter Without Passward" forState:UIControlStateNormal];
    [bt1 setBackgroundColor:[UIColor clearColor]];
    bt1.titleLabel.font=[UIFont systemFontOfSize:12];
    [bt1 setTitleColor:[UIColor colorWithRed:99/255.f green:184/255.f blue:255 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:bt1];
    [bt1 addTarget:self action:@selector(bt1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldShouldReturn{
    if (passwardCount==0) {
        if (passWardTextField.text.length==0) {
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Passward Can't Be Nil" delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil, nil];
            [alt show];
        }else if (passWardTextField.text.length>6){
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Passward Length Can't Be Too Long!" delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil, nil];
            [alt show];
            passWardTextField.text=@"";
        }else{
            passwardCount=1;
            passwardString=[NSString stringWithFormat:@"%@",passWardTextField.text];
            passWardTextField.text=@"";
            passWardTextField.placeholder=@"Re-Type Passward:";
        }
    }else{
        if ([passWardTextField.text isEqualToString:passwardString]) {
            NSLog(@"==");
            [passWardTextField resignFirstResponder];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"NeedPassward"];
            [[NSUserDefaults standardUserDefaults] setObject:passwardString forKey:@"Passward"];
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Welcome!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alt show];
            ViewController *view=[[ViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }else{
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Not Match!" delegate:nil cancelButtonTitle:@"Re-Type" otherButtonTitles:nil, nil];
            [alt show];
            passwardCount=0;
            passWardTextField.text=@"";
            passWardTextField.placeholder=@"Set A New Passward:";
        }
    }
}
- (void)bt1{
    [passWardTextField resignFirstResponder];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"First"];
    ViewController *view=[[ViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
