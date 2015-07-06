//
//  JAOperator.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "JAOperator.h"
@implementation JAOperator
@synthesize operation;
@synthesize precedence;
-(JAOperator*) initWithOperation:(SEL)anOperation precedence:(unsigned int) thePrecedence{
    self = [super init];
    if(self){
        operation = anOperation;
        precedence = thePrecedence;
    }
    
    return (self);
}
@end
