//
//  GABViewController.m
//  BaddieAI
//
//  Created by Greg Borenstein on 6/3/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABViewController.h"

@interface GABViewController ()

@end

@implementation GABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tiles = [[NSMutableArray alloc] init]; // array position is tile number
    
    tileButtons = @[buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix];
    NSArray* tileLabels = @[baddiesOne, baddiesTwo, baddiesThree, baddiesFour, baddiesFive, baddiesSix];
    
    NSMutableArray* colors = [[NSMutableArray alloc] initWithArray:@[@"red", @"red", @"green", @"green", @"blue", @"blue"]];
    
    for(int i = 0; i < 6; i++){
        int colorIndex = arc4random() % [colors count];
        
        NSString* selectedColor = [colors objectAtIndex:colorIndex];
        
        NSMutableDictionary* tile = [[NSMutableDictionary alloc] init];
        [tile setObject:[tileLabels objectAtIndex:i] forKey:@"countLabel"];
        
        [tile setObject:@0 forKey:@"baddies"];
        
        if([selectedColor isEqualToString:@"red"]){
            UIButton* button = [tileButtons objectAtIndex:i];
            button.backgroundColor = [UIColor redColor];
            [tile setObject:@"red" forKey:@"color"];
        }
        
        if([selectedColor isEqualToString:@"green"]){
            UIButton* button = [tileButtons objectAtIndex:i];
            button.backgroundColor = [UIColor greenColor];
            [tile setObject:@"green" forKey:@"color"];
        }
        
        if([selectedColor isEqualToString:@"blue"]){
            UIButton* button = [tileButtons objectAtIndex:i];
            button.backgroundColor = [UIColor blueColor];
            [tile setObject:@"blue" forKey:@"color"];
        }
        
        [colors removeObjectAtIndex:colorIndex]; // without replacement
        [tiles addObject:tile]; // array position is tile number
    }
}

-(IBAction)moveHero:(id)sender
{
    heroLocation = [tileButtons indexOfObject:sender];
    
    for(int i = 0; i < [tileButtons count]; i++){
        UIButton* tileButton = tileButtons[i];
        [tileButton.layer setBorderWidth:5.0f];

        [tileButton.layer setBorderColor:[[UIColor clearColor] CGColor]];
        [tileButton setNeedsDisplay];
    }
    
    UIButton* tileButton = tileButtons[heroLocation];
    [tileButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [tileButton setNeedsDisplay];

}

-(IBAction)rollBaddie:(id)sender
{
    int tileLocation = arc4random() % 6;
    NSMutableDictionary* tile = [tiles objectAtIndex:tileLocation];
    
    int newBaddies = [[tile objectForKey:@"baddies" ] intValue] + 1;
    [tile setObject:[NSNumber numberWithInt:newBaddies] forKey:@"baddies"];
    UILabel* tileLabel = [tile objectForKey:@"countLabel"];
    tileLabel.text = [NSString stringWithFormat:@"%i", newBaddies];
    
    baddieInstructions.text = [NSString stringWithFormat:@"Baddie arrives on TILE %i.", tileLocation+1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
