//
//  NSNumber+ArithmeticProtocol.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (ArithmeticProtocol)
-(NSNumber*) add: (NSNumber*) other;
-(NSNumber*) subtract: (NSNumber*) other;
-(NSNumber*) multiply: (NSNumber*) other;
-(NSNumber*) divide: (NSNumber*) other;

@end
