//
//  GABTimedCard.m
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABTimedCard.h"

@implementation GABTimedCard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [NSTimer scheduledTimerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(checkExpiration:)
                                       userInfo:nil repeats:YES];
        [self setDuration:5];
        [self start];
    }
    return self;
}
-(void) setDuration:(int)duration
{
    timeDuration = duration;
}

-(void) start
{
    startedAt = [NSDate date];
}

-(void) checkExpiration:(NSTimer*)timer{
    NSDate* nowDate =[NSDate date];
    
    if([nowDate timeIntervalSinceDate:startedAt] > timeDuration){
        NSLog(@"done");
    } else {
        NSLog(@"%f",[nowDate timeIntervalSinceDate:startedAt]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
