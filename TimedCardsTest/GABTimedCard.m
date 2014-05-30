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
        [self setBackgroundColor:[UIColor whiteColor]];
        
        timeDisplay = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-2)];
        [timeDisplay setTextColor:[UIColor blackColor]];
        [timeDisplay setBackgroundColor:[UIColor clearColor]];
        [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 50.0f]];
        [timeDisplay setNumberOfLines:0]; // for wordwrap
        
        [self addSubview:timeDisplay];
        
        
//        [self setCompletionText:@"All your base are belong to us."];
//        [self setDuration:5];
//        [self start];
    }
    return self;
}

-(void) setFromCardOptions:(NSDictionary*)options
{
    NSLog(@"creating: %@", [options objectForKey:@"durationType"]);
    
    
    if([[options objectForKey:@"durationType"] isEqualToString:@"turns"]){
        isTurnBased = YES;
        turnDuration = [[options objectForKey:@"duration"] integerValue];
    } else { // card is time-based
        isTurnBased = NO;
        timeDuration = [[options objectForKey:@"duration"] integerValue];
    }
    
    [self setCompletionText:[options objectForKey:@"completionText"]];

}


-(void) setDuration:(int)duration
{
    if(isTurnBased){
        turnDuration = duration;
        timeDisplay.text = [[NSString alloc] initWithFormat:@"%i", turnDuration];
    } else{
        timeDuration = duration;
        timeDisplay.text = [[NSString alloc] initWithFormat:@"%.02f",timeDuration];
    }
    [self setNeedsDisplay];
}

-(void) start;
{
    NSLog(@"start: %i", isTurnBased);
    if(isTurnBased){
        timeStartedAt = [NSDate date];
    } else{
        NSLog(@"card duration: %i", [_cards count]);
        turnStartedAt = [_cards count];
    }
}

-(void) checkExpiration:(NSTimer*)timer{
    
    if(isTurnBased){
        int elapsedTurns = [_cards count] - turnStartedAt;
        if(elapsedTurns == turnDuration){
            [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 12.0f]];
            timeDisplay.text = self.completionText;
            [timer invalidate];

        } else {
            timeDisplay.text = [[NSString alloc] initWithFormat:@"%i", turnDuration - elapsedTurns];
        }
        
    } else { // time-based
        NSDate* nowDate =[NSDate date];
        
        if([nowDate timeIntervalSinceDate:timeStartedAt] > timeDuration){
            [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 12.0f]];
            timeDisplay.text = self.completionText;
            [timer invalidate];
            
        } else {
            timeDisplay.text = [[NSString alloc] initWithFormat:@"%.02f",timeDuration - [nowDate timeIntervalSinceDate:timeStartedAt]];
        }

        
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
