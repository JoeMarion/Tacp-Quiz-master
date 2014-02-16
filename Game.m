//
//  Game.m
//  AF PDG
//
//  Created by Joseph Marion on 2/3/14.
//  Copyright (c) 2014 Children Eaters Inc. All rights reserved.
//

#import "Game.h"
#import "QuestionAnswer.h"

// Rather than loading all of the questions in a switch statement,
// I'd place the questions and corresponding options in a file

NSInteger CategoryLoaded;
NSInteger QuestionSelected;
BOOL Answer1Correct;
BOOL Answer2Correct;
BOOL Answer3Correct;
BOOL Answer4Correct;
int ScoreNumber;
int LivesNumber;
BOOL GameInProgress;

@interface Game () {
    IBOutlet UILabel *CategorySelected;
    IBOutlet UILabel *QuestionText;
    IBOutlet UIButton *Answer1;
    IBOutlet UIButton *Answer2;
    IBOutlet UIButton *Answer3;
    IBOutlet UIButton *Answer4;
    IBOutlet UIButton *NextCategory;
    IBOutlet UIButton *Exit;
    IBOutlet UILabel *Score;
    IBOutlet UILabel *Lives;
    IBOutlet UILabel *Result;
    IBOutlet UILabel *CorrectAnswerDisplay;
}

@property (nonatomic, strong) NSArray *answersForCategoryOne;

-(IBAction)Answer1:(id)sender;
-(IBAction)Answer2:(id)sender;
-(IBAction)Answer3:(id)sender;
-(IBAction)Answer4:(id)sender;
-(void)Category1;
-(void)Category2;
-(void)Category3;
-(void)Category4;
-(void)Category5;
-(void)RightAnswer;
-(void)WrongAnswer;
@end

@implementation Game

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!GameInProgress) {
        LivesNumber = 10;
        ScoreNumber = 0;
        GameInProgress = YES;
    }

    Result.hidden = YES;
    Exit.hidden = YES;
    NextCategory.hidden = YES;
    CorrectAnswerDisplay.hidden = YES;

    Lives.text = [NSString stringWithFormat:@"%i", LivesNumber];
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];

    Answer1Correct = NO;
    Answer2Correct = NO;
    Answer3Correct = NO;
    Answer4Correct = NO;


    CategoryLoaded = [[NSUserDefaults standardUserDefaults] integerForKey:@"CategorySaved"];

    switch (CategoryLoaded) {
        case 1:
            CategorySelected.text = [NSString stringWithFormat:@"CDC Volume I"];
            [self loadCDCVolume1];
            break;
        case 2:
            CategorySelected.text = [NSString stringWithFormat:@"CDC Volume 2"];
            [self loadCDCVolume2];
            break;
        case 3:
            CategorySelected.text = [NSString stringWithFormat:@"CDC Volume 3"];
            [self loadCDCVolume3];
            break;
        case 4:
            CategorySelected.text = [NSString stringWithFormat:@"CDC All Volumes"];
            [self loadCDCVolumeAll];
            break;
        case 5:
            CategorySelected.text = [NSString stringWithFormat:@"MQF Test"];
            [self loadMQF];
            break;

        default:
            break;
    }
}

#pragma mark - Question/Answer Loading

