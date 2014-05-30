//
//  GABTimedCard.h
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GABTimedCard : UIView{
    NSTimeInterval timeDuration;
    NSDate* startedAt;
//    int turnDuration;
}

-(void) setDuration:(int)duration;
-(void) checkExpiration:(NSTimer*)timer;
-(void) start;

@end
