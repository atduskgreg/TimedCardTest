//
//  GABViewController.h
//  TimedCardiPhone
//
//  Created by Greg Borenstein on 6/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GABTimedCard.h"


@interface GABViewController : UIViewController{
    NSMutableArray* cardOptions;
    int turnsUntilVillain;
    BOOL cardInPlay;
    GABTimedCard* currentCard;
}

-(IBAction)drawCard:(id)sender;

@end
