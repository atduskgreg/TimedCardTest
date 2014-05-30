//
//  GABTimedCard.h
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GABTimedCard : UIView{
    NSTimeInterval timeDuration;
    NSDate* startedAt;
    UILabel* timeDisplay;
//    int turnDuration;
}

-(void) setDuration:(int)duration;
-(void) checkExpiration:(NSTimer*)timer;
-(void) start;

@end
