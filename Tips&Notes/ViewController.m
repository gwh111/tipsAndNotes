//
//  ViewController.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "ViewController.h"
#import "TipsViewController.h"
#import "NotesViewController.h"
#include <dlfcn.h>
@interface ViewController ()

@end

UITabBarController *tabBarController;

UINavigationController *nav1;
UINavigationController *nav2;

UIButton *tabBarButton1;
UIButton *tabBarButton2;

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    [self firestLaunch];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
   
    TipsViewController *tips=[[TipsViewController alloc]init];
    NotesViewController *notes=[[NotesViewController alloc]init];
    
    nav1=[[UINavigationController alloc]initWithRootViewController:tips];
    nav2=[[UINavigationController alloc]initWithRootViewController:notes];
    
    tabBarController=[[UITabBarController alloc]init];
    tabBarController.delegate=self;
    tabBarController.viewControllers=[NSArray arrayWithObjects:nav1,nav2, nil];
    
    tabBarController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    tabBarController.tabBar.hidden=YES;
    [self.view addSubview:tabBarController.view];
    
    //tabBar
    UIImageView *backBarImageView=[[UIImageView alloc]init];
    backBarImageView.frame=CGRectMake(0, self.view.bounds.size.height-44, 320, 44);
    backBarImageView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:backBarImageView];
    
    tabBarButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    tabBarButton1.frame=CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width/2, 44);
    tabBarButton1.backgroundColor=[UIColor clearColor];
    [tabBarButton1 setTitle:@"Tips" forState:UIControlStateNormal];
    [tabBarButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tabBarButton1 setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    tabBarButton1.highlighted=NO;
    [self.view addSubview:tabBarButton1];
    [tabBarButton1 addTarget:self action:@selector(tabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    tabBarButton1.tag=1;
    
    tabBarButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    tabBarButton2.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height-44, self.view.bounds.size.width/2, 44);
    tabBarButton2.backgroundColor=[UIColor clearColor];
    [tabBarButton2 setTitle:@"Notes" forState:UIControlStateNormal];
    [tabBarButton2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    tabBarButton2.highlighted=NO;
    [self.view addSubview:tabBarButton2];
    [tabBarButton2 addTarget:self action:@selector(tabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    tabBarButton2.tag=2;
    

}



- (void)firestLaunch{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Tips"]==nil) {
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Tips" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Tips.plist"];
        //输入写入
        [data writeToFile:filename atomically:YES];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"Tips"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"History"]==nil) {
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"History" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"History.plist"];
        //输入写入
        [data writeToFile:filename atomically:YES];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"History"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Notes"]==nil) {
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Notes.plist"];
        //输入写入
        [data writeToFile:filename atomically:YES];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"Notes"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarButton:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        tabBarController.selectedViewController=nav1;
        NSLog(@"tips");
        [tabBarButton1 setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
        [tabBarButton2 setBackgroundImage:[UIImage imageNamed:@"button_clear.png"] forState:UIControlStateNormal];
        
        [tabBarButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tabBarButton2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else if (button.tag==2){
        tabBarController.selectedViewController=nav2;
        NSLog(@"notes");
        [tabBarButton1 setBackgroundImage:[UIImage imageNamed:@"button_clear.png"] forState:UIControlStateNormal];
        [tabBarButton2 setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
        
        [tabBarButton1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tabBarButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

@end
