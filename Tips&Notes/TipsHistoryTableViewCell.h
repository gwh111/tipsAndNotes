//
//  TipsHistoryTableViewCell.h
//  Tips&Notes
//
//  Created by apple on 14/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsHistoryTableViewCell : UITableViewCell{
    UILabel *timeHistoryLabel;
    UITextView *contentHistoryTextView;
}

@property (nonatomic,retain)IBOutlet UILabel *timeHistoryLabel;
@property (nonatomic,retain)IBOutlet UITextView *contentHistoryTextView;

@end
