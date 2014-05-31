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
        
        
        self.userInteractionEnabled = YES; // for swipe detection
        
        UISwipeGestureRecognizer * swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUp];
        UISwipeGestureRecognizer * swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeDown];
        UISwipeGestureRecognizer * swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        
        
        
        timeDisplay = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-2)];
        [timeDisplay setTextColor:[UIColor blackColor]];
        [timeDisplay setBackgroundColor:[UIColor clearColor]];
        [timeDisplay setFont:[UIFont fontWithName: @"HelveticaNeue-Light" size: 50.0f]];
        [timeDisplay setNumberOfLines:0]; // for wordwrap
        
        [self addSubview:timeDisplay];
        
    }
    return self;
}

-(void)dismiss:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [UIView beginAnimations:@"SlideOff" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2f];
    
    int newX = self.frame.origin.x;
    int newY = self.frame.origin.y;
    // amimate off
    if(gestureRecognizer.direction == UISwipeGestureRecognizerDirectionDown){
        newY = 1000;
    }
    if(gestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp){
        newY = -1000;
    }
    if(gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        newX = -2000;
    }

    if(gestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
        newX = 2000;
    }
    
    self.frame = CGRectMake(newX, newY, cardWidth, cardHeight);
    
    [UIView commitAnimations];
    
    [[[self cardController] cards] removeObject:self];
    [[self cardController] updateCardPositions:NO];
    // animate array into correct positions
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
        turnStartedAt = [[self cardController] turn];
    } else{
        timeStartedAt = [NSDate date];

    }
}

-(void) checkExpiration:(NSTimer*)timer{
    
    if(isTurnBased){
        int elapsedTurns = [[self cardController] turn] - turnStartedAt;
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
