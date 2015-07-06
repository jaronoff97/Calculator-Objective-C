//
//  ArithmeticProtocol.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef Calculator_ArtihmeticProtocol_h
#define Calculator_ArtihmeticProtocol_h
@protocol ArithmeticProtocol
-(NSNumber*) add: (NSNumber*) other;
-(NSNumber*) subtract: (NSNumber*) other;
-(NSNumber*) multiply: (NSNumber*) other;
-(NSNumber*) divide: (NSNumber*) other;
@end
#endif