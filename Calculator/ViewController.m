//
//  ViewController.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "ViewController.h"
#import "JAOperator.h"
#import "NSNumber+ArithmeticProtocol.h"
#import "JACalculatorBrain.h"

NSString* equation;
NSString* displayText;
JACalculatorBrain* myBrain;

@interface ViewController ()

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    if([myBrain.specialButtonColorGlobal length]>=5){
        [self setButtonColors:myBrain.numberButtonColorGlobal opColor:myBrain.operatorButtonColorGlobal specColor:myBrain.specialButtonColorGlobal backColor:myBrain.backgroundColorGlobal];
    }
    self.debug.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    equation = @"";
    displayText = @"";
    myBrain = [JACalculatorBrain theBrain];
    myBrain.numberButtonColorGlobal= @"#D7DB00";
    myBrain.operatorButtonColorGlobal= @"#000000";
    myBrain.specialButtonColorGlobal= @"#00FF00";
    myBrain.backgroundColorGlobal= @"#FFFFFF";
    
    // Do any additional setup after loading the view, typically from a nib.

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setButtonColors: (NSString*) numberColorString opColor: (NSString*) operationColorString specColor: (NSString*) specialColorString backColor:(NSString*) backgroundColorString{
    UIColor* numberColor = [self colorFromHexString:numberColorString];
    UIColor* operationColor = [self colorFromHexString:operationColorString];
    UIColor* specialColor = [self colorFromHexString:specialColorString];
    UIColor* backgroundColor = [self colorFromHexString:backgroundColorString];
    self.displayLabel.textColor = [self inverseColor:backgroundColor];
    for(UIButton *button in self.numberButtons){
        button.backgroundColor=numberColor;
    }
    for(UIButton *button in self.operationButtons){
        button.backgroundColor=operationColor;
    }
    for(UIButton *button in self.specialButtons){
        button.backgroundColor=specialColor;
    }
    self.view.backgroundColor = backgroundColor;
}
-(void) updateLabel: (NSString*) newDigit {
    if ([newDigit isEqualToString:@"12"] && [displayText rangeOfString:@"."].location==NSNotFound) {
        newDigit = @".";
    }
    if([newDigit isEqualToString:@"12"] && [displayText rangeOfString:@"."].location!=NSNotFound){
        newDigit=@"";
    }
    equation = [equation stringByAppendingFormat:@"%@", newDigit];//add the new digit to the equation
    displayText = [displayText stringByAppendingFormat:@"%@", newDigit];//add the new digit to the onscreen NSString
    self.displayLabel.text = displayText; //if it wasnt an operator set the onscreen text to the stored variable


}
-(void) addOperator: (NSString* ) operatorTag {
        if (operatorTag.intValue > 9) { //check if the onscreen NSString is a number or a operator
            if(![displayText isEqualToString:@""]) {
                NSNumber* number = @([displayText floatValue]);//construct the number
                JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: operatorTag] precedence:[self operatorPrecedence:operatorTag]];//construct the operator
                [myBrain sendOperator:operator operand:number];
                equation = [equation stringByAppendingFormat:@"%@", [self operatorString:operatorTag]];//add the new digit to the equation
            }
            displayText = @""; //also clear the stored data
        }
    
}
-(NSString*) operatorString: (NSString*) opTag {
    switch (opTag.intValue) {
    case 13: return @"+"; break;
    case 14: return @"-"; break;
    case 15: return @"÷"; break;
    case 16: return @"*"; break;
    default: return @""; break;
    }
}
-(unsigned int) operatorPrecedence: (NSString*) opTag{
    switch (opTag.intValue) {
        case 13: return 2; break;
        case 14: return 2; break;
        case 15: return 3; break;
        case 16: return 3; break;
        default: return 0; break;
    }
}
-(SEL) getProperSelector: (NSString*) operation {
    SEL selector = NULL;
    if ([operation isEqualToString:@"13"]) {
        selector = NSSelectorFromString(@"add:");
    }
    if ([operation isEqualToString:@"14"]) {
        selector = NSSelectorFromString(@"subtract:");
    }
    if ([operation isEqualToString:@"15"]) {
        selector = NSSelectorFromString(@"divide:");
    }
    if ([operation isEqualToString:@"16"]) {
        selector = NSSelectorFromString(@"multiply:");
    }
    return selector;//this gives the calculator the right type of selector
}
-(void)shadeButton:(UIButton*)sender {
    sender.selected = !sender.selected;
    NSNumber* number;
    switch (sender.tag) {
    case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8: case 9: case 12: {
        [self updateLabel: [NSString stringWithFormat:@"%ld", (long)sender.tag]];//otherwise just add the number to equation.
        break;
    }
    case 10: {
        if ([displayText rangeOfString:@"-"].location != NSNotFound) { //if there is a - already
            displayText = [displayText stringByReplacingOccurrencesOfString:@"-" withString:@""];//get rid of it
        }

        else {
            displayText = [NSString stringWithFormat:@"-%@", displayText]; //otherwise add one
        }
        [self updateLabel:@""];
        break;
    }
    case 11: {
        equation = @"";
        displayText = @"";
        [[myBrain calculationStack] removeAllObjects];
        [self updateLabel:@""];//remove it all!!! <(._.)>
        break;
    }
    case 13: case 14: case 15: case 16: {
            [self addOperator: [NSString stringWithFormat:@"%ld", (long)sender.tag]];//otherwise just add the number to equation.
        
        break;
    }
    case 17: {
        number = @([displayText floatValue]);//get the current number
        if([myBrain calculationStack].count>0 && [[[myBrain calculationStack] objectAtIndex:0] isEqual:@1234]){
            self.debug.hidden=NO;
        }
        NSNumber* calculation = [myBrain calculate: number];//CALCULATE THAT STUFF
        displayText = [NSString stringWithFormat:@"%@", calculation]; //set the display text
        self.displayLabel.text = displayText; //show the display text
        break;
    }
    default: break;
    }
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}
-(UIColor*) inverseColor: (UIColor*) oldColor
{
    CGFloat r,g,b,a;
    [oldColor getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}
- (IBAction)unShadeButton:(UIButton *)sender {
    sender.selected = !sender.selected;//unshade the button
}
- (IBAction)showEQdown:(id)sender {
    self.displayLabel.text = equation;//display the WHOLE equation
}

- (IBAction)hideEQup:(id)sender {
    self.displayLabel.text = displayText; //only display the current text
}

@end
