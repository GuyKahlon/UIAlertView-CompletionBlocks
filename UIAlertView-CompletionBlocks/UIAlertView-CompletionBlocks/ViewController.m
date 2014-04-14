//
//  ViewController.m
//  UIAlertView-CompletionBlocks
//
//  Created by Guy Kahlon on 4/11/14.
//  Copyright (c) 2014 GuyKahlon. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+CompletionBlocks.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert with completion block"
                                                    message:@"Click on button and see the index button on the result label"
                                          cancelButtonTitle:@"Cancel Button"
                                          otherButtonTitles:@"button 1", @"button 2", @"button 3",nil];
    
    alert.completionBlock = ^(BOOL cancelled, NSInteger buttonIndex) {
        
        NSLog(@"Completion Block");
        if (!cancelled)
        {
            NSLog(@"cancelled Button");
        }
        NSLog(@"Index Button %d", buttonIndex);
        self.resultLabel.text = [NSString stringWithFormat:@"Button Index %d %@",buttonIndex,cancelled == YES ? @"(Cancel button)" : @""];
    };
    
    [alert show];
}
- (IBAction)showAlert2:(UIButton *)sender
{
    [[[UIAlertView alloc]initWithTitle:@"Alert with completion block"
                               message:@"Click on button and see the index button on the result label"
                     cancelButtonTitle:@"button 0"
                     otherButtonTitles:@[@"button 1", @"button 2"]
                      completionBlock:^(BOOL cancelled, NSInteger buttonIndex) {
                          self.resultLabel.text = [NSString stringWithFormat:@"Button Index %d %@",buttonIndex,cancelled == YES ? @"(Cancel button)" : @""];
                      }]show];
}

@end
