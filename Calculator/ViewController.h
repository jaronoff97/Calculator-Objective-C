//
//  ViewController.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)shadeButton:(UIButton *)sender;
- (IBAction)unShadeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)showEQdown:(id)sender;
- (IBAction)hideEQup:(id)sender;
-(SEL) getProperSelector: (NSString*) operation;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *specialButtons;
@property (weak, nonatomic) IBOutlet UIButton *debug;

-(void) setButtonColors: (NSString*) numberColorString opColor: (NSString*) operationColorString specColor: (NSString*) specialColorString backColor:(NSString*) backgroundColorString;

@end

