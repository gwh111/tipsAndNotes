//
//  TipsTableViewCell.h
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsTableViewCell : UITableViewCell{
    UIButton *editButton;
    UIButton *doneButton;
    UIButton *deleButton;
    
    UILabel *timeLabel;
    UILabel *titleLabel;
    UITextView *contentTextView;
    
    UIButton *upButton;
}

@property (nonatomic,retain)IBOutlet UIButton *editButton;
@property (nonatomic,retain)IBOutlet UIButton *doneButton;
@property (nonatomic,retain)IBOutlet UIButton *deleButton;

@property (nonatomic,retain)IBOutlet UILabel *timeLabel;
@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@property (nonatomic,retain)IBOutlet UITextView *contentTextView;

@property (nonatomic,retain) UIButton *upButton;

@end
