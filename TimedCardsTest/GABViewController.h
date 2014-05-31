//
//  GABViewController.h
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "GABTimedCard.h"

@interface GABViewController : UIViewController{
    int cardWidth;
    int cardHeight;
    
    NSArray* cardOptions;
    
    int turn;

}

@property (nonatomic, retain) NSMutableArray* cards;
;


-(void) updateCardPositions:(BOOL)withNewCard;
-(IBAction)drawCard:(id)sender;
-(void) cardsDoneSliding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
-(int) turn;

@end
