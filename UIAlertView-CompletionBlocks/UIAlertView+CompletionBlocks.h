//
//  UIAlertView+CompletionBlocks.h
//  UIAlertView-CompletionBlocks
//
//  Created by Guy Kahlon on 4/11/14.
//  Copyright (c) 2014 GuyKahlon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewCompletionBlock)(BOOL, NSInteger);

@interface UIAlertView (CompletionBlocks)<UIAlertViewDelegate>

@property (copy, nonatomic) UIAlertViewCompletionBlock completionBlock;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
    completionBlock:(UIAlertViewCompletionBlock)completionBlock;

@end
