//
//  NotesTableViewCell.h
//  Tips&Notes
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesTableViewCell : UITableViewCell{
    UILabel *timeLabel;
    UILabel *contentLabel;
    UIImageView *titleImageView;
}

@property(nonatomic,retain) IBOutlet UILabel *timeLabel;
@property(nonatomic,retain) IBOutlet UILabel *contentLabel;
@property(nonatomic,retain) IBOutlet UIImageView *titleImageView;

@end
