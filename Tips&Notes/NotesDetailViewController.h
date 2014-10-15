//
//  NotesDetailViewController.h
//  Tips&Notes
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesDetailViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>{
    NSString *tagStringEdit;
    NSString *contentString;
}
@property(nonatomic,retain)NSString *tagStringEdit;
@property(nonatomic,retain)NSString *contentString;
@end
