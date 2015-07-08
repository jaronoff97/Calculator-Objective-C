//
//  JACalculatorBrain.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "JACalculatorBrain.h"
#import "JAOperator.h"
#import "NSMutableArray+Stack.h"

static JACalculatorBrain* _theBrain;

@implementation JACalculatorBrain
@synthesize calculationStack;
@synthesize numberButtonColorGlobal;
@synthesize operatorButtonColorGlobal;
@synthesize specialButtonColorGlobal;
@synthesize backgroundColorGlobal;

-(void) clearArray{
    calculationStack = [[NSMutableArray alloc] init];
}
+(JACalculatorBrain*) theBrain
{
    if (_theBrain == nil){
        _theBrain = [[JACalculatorBrain alloc] init];
        _theBrain.calculationStack=[[NSMutableArray alloc] init];
    }
    return _theBrain;
}
-(NSNumber*) calculate: (NSNumber*) lastOperand {
    [self.calculationStack push:lastOperand];
    NSLog(@"COUNT: %lu",(unsigned long)calculationStack.count);
    NSNumber* leftHandSide = nil; //construct a first number
    SEL selector = NULL;// construct a selector
    NSNumber* rightHandSide = nil; // construct a second number
    while(self.calculationStack.count!=1 && self.calculationStack.count>=3){
        //[self printArray];
        rightHandSide=(NSNumber*)calculationStack.pop;
        selector=NSSelectorFromString([self.calculationStack.pop description]);
        leftHandSide=(NSNumber*)calculationStack.pop;
        NSLog(@"LHS: %@ SEL: %@ RHS: %@",leftHandSide,NSStringFromSelector(selector),rightHandSide);
        IMP implementation = [leftHandSide methodForSelector:selector];//make an implementation (so there are no memory leaks)
        NSNumber* (*functionPointer)(id, SEL, NSNumber*);//make a function that points to the selector
        functionPointer = (NSNumber * (*)(id, SEL, NSNumber*))implementation; //implement the function
        NSNumber* number = functionPointer(leftHandSide, selector, rightHandSide);//use the function
        [self.calculationStack push:number];
    }
    NSNumber* toReturn = (NSNumber*)calculationStack.peek;
    [self clearArray];
    return toReturn;//return the first number
}
-(void) sendOperator:(JAOperator*) theOperator operand:(NSNumber*) theOperand{
    if([[calculationStack lastObject]isKindOfClass:[NSNumber class]]){
        [self.calculationStack push:theOperator];
        [self.calculationStack push:theOperand];
        NSLog(@"ADDED: Operator: %@, Operand: %@", theOperator, theOperand);
    }
    if(![[calculationStack lastObject]isKindOfClass:[NSNumber class]]){
        [self.calculationStack push:theOperand];
        [self.calculationStack push:theOperator];
        NSLog(@"ADDED: operand: %@, operator: %@", theOperand, theOperator);
    }
}
-(void) printArray {
    NSLog(@"START ARRAY");
    for (id varX in calculationStack) {
        NSLog(@"%@", varX); // print each variable in the equation
    }
    NSLog(@"END ARRAY");
}
@end
