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

NSMutableArray* equationArray;
NSString* equation;
NSString* displayText;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    equation= @"";
    displayText=@"";
    equationArray = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateLabel: (NSString*) newDigit{
    equation = [equation stringByAppendingFormat:@"%@", newDigit];//add the new digit to the equation
    displayText = [displayText stringByAppendingFormat:@"%@", newDigit];//add the new digit to the onscreen NSString
    if([newDigit rangeOfString:@"."].location !=NSNotFound){
        
    }
    else if ([newDigit rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) { //check if the onscreen NSString is a number or a operator
        if([equationArray count]==1){//if theres only one variable in the array (this happens after one calculation is completed
            JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: newDigit] precedence:0];//construct the operator!
            [equationArray addObject: operator];// add the operator.
        }
        else{
        NSNumber* number = @([displayText floatValue]);//construct the number
        [equationArray addObject: number];//add the number
        JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: newDigit] precedence:0];//construct the operator
        [equationArray addObject: operator];//add the operator
        }
        self.displayLabel.text=@"";//no matter what clear the screen
        displayText=@"";//also clear the stored data
    }
    else{
        self.displayLabel.text=displayText;//if it wasnt an operator set the onscreen text to the stored variable
    }
    
}
-(void) printArray{
    NSLog(@"START ARRAY");
    for (id varX in equationArray) {
        NSLog(@"%@",varX);// print each variable in the equation
    }
    NSLog(@"END ARRAY");
}
-(SEL) getProperSelector: (NSString*) operation{
    SEL selector = NULL;
    if([operation isEqualToString:@"+"]){
        selector = NSSelectorFromString(@"add:");
    }
    if([operation isEqualToString:@"*"]){
        selector = NSSelectorFromString(@"multiply:");
    }
    if([operation isEqualToString:@"/"]){
        selector = NSSelectorFromString(@"divide:");
    }
    if([operation isEqualToString:@"-"]){
        selector = NSSelectorFromString(@"subtract:");
    }
    return selector;//this gives the calculator the right type of selector
}
-(void)shadeButton:(UIButton*)sender{
    sender.selected = !sender.selected;//make it look like the button has been touched
    if([sender.titleLabel.text isEqualToString:@"C"]){// if it's the clear button
        equation=@"";
        displayText=@"";
        [equationArray removeAllObjects];
        [self updateLabel:@""];//remove it all!!! <(._.)>
    }
    else if ([sender.titleLabel.text isEqualToString:@"±"]){
        if([displayText rangeOfString:@"-"].location!=NSNotFound){//if there is a - already
            displayText = [displayText stringByReplacingOccurrencesOfString:@"-" withString:@""];//get rid of it
        }
        else{
            displayText = [NSString stringWithFormat:@"-%@",displayText];//otherwise add one
        }
        [self updateLabel:@""];//update the label
    }
    else if ([sender.titleLabel.text isEqualToString:@"="]){//if its time to calculate.
        NSNumber* number = @([displayText floatValue]);//get the current number
        [equationArray addObject: number];//add the current number to the array
        NSNumber* calculation = [self calculate];//CALCULATE THAT STUFF
        displayText=[NSString stringWithFormat:@"%@",calculation];//set the display text
        self.displayLabel.text=displayText;//show the display text
        [equationArray removeAllObjects];//get rid of everything
        [equationArray addObject:calculation];//add the calculation though!
    }
    else{
        [self updateLabel: [NSString stringWithFormat:@"%@", sender.titleLabel.text]];//otherwise just add the number to equation.
        
    }
}
-(NSNumber*) calculate{
    NSNumber* firstNum=nil;//construct a first number
    SEL selector = NULL;// construct a selector
    NSNumber* secondNum=nil;// construct a second number
    for (int i=0; i<[equationArray count]; i++) {
        if(i%2!=0){
            selector=NSSelectorFromString([[equationArray objectAtIndex:i] description]);//if the for loop is at the odd intervals remake the proper selector
        }
        else{
            if(firstNum==nil){
                firstNum=[equationArray objectAtIndex:i];//if the firstnum doesnt exist make it.
            }
            else if(secondNum==nil){
                secondNum=[equationArray objectAtIndex:i];// same for the second num
            }
        }
        if(secondNum!=nil && firstNum!=nil && selector!=NULL){// once the three variables are filled
            IMP implementation = [firstNum methodForSelector:selector];//make an implementation (so there are no memory leaks)
            NSNumber* (*functionPointer)(id, SEL, NSNumber*);//make a function that points to the selector
            functionPointer = (NSNumber* (*)(id,SEL,NSNumber*))implementation;//implement the function
            NSNumber* number = functionPointer(firstNum, selector, secondNum);//use the function
            firstNum=number;//set the first number as the answer
            secondNum=nil;// reset the second number
            selector=NULL;//reset the selector
        }
    }
    return firstNum;//return the first number
}
- (IBAction)unShadeButton:(UIButton *)sender {
    sender.selected = !sender.selected;//unshade the button
}
- (IBAction)showEQdown:(id)sender {
    self.displayLabel.text = equation;//display the WHOLE equation
}

- (IBAction)hideEQup:(id)sender {
    self.displayLabel.text=displayText;//only display the current text
}
@end
