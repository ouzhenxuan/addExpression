//
//  ViewController.m
//  AddExpressionInUITextView
//
//  Created by yons on 15/8/24.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+expression.h"

@interface ViewController ()
{
    NSString * expression;
}
- (IBAction)showTextToTextView:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFeild;

@property (weak, nonatomic) IBOutlet UITextView *showTextView;
- (IBAction)addImageToText:(id)sender;
- (IBAction)changcolor:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    expression = @"[smile]";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *
 *将文字显示到uitextView上
 *
 */
- (IBAction)showTextToTextView:(id)sender {
    [self.showTextView setCommentTextView:_textFeild.text];
//    [_showTextView];
}

- (IBAction)addImageToText:(id)sender {
    NSString * newText = [NSString stringWithFormat:@"%@%@",_textFeild.text,expression];
    _textFeild.text = newText;
}

- (IBAction)changcolor:(id)sender {
    [self.showTextView getUserNameRange:_showTextView.text];
}








@end