- (void)loadCDCVolume1 {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CDCVolume1"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    // Line is going to have @[Question, Answer, ..., * Correct Answer]

    NSMutableArray *questionAnswers = [NSMutableArray array];

    BOOL loadedQuestion = NO;

    QuestionAnswer *questionAnswer = [QuestionAnswer new];

    for(NSString *line in lines) {
        if(!loadedQuestion) {
            loadedQuestion = YES;
            questionAnswer.question = line;
            continue;
        }

        if([line isEqualToString:@""]) {
            [questionAnswers addObject:questionAnswer];
            questionAnswer = [QuestionAnswer new];
            loadedQuestion = NO;
            continue;
        }

        NSString *firstCharacter = [line substringToIndex:1];

        if([firstCharacter isEqualToString:@"*"]) {
            NSString *correctAnswer = [line substringWithRange:NSMakeRange(2, line.length - 2)];
            questionAnswer.rightAnswer = correctAnswer;
            continue;
        } else {
            [questionAnswer.possibleAnswers addObject:line];
            continue;
        }
    }

    QuestionAnswer *tempQuestionAnswer = [questionAnswers objectAtIndex:0];

    QuestionText.text = tempQuestionAnswer.question;

    [Answer1 setTitle:@"" forState:UIControlStateNormal];
    [Answer2 setTitle:@"" forState:UIControlStateNormal];
    [Answer3 setTitle:@"" forState:UIControlStateNormal];
    [Answer4 setTitle:@"" forState:UIControlStateNormal];

    if(tempQuestionAnswer.possibleAnswers.count >= 1) {
        [Answer1 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:0] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 2) {
        [Answer2 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:1] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 3) {
        [Answer3 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:2] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 4) {
        [Answer4 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:3] forState:UIControlStateNormal];
    }

    CorrectAnswerDisplay.text = tempQuestionAnswer.rightAnswer;

    NSInteger indexOfCorrectAnswer = 0;

    for(NSString *possibleAnswer in tempQuestionAnswer.possibleAnswers) {
        if([possibleAnswer isEqualToString:tempQuestionAnswer.rightAnswer]) {
            break;
        }

        indexOfCorrectAnswer++;
    }

    if(indexOfCorrectAnswer == 0) Answer1Correct = YES;
    else if(indexOfCorrectAnswer == 1) Answer2Correct = YES;
    else if(indexOfCorrectAnswer == 2) Answer3Correct = YES;
    else if(indexOfCorrectAnswer == 3) Answer4Correct = YES;
}

- (void)loadCDCVolume2 {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CDCVolume2"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    // Line is going to have @[Question, Answer, ..., * Correct Answer]

    NSMutableArray *questionAnswers = [NSMutableArray array];

    BOOL loadedQuestion = NO;

    QuestionAnswer *questionAnswer = [QuestionAnswer new];

    for(NSString *line in lines) {
        if(!loadedQuestion) {
            loadedQuestion = YES;
            questionAnswer.question = line;
            continue;
        }

        if([line isEqualToString:@""]) {
            [questionAnswers addObject:questionAnswer];
            questionAnswer = [QuestionAnswer new];
            loadedQuestion = NO;
            continue;
        }

        NSString *firstCharacter = [line substringToIndex:1];

        if([firstCharacter isEqualToString:@"*"]) {
            NSString *correctAnswer = [line substringWithRange:NSMakeRange(2, line.length - 2)];
            questionAnswer.rightAnswer = correctAnswer;
            continue;
        } else {
            [questionAnswer.possibleAnswers addObject:line];
            continue;
        }
    }

    QuestionAnswer *tempQuestionAnswer = [questionAnswers objectAtIndex:0];

    QuestionText.text = tempQuestionAnswer.question;

    [Answer1 setTitle:@"" forState:UIControlStateNormal];
    [Answer2 setTitle:@"" forState:UIControlStateNormal];
    [Answer3 setTitle:@"" forState:UIControlStateNormal];
    [Answer4 setTitle:@"" forState:UIControlStateNormal];

    if(tempQuestionAnswer.possibleAnswers.count >= 1) {
        [Answer1 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:0] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 2) {
        [Answer2 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:1] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 3) {
        [Answer3 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:2] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 4) {
        [Answer4 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:3] forState:UIControlStateNormal];
    }

    CorrectAnswerDisplay.text = tempQuestionAnswer.rightAnswer;

    NSInteger indexOfCorrectAnswer = 0;

    for(NSString *possibleAnswer in tempQuestionAnswer.possibleAnswers) {
        if([possibleAnswer isEqualToString:tempQuestionAnswer.rightAnswer]) {
            break;
        }

        indexOfCorrectAnswer++;
    }

    if(indexOfCorrectAnswer == 0) Answer1Correct = YES;
    else if(indexOfCorrectAnswer == 1) Answer2Correct = YES;
    else if(indexOfCorrectAnswer == 2) Answer3Correct = YES;
    else if(indexOfCorrectAnswer == 3) Answer4Correct = YES;
}

