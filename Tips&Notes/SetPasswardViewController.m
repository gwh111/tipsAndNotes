//
//  SetPasswardViewController.m
//  Tips&Notes
//
//  Created by apple on 16/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "SetPasswardViewController.h"

@interface SetPasswardViewController ()

@end

int passwardCountSet=0;
NSString *passwardStringSet;
UITextField *passWardTextFieldSet;

@implementation SetPasswardViewController

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
    
    passWardTextFieldSet=[[UITextField alloc]initWithFrame:CGRectMake(40, 100, self.view.bounds.size.width-80, 50)];
    passWardTextFieldSet.backgroundColor=[UIColor clearColor];
    passWardTextFieldSet.placeholder=@"Set A New Passward:";
    passWardTextFieldSet.textAlignment=NSTextAlignmentCenter;
    passWardTextFieldSet.keyboardType=UIKeyboardTypeNumberPad;
    passWardTextFieldSet.secureTextEntry=YES;
    passWardTextFieldSet.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:passWardTextFieldSet];
    [passWardTextFieldSet becomeFirstResponder];
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textFieldShouldReturn)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [passWardTextFieldSet setInputAccessoryView:topView];
    
    UIButton *bt1=[UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame=CGRectMake(50, 160, self.view.bounds.size.width-100, 44);
    [bt1 setTitle:@"No Need Passward" forState:UIControlStateNormal];
    [bt1 setBackgroundColor:[UIColor clearColor]];
    bt1.titleLabel.font=[UIFont systemFontOfSize:12];
    [bt1 setTitleColor:[UIColor colorWithRed:99/255.f green:184/255.f blue:255 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:bt1];
    [bt1 addTarget:self action:@selector(bt1) forControlEvents:UIControlEventTouchUpInside];

    UIButton *rateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rateButton.backgroundColor=[UIColor clearColor];
    [rateButton setBackgroundImage:[UIImage imageNamed:@"rate.png"] forState:UIControlStateNormal];
    rateButton.frame=CGRectMake(0, 20, 50, 50);
    [rateButton addTarget:self action:@selector(rateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rateButton];
}

- (void)textFieldShouldReturn{
    if (passwardCountSet==0) {
        if (passWardTextFieldSet.text.length==0) {
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Passward Can't Be Nil" delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil, nil];
            [alt show];
        }else if (passWardTextFieldSet.text.length>6){
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Passward Length Can't Be Too Long!" delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil, nil];
            [alt show];
            passWardTextFieldSet.text=@"";
        }else{
            passwardCountSet=1;
            passwardStringSet=[NSString stringWithFormat:@"%@",passWardTextFieldSet.text];
            passWardTextFieldSet.text=@"";
            passWardTextFieldSet.placeholder=@"Re-Type Passward:";
        }
    }else{
        if ([passWardTextFieldSet.text isEqualToString:passwardStringSet]) {
            NSLog(@"==");
            [passWardTextFieldSet resignFirstResponder];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"NeedPassward"];
            [[NSUserDefaults standardUserDefaults] setObject:passwardStringSet forKey:@"Passward"];
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Welcome!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alt show];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Not Match!" delegate:nil cancelButtonTitle:@"Re-Type" otherButtonTitles:nil, nil];
            [alt show];
            passwardCountSet=0;
            passWardTextFieldSet.text=@"";
            passWardTextFieldSet.placeholder=@"Set A New Passward:";
        }
    }
}
- (void)bt1{
    [passWardTextFieldSet resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
