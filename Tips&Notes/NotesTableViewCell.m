//
//  NotesTableViewCell.m
//  Tips&Notes
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "NotesTableViewCell.h"

@implementation NotesTableViewCell
@synthesize timeLabel,titleImageView,contentLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
