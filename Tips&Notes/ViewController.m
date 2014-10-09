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

@interface ViewController ()

@end

UITabBarController *tabBarController;

UINavigationController *nav1;
UINavigationController *nav2;

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.view addSubview:tabBarController.view];
    
    //tabBar
    UIImageView *backBarImageView=[[UIImageView alloc]init];
    backBarImageView.frame=CGRectMake(0, self.view.bounds.size.height-50, 320, 50);
    backBarImageView.backgroundColor=[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    [self.view addSubview:backBarImageView];
    
    UIButton *tabBarButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    tabBarButton1.frame=CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width/2, 50);
    tabBarButton1.backgroundColor=[UIColor yellowColor];
    tabBarButton1.highlighted=NO;
    [self.view addSubview:tabBarButton1];
    [tabBarButton1 addTarget:self action:@selector(tabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    tabBarButton1.tag=1;
    
    UIButton *tabBarButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    tabBarButton2.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height-50, self.view.bounds.size.width/2, 50);
    tabBarButton2.backgroundColor=[UIColor greenColor];
    tabBarButton2.highlighted=NO;
    [self.view addSubview:tabBarButton2];
    [tabBarButton2 addTarget:self action:@selector(tabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    tabBarButton2.tag=2;
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
        
    }else if (button.tag==2){
        tabBarController.selectedViewController=nav2;
        NSLog(@"notes");
    }
}

@end
