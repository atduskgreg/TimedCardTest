//
//  GABViewController.h
//  BaddieAI
//
//  Created by Greg Borenstein on 6/3/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GABViewController : UIViewController{
    IBOutlet UIButton* buttonOne;
    IBOutlet UIButton* buttonTwo;
    IBOutlet UIButton* buttonThree;
    IBOutlet UIButton* buttonFour;
    IBOutlet UIButton* buttonFive;
    IBOutlet UIButton* buttonSix;
    
    IBOutlet UILabel* baddiesOne;
    IBOutlet UILabel* baddiesTwo;
    IBOutlet UILabel* baddiesThree;
    IBOutlet UILabel* baddiesFour;
    IBOutlet UILabel* baddiesFive;
    IBOutlet UILabel* baddiesSix;
    
    IBOutlet UILabel* baddieInstructions;
    NSMutableArray* tiles;
    NSArray* tileButtons;
    
    int heroLocation;
}

-(IBAction)rollBaddie:(id)sender;
-(IBAction)moveHero:(id)sender;

@end
