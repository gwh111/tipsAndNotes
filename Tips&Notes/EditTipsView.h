//
//  EditTipsView.h
//  Tips&Notes
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTipsView : UIView<UITextViewDelegate>{
    UITextView *tipsTextViewEdit;
    UIButton *nextButtonEdit;
    UIDatePicker *datePickerEdit;
    NSString *tagStringEdit;
}

@property(nonatomic,retain)UITextView *tipsTextViewEdit;
@property(nonatomic,retain)UIButton *nextButtonEdit;
@property(nonatomic,retain)UIDatePicker *datePickerEdit;
@property(nonatomic,retain)NSString *tagStringEdit;

@end
