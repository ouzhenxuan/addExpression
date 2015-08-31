//
//  UITextView+expression.h
//  AddExpressionInUITextView
//
//  Created by ozx on 15/8/31.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (expression)
- (void)setCommentTextView:(NSString *)content;
-(void)getMessageRange:(NSString*)message :(NSMutableArray*)array ;
- (void)getUserNameRange:(NSString *)message;
@end