- (void)loadCDCVolume3 {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CDCVolume3"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    // Line is going to have @[Question, Answer, ..., * Correct Answer]

    NSMutableArray *questionAnswers = [NSMutableArray array];

    BOOL loadedQuestion = NO;

    QuestionAnswer *questionAnswer = [QuestionAnswer new];

    for(NSString *line in lines) {
        if(!loadedQuestion) {
            loadedQuestion = YES;
            questionAnswer.question = line;
            continue;
        }

        if([line isEqualToString:@""]) {
            [questionAnswers addObject:questionAnswer];
            questionAnswer = [QuestionAnswer new];
            loadedQuestion = NO;
            continue;
        }

        NSString *firstCharacter = [line substringToIndex:1];

        if([firstCharacter isEqualToString:@"*"]) {
            NSString *correctAnswer = [line substringWithRange:NSMakeRange(2, line.length - 2)];
            questionAnswer.rightAnswer = correctAnswer;
            continue;
        } else {
            [questionAnswer.possibleAnswers addObject:line];
            continue;
        }
    }

    QuestionAnswer *tempQuestionAnswer = [questionAnswers objectAtIndex:0];

    QuestionText.text = tempQuestionAnswer.question;

    [Answer1 setTitle:@"" forState:UIControlStateNormal];
    [Answer2 setTitle:@"" forState:UIControlStateNormal];
    [Answer3 setTitle:@"" forState:UIControlStateNormal];
    [Answer4 setTitle:@"" forState:UIControlStateNormal];

    if(tempQuestionAnswer.possibleAnswers.count >= 1) {
        [Answer1 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:0] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 2) {
        [Answer2 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:1] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 3) {
        [Answer3 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:2] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 4) {
        [Answer4 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:3] forState:UIControlStateNormal];
    }

    CorrectAnswerDisplay.text = tempQuestionAnswer.rightAnswer;

    NSInteger indexOfCorrectAnswer = 0;

    for(NSString *possibleAnswer in tempQuestionAnswer.possibleAnswers) {
        if([possibleAnswer isEqualToString:tempQuestionAnswer.rightAnswer]) {
            break;
        }

        indexOfCorrectAnswer++;
    }

    if(indexOfCorrectAnswer == 0) Answer1Correct = YES;
    else if(indexOfCorrectAnswer == 1) Answer2Correct = YES;
    else if(indexOfCorrectAnswer == 2) Answer3Correct = YES;
    else if(indexOfCorrectAnswer == 3) Answer4Correct = YES;
}

- (void)loadCDCVolumeAll {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CDCVolumeAll"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    // Line is going to have @[Question, Answer, ..., * Correct Answer]

    NSMutableArray *questionAnswers = [NSMutableArray array];

    BOOL loadedQuestion = NO;

    QuestionAnswer *questionAnswer = [QuestionAnswer new];

    for(NSString *line in lines) {
        if(!loadedQuestion) {
            loadedQuestion = YES;
            questionAnswer.question = line;
            continue;
        }

        if([line isEqualToString:@""]) {
            [questionAnswers addObject:questionAnswer];
            questionAnswer = [QuestionAnswer new];
            loadedQuestion = NO;
            continue;
        }

        NSString *firstCharacter = [line substringToIndex:1];

        if([firstCharacter isEqualToString:@"*"]) {
            NSString *correctAnswer = [line substringWithRange:NSMakeRange(2, line.length - 2)];
            questionAnswer.rightAnswer = correctAnswer;
            continue;
        } else {
            [questionAnswer.possibleAnswers addObject:line];
            continue;
        }
    }

    QuestionAnswer *tempQuestionAnswer = [questionAnswers objectAtIndex:0];

    QuestionText.text = tempQuestionAnswer.question;

    [Answer1 setTitle:@"" forState:UIControlStateNormal];
    [Answer2 setTitle:@"" forState:UIControlStateNormal];
    [Answer3 setTitle:@"" forState:UIControlStateNormal];
    [Answer4 setTitle:@"" forState:UIControlStateNormal];

    if(tempQuestionAnswer.possibleAnswers.count >= 1) {
        [Answer1 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:0] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 2) {
        [Answer2 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:1] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 3) {
        [Answer3 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:2] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 4) {
        [Answer4 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:3] forState:UIControlStateNormal];
    }

    CorrectAnswerDisplay.text = tempQuestionAnswer.rightAnswer;

    NSInteger indexOfCorrectAnswer = 0;

    for(NSString *possibleAnswer in tempQuestionAnswer.possibleAnswers) {
        if([possibleAnswer isEqualToString:tempQuestionAnswer.rightAnswer]) {
            break;
        }

        indexOfCorrectAnswer++;
    }

    if(indexOfCorrectAnswer == 0) Answer1Correct = YES;
    else if(indexOfCorrectAnswer == 1) Answer2Correct = YES;
    else if(indexOfCorrectAnswer == 2) Answer3Correct = YES;
    else if(indexOfCorrectAnswer == 3) Answer4Correct = YES;
}

