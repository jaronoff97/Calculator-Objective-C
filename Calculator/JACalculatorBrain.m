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
-(NSNumber*) calculate: (NSNumber*) lastOperand{
    NSNumber* leftHandSide = nil; //construct a first number
    SEL selector = NULL;// construct a selector
    NSNumber* rightHandSide = nil; // construct a second number
    NSNumber* number=nil;
    if([[self.calculationStack lastObject]isKindOfClass:[JAOperator class]]){
        [self.calculationStack push:lastOperand];
    }
    else{
        return lastOperand;
    }
    NSMutableArray* sortedQueue = [[NSMutableArray alloc] init];
    NSMutableArray* stack = [[NSMutableArray alloc] init];
    for(id oper in calculationStack){
        if([oper isKindOfClass:[NSNumber class]]){
            [sortedQueue addObject:(NSNumber*) oper];
        }else{
            JAOperator* operator = (JAOperator*) oper;
            while(stack.count!=0 && [operator precedence]<[[stack peek] precedence]){
                [sortedQueue addObject:[stack pop]];
            }
            [stack push: operator];
        }
    }
    while(stack.count>0){
        [sortedQueue addObject:[stack pop]];
    }
    [self printArray:sortedQueue];
    for(id lastID in sortedQueue){
        if([lastID isKindOfClass:[JAOperator class]]){
            //NSLog(@" - -- - - - - - - - --  - -- - - - - -1 - - - - - - - - - - - - ");
            rightHandSide=(NSNumber*)[stack pop];
            leftHandSide=(NSNumber*)[stack pop];
            //NSLog(@" - -- - - - - - - - --  - -- - - - - -2 - - - - - - - - - - - - ");
            selector=NSSelectorFromString([lastID description]);
            //NSLog(@" - -- - - - - - - - --  - -- - - - - -3 - - - - - - - - - - - - ");
            
            NSLog(@"lhs: %@ sel: %@ rhs: %@",leftHandSide,NSStringFromSelector(selector),rightHandSide);
            IMP implementation = [leftHandSide methodForSelector:selector];//make an implementation (so there are no memory leaks)
            NSNumber* (*functionPointer)(id, SEL, NSNumber*);//make a function that points to the selector
            functionPointer = (NSNumber * (*)(id, SEL, NSNumber*))implementation; //implement the function
            number = functionPointer(leftHandSide, selector, rightHandSide);
            //NSLog(@" - -- - - - - - - - --  - -- - - - - -4 - - - - - - - - - - - - ");
            [stack push:number];
        }
        else{
            [stack push:lastID];
        }
    }
    NSLog(@" - -- - - - - - - - --  - -- - - - - -5 - - - - - - - - - - - - ");
    
    
    /*NSNumber* leftHandSide = nil; //construct a first number
    SEL selector = NULL;// construct a selector
    NSNumber* rightHandSide = nil; // construct a second number
    while(self.calculationStack.count>1){
        leftHandSide=(NSNumber*)calculationStack.dequeue;
        selector=NSSelectorFromString([self.calculationStack.dequeue description]);
        rightHandSide=(NSNumber*)calculationStack.dequeue;
     
         //rightHandSide=(NSNumber*)calculationStack.pop;
         //selector=NSSelectorFromString([self.calculationStack.pop description]);
         //leftHandSide=(NSNumber*)calculationStack.pop;//If you want to use right to left
     
        NSLog(@"lhs: %@ sel: %@ rhs: %@",leftHandSide,NSStringFromSelector(selector),rightHandSide);
        IMP implementation = [leftHandSide methodForSelector:selector];//make an implementation (so there are no memory leaks)
        NSNumber* (*functionPointer)(id, SEL, NSNumber*);//make a function that points to the selector
        functionPointer = (NSNumber * (*)(id, SEL, NSNumber*))implementation; //implement the function
        NSNumber* number = functionPointer(leftHandSide, selector, rightHandSide);//use the function
        [self.calculationStack insertAtZero:number];*/
        //[self.calculationStack push:number];//If you want to use right to left
    
    
    
    NSNumber* toReturn = (NSNumber*)[stack peek];
    [self clearArray];
    return toReturn;//return the first number
}
-(void) sendOperator:(JAOperator*) theOperator operand:(NSNumber*) theOperand{
    if([[calculationStack lastObject]isKindOfClass:[NSNumber class]]){
        [self.calculationStack push:theOperator];
        [self.calculationStack push:theOperand];
    }
    if(![[calculationStack lastObject]isKindOfClass:[NSNumber class]]){
        [self.calculationStack push:theOperand];
        [self.calculationStack push:theOperator];
    }
}
-(NSNumber*) solveExpression:(NSMutableArray *)theArray{
    NSNumber* toReturn;
    return toReturn;
}
-(void) printArray: (NSMutableArray*) theArray {
    NSLog(@"START ARRAY");
    for (id varX in theArray) {
        NSLog(@"%@", varX); // print each variable in the equation
    }
    NSLog(@"END ARRAY");
}
@end
