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
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        timeDisplay = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x +2, frame.origin.y+2, frame.size.width-2, 50)];
        [timeDisplay setTextColor:[UIColor blackColor]];
        [timeDisplay setBackgroundColor:[UIColor clearColor]];
        [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 50.0f]];
        [self addSubview:timeDisplay];
      
        [self setDuration:5];
        [self start];
    }
    return self;
}
-(void) setDuration:(int)duration
{
    timeDuration = duration;
    timeDisplay.text = [[NSString alloc] initWithFormat:@"%.02f",timeDuration];
    [self setNeedsDisplay];
}

-(void) start
{
    startedAt = [NSDate date];
}

-(void) checkExpiration:(NSTimer*)timer{
    NSDate* nowDate =[NSDate date];
    
    if([nowDate timeIntervalSinceDate:startedAt] > timeDuration){
        timeDisplay.text = @"Done";
    } else {
        timeDisplay.text = [[NSString alloc] initWithFormat:@"%.02f",timeDuration - [nowDate timeIntervalSinceDate:startedAt]];
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