- (void)loadMQF {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MQF"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    // Line is going to have @[Question, Answer, ..., * Correct Answer]

    NSMutableArray *questionAnswers = [NSMutableArray array];

    BOOL loadedQuestion = NO;

    QuestionAnswer *questionAnswer = [QuestionAnswer new];

    for(NSString *line in lines) {
        if(!loadedQuestion) {
            loadedQuestion = YES;
            questionAnswer.question = line;
            continue;
        }

        if([line isEqualToString:@""]) {
            [questionAnswers addObject:questionAnswer];
            questionAnswer = [QuestionAnswer new];
            loadedQuestion = NO;
            continue;
        }

        NSString *firstCharacter = [line substringToIndex:1];

        if([firstCharacter isEqualToString:@"*"]) {
            NSString *correctAnswer = [line substringWithRange:NSMakeRange(2, line.length - 2)];
            questionAnswer.rightAnswer = correctAnswer;
            continue;
        } else {
            [questionAnswer.possibleAnswers addObject:line];
            continue;
        }
    }

    QuestionAnswer *tempQuestionAnswer = [questionAnswers objectAtIndex:0];

    QuestionText.text = tempQuestionAnswer.question;

    [Answer1 setTitle:@"" forState:UIControlStateNormal];
    [Answer2 setTitle:@"" forState:UIControlStateNormal];
    [Answer3 setTitle:@"" forState:UIControlStateNormal];
    [Answer4 setTitle:@"" forState:UIControlStateNormal];

    if(tempQuestionAnswer.possibleAnswers.count >= 1) {
        [Answer1 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:0] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 2) {
        [Answer2 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:1] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 3) {
        [Answer3 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:2] forState:UIControlStateNormal];
    }

    if(tempQuestionAnswer.possibleAnswers.count >= 4) {
        [Answer4 setTitle:[tempQuestionAnswer.possibleAnswers objectAtIndex:3] forState:UIControlStateNormal];
    }

    CorrectAnswerDisplay.text = tempQuestionAnswer.rightAnswer;

    NSInteger indexOfCorrectAnswer = 0;

    for(NSString *possibleAnswer in tempQuestionAnswer.possibleAnswers) {
        if([possibleAnswer isEqualToString:tempQuestionAnswer.rightAnswer]) {
            break;
        }

        indexOfCorrectAnswer++;
    }

    if(indexOfCorrectAnswer == 0) Answer1Correct = YES;
    else if(indexOfCorrectAnswer == 1) Answer2Correct = YES;
    else if(indexOfCorrectAnswer == 2) Answer3Correct = YES;
    else if(indexOfCorrectAnswer == 3) Answer4Correct = YES;
}


#pragma mark - UI/Storyboard

-(IBAction)Answer1:(id)sender {
    
    if (Answer1Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
    
}

-(IBAction)Answer2:(id)sender {
    if (Answer2Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
    
    
}

-(IBAction)Answer3:(id)sender {
    if (Answer3Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
    
    
}

-(IBAction)Answer4:(id)sender {
    if (Answer4Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
    
    
}


#pragma mark - Business Logic




-(void)RightAnswer {
    ScoreNumber = ScoreNumber + 1;
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    NextCategory.hidden = NO;
    Answer1.hidden = YES;
    Answer2.hidden = YES;
    Answer3.hidden = YES;
    Answer4.hidden = YES;
    CategorySelected.hidden = YES;
    Result.hidden = NO;
    Result.text = [NSString stringWithFormat:@"Correct"];
    CorrectAnswerDisplay.hidden = NO;
}

-(void)WrongAnswer {

    LivesNumber = LivesNumber - 1;
    Lives.text = [NSString stringWithFormat:@"%i", LivesNumber];
    NextCategory.hidden = NO;
    Answer1.hidden = YES;
    Answer2.hidden = YES;
    Answer3.hidden = YES;
    Answer4.hidden = YES;
    CategorySelected.hidden = YES;
    Result.hidden = NO;
    Result.text = [NSString stringWithFormat:@"Incorrect"];
    CorrectAnswerDisplay.hidden = NO;

    if (LivesNumber == 0) {
        Result.text = [NSString stringWithFormat:@"Game Over! You Suck."];
        NextCategory.hidden = YES;
        Exit.hidden = NO;
        GameInProgress = NO;

    }
}

@end
