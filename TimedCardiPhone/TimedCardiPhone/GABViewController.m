//
//  GABViewController.m
//  TimedCardiPhone
//
//  Created by Greg Borenstein on 6/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABViewController.h"

@interface GABViewController ()

@end

@implementation GABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CardOptions" ofType:@"plist"];
    NSMutableDictionary *cardDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    cardOptions = cardDictionary[@"Cards"];
    
    turnsUntilVillain = 6;
    cardInPlay = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    if([currentCard complete] && [cardOptions count] > 0){
//        [self drawCard:self];
//    }
    [super touchesEnded: touches withEvent: event];
}


-(IBAction)drawCard:(id)sender
{
    turnsUntilVillain--;
    [turnCounter setText:[NSString stringWithFormat:@"%i", turnsUntilVillain]];
    
    if(turnsUntilVillain == 0){
        turnsUntilVillain = 6;
        [turnCounter setText:[NSString stringWithFormat:@"%i", turnsUntilVillain]];
        
        currentCard = [[GABTimedCard alloc] initWithFrame:CGRectMake(10, 25, self.view.frame.size.width-20, self.view.frame.size.height-50)];
        int selectedOption = arc4random() % [cardOptions count];
        [currentCard setFromCardOptions:[cardOptions objectAtIndex:selectedOption]];
    
        [cardOptions removeObjectAtIndex:selectedOption];
    
        [currentCard setCardController:self];
        [[self view] addSubview:currentCard];
        [currentCard start];
    }
}


@end
