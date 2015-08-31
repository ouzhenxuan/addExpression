//
//  UITextView+expression.m
//  AddExpressionInUITextView
//
//  Created by ozx on 15/8/31.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "UITextView+expression.h"

@implementation UITextView (expression)

//将每次输入的字段进行解析，如果有表情，则将表情解析完以后显示图片，没有则直接显示文字
- (void)setCommentTextView:(NSString *)content
{
    self.text = @"";
    @try {
        
        NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
        
        [self getMessageRange:content :imageArr];
        
        
        NSLog(@"%@",imageArr);
        
        [imageArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSLog(@"%@",obj);
            
            NSString *contentPartStr = [NSString stringWithFormat:@"%@",obj];
            if (contentPartStr.length > 0) {
                
                NSString *firstC = [obj substringWithRange:NSMakeRange(0, 1)];
                NSAttributedString *attributedStr;
                
                if ([firstC isEqualToString:@"["]) {
                    
                    NSRange firstRange = [obj rangeOfString:@"["];
                    NSRange secondRange = [obj rangeOfString:@"]"];
                    
                    NSUInteger length = secondRange.location - firstRange.location;
                    NSRange imageNameRange = NSMakeRange(1, length - 1);
                    NSString *imageName = [obj substringWithRange:imageNameRange];
                    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
                    NSLog(@"%@",obj);
                    
                    
                    attachment.image = [UIImage imageNamed:imageName];
                    attachment.bounds = CGRectMake(0, 0, 20, 20);
                    attributedStr = [[NSAttributedString alloc]initWithString:@""];
                    attributedStr = [NSAttributedString attributedStringWithAttachment:attachment];
                }else{
                    
                    attributedStr = [[NSAttributedString alloc]initWithString:obj];
                    
                }
                [self.textStorage appendAttributedString:attributedStr];
                
            }
            
            
            
        }];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        
    }
    
}

-(void)getMessageRange:(NSString*)message :(NSMutableArray*)array {
    
    NSRange rangeL = [message rangeOfString:@"["];
    NSRange rangeR = [message rangeOfString:@"]"];
    //判断当前字符串是否还有表情的标志。
    if (rangeL.length && rangeR.length) {
        if (rangeL.location > 0) {
            
            [array addObject:[message substringToIndex:rangeL.location]];
            [array addObject:[message substringWithRange:NSMakeRange(rangeL.location, rangeR.location + 1 - rangeL.location)]];
            
            NSString *str = [message substringFromIndex:rangeR.location + 1];
            [self getMessageRange:str :array];
        }
        else {
            NSString *nextstr = [message substringWithRange:NSMakeRange(rangeL.location, rangeR.location + 1 - rangeL.location)];
            //排除“”空字符串
            if (![nextstr isEqualToString:@""]) {
                
                [array addObject:nextstr];
                
                NSString *str = [message substringFromIndex:rangeR.location + 1];
                [self getMessageRange:str :array];
            }
            else {
                
                return;
            }
        }
    }
    else {
        [array addObject:message];
    }
}

- (void)getUserNameRange:(NSString *)message{
    NSRange rangeL = [message rangeOfString:@"@"];
    NSRange rangeR = [message rangeOfString:@":"];
    NSRange rangeR1 = [message rangeOfString:@": "];
    NSUInteger lenght = rangeR.location - rangeL.location;
    if (lenght>100) {
        return;//正常的用户名,都不会超出这个范围。用于防止用户输入了中文符号显示的错误。
    }
    NSRange userNameRange = NSMakeRange(0, lenght);
    
    [self.textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:userNameRange];
}


@end
