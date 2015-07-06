//
//  NSNumber+ArithmeticProtocol.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "NSNumber+ArithmeticProtocol.h"

@implementation NSNumber (ArithmeticProtocol)
-(NSNumber*) add: (NSNumber*) other{
    float sum = self.floatValue + other.floatValue;
    return [NSNumber numberWithFloat:sum];
}
-(NSNumber*) subtract: (NSNumber*) other{
    float difference = self.floatValue - other.floatValue;
    return [NSNumber numberWithFloat:difference];
}
-(NSNumber*) divide: (NSNumber*) other{
    float quotient = self.floatValue / other.floatValue;
    return [NSNumber numberWithFloat:quotient];
}
-(NSNumber*) multiply: (NSNumber*) other{
    float product = self.floatValue * other.floatValue;
    return [NSNumber numberWithFloat:product];
}

@end
