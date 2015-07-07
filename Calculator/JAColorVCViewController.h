//
//  JAColorVCViewController.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAColorVCViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *customFirstColor;
@property (strong, nonatomic) IBOutlet UITextField *customSecondColor;
@property (strong, nonatomic) IBOutlet UITextField *customThirdColor;
@property (strong, nonatomic) IBOutlet UITextField *customFourthColor;

- (IBAction)committChanges:(id)sender;
@end
