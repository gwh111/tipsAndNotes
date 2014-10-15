//
//  TipsHistoryTableViewCell.m
//  Tips&Notes
//
//  Created by apple on 14/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "TipsHistoryTableViewCell.h"

@implementation TipsHistoryTableViewCell

@synthesize timeHistoryLabel,contentHistoryTextView,deletButton;

- (void)awakeFromNib
{
    // Initialization code
    [deletButton addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tap{
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"Remove From History?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alt show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"delete");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteHistory" object:[NSString stringWithFormat:@"%ld",(long)deletButton.tag]];
    }
}

@end
