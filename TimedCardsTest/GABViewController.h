//
//  GABViewController.h
//  TimedCardsTest
//
//  Created by Greg Borenstein on 5/30/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GABTimedCard.h"

@interface GABViewController : UIViewController{
    int cardWidth;
    int cardHeight;
    
    NSMutableArray* cards;
}

-(void) cardsDoneSliding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

@end
