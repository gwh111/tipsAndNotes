//
//  TipsTableViewCell.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "TipsTableViewCell.h"

@implementation TipsTableViewCell
@synthesize editButton,doneButton,deleButton;

- (void)awakeFromNib
{
    // Initialization code
    editButton.backgroundColor=[UIColor whiteColor];
    [editButton.layer setMasksToBounds:YES];
    [editButton.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [editButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    editButton.titleLabel.font=[UIFont systemFontOfSize:12];
    
    doneButton.backgroundColor=[UIColor whiteColor];
    [doneButton.layer setMasksToBounds:YES];
    [doneButton.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [doneButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    doneButton.titleLabel.font=[UIFont systemFontOfSize:12];
    
    deleButton.backgroundColor=[UIColor whiteColor];
    [deleButton.layer setMasksToBounds:YES];
    [deleButton.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [deleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    deleButton.titleLabel.font=[UIFont systemFontOfSize:12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
