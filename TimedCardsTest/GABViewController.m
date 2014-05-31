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
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CardOptions" ofType:@"plist"];
    NSDictionary *cardDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    cardOptions = cardDictionary[@"Cards"];
    
    _cards = [[NSMutableArray alloc] init];
    
    cardWidth = 199;
    cardHeight = cardWidth*1.55;
    turn = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int) turn
{
    return turn;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesEnded: touches withEvent: event];
}

-(void) updateCardPositions:(BOOL)withNewCard
{
    int xMargin = 5;
    
    [UIView beginAnimations:@"SlideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    if(withNewCard){
        [UIView setAnimationDidStopSelector:@selector(cardsDoneSliding:finished:context:)];
    }
    
    int currentCard = 1; // we're moving down by one
    int currentRow = 0;
    
    // TODO: make this dynamic based on card size?
    int numCardsPerRow = 5;
    for(GABTimedCard* aCard in _cards){
        int newX;
        if(currentCard+1 > numCardsPerRow){
            int cardPos = currentCard - numCardsPerRow;
            newX = cardPos * cardWidth + (cardPos+1) * xMargin;
        } else {
            newX = currentCard * cardWidth + (currentCard+1) * xMargin;
        }
        
        if(currentCard+1 > numCardsPerRow){
            currentRow = 1;
        }
        
        int newY = 70 + (currentRow*(cardHeight+ 20));
        aCard.frame = CGRectMake(newX, newY, cardWidth, cardHeight);
        currentCard++;
    }
    [UIView commitAnimations];

}

-(IBAction)drawCard:(id)sender
{
    [self updateCardPositions:YES];
    turn++;
}

-(void) cardsDoneSliding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    int xMargin = 5;
    
    
    GABTimedCard* newCard = [[GABTimedCard alloc] initWithFrame:CGRectMake(xMargin, 70, cardWidth, cardHeight)];
    [newCard setCardController:self];
    
    int selectedOption = arc4random() % [cardOptions count];
    [newCard setFromCardOptions:[cardOptions objectAtIndex:selectedOption]];    
    [_cards insertObject:newCard atIndex:0];
    [[self view] addSubview:newCard];
    [newCard start];

    
}


@end
