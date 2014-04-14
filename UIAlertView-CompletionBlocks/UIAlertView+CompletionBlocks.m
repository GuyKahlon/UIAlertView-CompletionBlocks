//
//  UIAlertView+CompletionBlocks.m
//  UIAlertView-CompletionBlocks
//
//  Created by Guy Kahlon on 4/11/14.
//  Copyright (c) 2014 GuyKahlon. All rights reserved.
//

#import "UIAlertView+CompletionBlocks.h"
#import <objc/runtime.h>

@implementation UIAlertView (CompletionBlocks)

- (UIAlertViewCompletionBlock )completionBlock {
    return objc_getAssociatedObject(self, @selector(completionBlock));
}

- (void)setCompletionBlock:(UIAlertViewCompletionBlock)completion{
    objc_setAssociatedObject(self, @selector(completionBlock), completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [self initWithTitle:title
                       message:message
                      delegate:self
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:nil];
    if(self)
    {
        NSString *buttonTitle;
        va_list argumentList;
        if (otherButtonTitles) // The first argument isn't part of the varargs list,
        {            
            [self addButtonWithTitle: otherButtonTitles]; // so we'll handle it separately.
            va_start(argumentList, otherButtonTitles);    // Start scanning for arguments after firstObject.
            while((buttonTitle = va_arg(argumentList, NSString *))) // As many times as we can get an argument of type "NSString"
            {
                [self addButtonWithTitle: buttonTitle];// that isn't nil, add new button with title.
            }
            va_end(argumentList);
            
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
    completionBlock:(UIAlertViewCompletionBlock)completionBlock
{
    self = [self initWithTitle:title
                       message:message
                      delegate:self
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:nil];
    if(self)
    {
        for (NSString *buttonTitle in otherButtonTitles)
        {
            [self addButtonWithTitle:buttonTitle];
        }
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (self.completionBlock) {
        self.completionBlock(buttonIndex==self.cancelButtonIndex, buttonIndex);
        self.completionBlock = nil;
    }
}
@end
