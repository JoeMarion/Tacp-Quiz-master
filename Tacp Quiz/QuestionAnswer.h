//
// Created by Reynaldo Gonzales on 2/14/14.
// Copyright (c) 2014 Joseph Marion. All rights reserved.

#import <Foundation/Foundation.h>


@interface QuestionAnswer : NSObject
@property (nonatomic, copy) NSString *question;
@property (nonatomic, strong) NSMutableArray *possibleAnswers;
@property (nonatomic, strong) NSString *rightAnswer;
@end