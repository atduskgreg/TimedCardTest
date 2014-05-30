//
//  GABTimedCard.h
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GABViewController.h"

@interface GABTimedCard : UIView{
    NSTimeInterval timeDuration;
    NSDate* timeStartedAt;
    UILabel* timeDisplay;
    int turnDuration;
    int turnStartedAt;
    BOOL isTurnBased;
}

-(void) setFromCardOptions:(NSDictionary*)options;

-(void) setDuration:(int)duration;
-(void) checkExpiration:(NSTimer*)timer;
-(void) start;

@property (nonatomic, retain) NSString* completionText;
@property (nonatomic, retain) NSMutableArray* cards;


@end
