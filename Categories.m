//
//  Categories.m
//  Tacp Quiz
//
//  Created by Joseph Marion on 1/28/14.
//  Copyright (c) 2014 Joseph Marion. All rights reserved.
//

#import "Categories.h"

int Category1SelectedNumber;
int Category2SelectedNumber;
int Category3SelectedNumber;
int Category4SelectedNumber;
int Category5SelectedNumber;

@interface Categories () {
    IBOutlet UIButton *Category1;
    IBOutlet UIButton *Category2;
    IBOutlet UIButton *Category3;
    IBOutlet UIButton *Category4;
    IBOutlet UIButton *Category5;
}

-(IBAction)Button1:(id)sender;
-(IBAction)Button2:(id)sender;
-(IBAction)Button3:(id)sender;
-(IBAction)Button4:(id)sender;
-(IBAction)Button5:(id)sender;

@end

@implementation Categories

- (void)viewDidLoad {
    [super viewDidLoad];

    [Category1 setTitle:@"CDC Volume 1" forState:UIControlStateNormal];
    Category1SelectedNumber = 1;

    [Category2 setTitle:@"CDC Volume 2" forState:UIControlStateNormal];
    Category2SelectedNumber = 2;

    [Category3 setTitle:@"CDC Volume 3" forState:UIControlStateNormal];
    Category3SelectedNumber = 3;

    [Category4 setTitle:@"CDC All Volumes" forState:UIControlStateNormal];
    Category4SelectedNumber = 4;

    [Category5 setTitle:@"MQF Test" forState:UIControlStateNormal];
    Category5SelectedNumber = 5;
}

-(IBAction)Button1:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setInteger:Category1SelectedNumber forKey:@"CategorySaved"];
    
}

-(IBAction)Button2:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setInteger:Category2SelectedNumber forKey:@"CategorySaved"];
    
}

-(IBAction)Button3:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:Category3SelectedNumber forKey:@"CategorySaved"];
    
}

-(IBAction)Button4:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setInteger:Category4SelectedNumber forKey:@"CategorySaved"];
    
}

-(IBAction)Button5:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setInteger:Category5SelectedNumber forKey:@"CategorySaved"];
    
}


@end
