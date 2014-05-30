//
//  GABViewController.m
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABViewController.h"

@interface GABViewController ()

@end

@implementation GABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    cards = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Began");
    
    // TODO: dynamically set card location based on number of cards on screen/in grid
    GABTimedCard* newCard = [[GABTimedCard alloc] initWithFrame:CGRectMake(20, 20, 200, 200*1.55)];
    [cards addObject:newCard];
    [[self view] addSubview:newCard];
    
    [super touchesEnded: touches withEvent: event];
    
}

@end
