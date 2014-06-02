//
//  GABTimedCard.m
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABTimedCard.h"
#import "GABViewController.h"


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
        cardWidth = 199;
        cardHeight = cardWidth*1.55;
        
        isComplete = NO;
        isDefeated = NO;
        self.userInteractionEnabled = YES; // for tap detection
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(stopTimer:)];
        [self addGestureRecognizer:singleFingerTap];
    
        timeDisplay = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height/2)];
        [timeDisplay setTextColor:[UIColor blackColor]];
        [timeDisplay setBackgroundColor:[UIColor clearColor]];
        [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 50.0f]];
        [timeDisplay setNumberOfLines:0]; // for wordwrap
        
        [self addSubview:timeDisplay];
        
        descriptionDisplay = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.size.height/4, frame.size.width, frame.size.height-2)];
        [descriptionDisplay setTextColor:[UIColor blackColor]];
        [descriptionDisplay setBackgroundColor:[UIColor clearColor]];
        [descriptionDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 30.0f]];
        [descriptionDisplay setNumberOfLines:0]; // for wordwrap
        
        [self addSubview:descriptionDisplay];
        
    }
    return self;
}

-(void) stopTimer:(UITapGestureRecognizer *)gestureRecognizer
{
    isDefeated = YES;

}

-(void) setFromCardOptions:(NSDictionary*)options
{
    if([[options objectForKey:@"durationType"] isEqualToString:@"turns"]){
        isTurnBased = YES;
        turnDuration = [[options objectForKey:@"duration"] integerValue];
    } else { // card is time-based
        isTurnBased = NO;
        timeDuration = [[options objectForKey:@"duration"] integerValue];
    }
    
    [self setCompletionText:[options objectForKey:@"completionText"]];
    [self setDescription:[options objectForKey:@"description"]];
    descriptionDisplay.text = _description;

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
    if(isTurnBased){
//        turnStartedAt = [[self cardController] turn];
    } else{
        timeStartedAt = [NSDate date];

    }
}

-(BOOL) complete
{
    return isComplete;
}

-(void) checkExpiration:(NSTimer*)timer{
    
    if(isTurnBased){
//        int elapsedTurns = [[self cardController] turn] - turnStartedAt;
//        if(elapsedTurns == turnDuration){
//            [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 12.0f]];
//            timeDisplay.text = self.completionText;
//            [timer invalidate];
//
//        } else {
//            timeDisplay.text = [[NSString alloc] initWithFormat:@"%i", turnDuration - elapsedTurns];
//        }
        
    } else { // time-based
        NSDate* nowDate =[NSDate date];
        
        if(isDefeated){
            [timer invalidate];

        } else {
        
            if([nowDate timeIntervalSinceDate:timeStartedAt] > timeDuration){
                [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 12.0f]];
                timeDisplay.text = self.completionText;
                [timer invalidate];
                isComplete = YES;
            
            }
            else {
                timeDisplay.text = [[NSString alloc] initWithFormat:@"%.02f",timeDuration - [nowDate timeIntervalSinceDate:timeStartedAt]];
            }
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
