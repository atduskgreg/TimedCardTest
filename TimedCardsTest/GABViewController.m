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
    
    cardWidth =199;
    cardHeight = cardWidth*1.55;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Began");
    
    int xMargin = 5;
//    int cardX = [cards count] * cardWidth + ([cards count]+1)*xMargin;
    
    [UIView beginAnimations:@"SlideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(cardsDoneSliding:finished:context:)];
    
    int currentCard = 1; // we're moving down by one
    int currentRow = 0;

    // TODO: make this dynamic based on card size?
    int numCardsPerRow = 5;
    NSLog(@"numCardsPerRow: %i frame width: %f cardWidth: %i", numCardsPerRow,[self view].frame.size.width, cardWidth);
    for(GABTimedCard* aCard in cards){
        int newX;
        NSLog(@"currentCard: %i numCardsPerRow: %i", currentCard, numCardsPerRow);
        if(currentCard+1 > numCardsPerRow){
            int cardPos = currentCard - numCardsPerRow;
            newX = cardPos * cardWidth + (cardPos+1) * xMargin;
        } else {
         newX = currentCard * cardWidth + (currentCard+1) * xMargin;
        }

        if(currentCard+1 > numCardsPerRow){
            currentRow =1;
        }
        
        int newY = 20 + (currentRow*(cardHeight+ 20));
        aCard.frame = CGRectMake(newX, newY, cardWidth, cardHeight);
        currentCard++;
    }
    [UIView commitAnimations];
    
    
    [super touchesEnded: touches withEvent: event];
}

-(void) cardsDoneSliding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    int xMargin = 5;

    GABTimedCard* newCard = [[GABTimedCard alloc] initWithFrame:CGRectMake(xMargin, 20, cardWidth, cardHeight)];
    [cards insertObject:newCard atIndex:0];
    [[self view] addSubview:newCard];
    
}


@end
