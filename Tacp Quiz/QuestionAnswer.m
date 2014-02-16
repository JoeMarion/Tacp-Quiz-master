//
// Created by Reynaldo Gonzales on 2/14/14.
// Copyright (c) 2014 Joseph Marion. All rights reserved.

#import "QuestionAnswer.h"


@implementation QuestionAnswer
- (instancetype)init {
    if((self = [super init])) {
        self.possibleAnswers = [NSMutableArray array];
    }

    return self;
}
@end