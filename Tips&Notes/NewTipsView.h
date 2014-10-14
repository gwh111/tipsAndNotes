//
//  NewTipsView.h
//  Tips&Notes
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTipsView : UIView<UITextViewDelegate>{
    UITextView *tipsTextView;
    UIButton *nextButton;
    UIDatePicker *datePicker;
    
}

@property(nonatomic,retain)UITextView *tipsTextView;
@property(nonatomic,retain)UIButton *nextButton;
@property(nonatomic,retain)UIDatePicker *datePicker;

@end
