//
//  TipsTableViewCell.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "TipsTableViewCell.h"

@implementation TipsTableViewCell
@synthesize editButton,doneButton,deleButton,timeLabel,contentTextView,titleLabel,upButton;

- (void)awakeFromNib
{
    // Initialization code
    editButton.backgroundColor=[UIColor clearColor];
//    [editButton.layer setMasksToBounds:YES];
//    [editButton.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [editButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
    editButton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    
    doneButton.backgroundColor=[UIColor clearColor];
//    [doneButton.layer setMasksToBounds:YES];
//    [doneButton.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [doneButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
    doneButton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    
    deleButton.backgroundColor=[UIColor clearColor];
//    [deleButton.layer setMasksToBounds:YES];
//    [deleButton.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [deleButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
    deleButton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    
//    editButton.alpha=0;
//    doneButton.alpha=0;
//    deleButton.alpha=0;
    
    editButton.tag=11111;
    doneButton.tag=22222;
    deleButton.tag=33333;
    
    [upButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [editButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [deleButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buttonTapped:(id)sender{
    UIButton *button=(UIButton *)sender;
    
    if (button.tag==11111) {
        
    }else if (button.tag==22222){
        NSLog(@"taped2");
    }else if (button.tag==33333){
        NSLog(@"taped3");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteTips" object:[NSString stringWithFormat:@"%ld",(long)upButton.tag]];
    }else{
//        [UIView animateWithDuration:0.5f animations:^{
//            editButton.alpha=1;
//            doneButton.alpha=1;
//            deleButton.alpha=1;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:1.0f animations:^{
//                editButton.alpha=0.9;
//                doneButton.alpha=0.9;
//                deleButton.alpha=0.9;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:2.0f animations:^{
//                    editButton.alpha=0;
//                    doneButton.alpha=0;
//                    deleButton.alpha=0;
//                } completion:^(BOOL finished) {
//                }];
//            }];
//        }];
    }
    
}

@end
