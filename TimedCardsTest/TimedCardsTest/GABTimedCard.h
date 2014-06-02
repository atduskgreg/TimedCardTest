//
//  GABTimedCard.h
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class GABViewController;

@interface GABTimedCard : UIView{
    NSTimeInterval timeDuration;
    NSDate* timeStartedAt;
    UILabel* timeDisplay;
    UILabel* attackDisplay;
    
    int turnDuration;
    int turnStartedAt;
    BOOL isTurnBased;
    int cardWidth;
    int cardHeight;
    BOOL isExpired;    
}

-(void) setRandomly;
-(void) setFromCardOptions:(NSDictionary*)options;

-(void) setDuration:(int)duration;
-(void) checkExpiration:(NSTimer*)timer;
-(void) start;
-(void) dismiss:(UISwipeGestureRecognizer*)gestureRecognizer;

@property (nonatomic, retain) NSString* attackRequirement;
@property (nonatomic, retain) NSString* completionText;
@property (nonatomic, retain) GABViewController* cardController;


@end
