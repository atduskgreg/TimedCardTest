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
    
    [baddieInstructions setNumberOfLines:0]; // for wordwrap
    
    colorScores = [[NSMutableDictionary alloc] init];
    
    [colorScores setObject:@0 forKey:@"red"];
    [colorScores setObject:@0 forKey:@"green"];
    [colorScores setObject:@0 forKey:@"blue"];
    
    redScoreLabel.backgroundColor = [UIColor redColor];
    greenScoreLabel.backgroundColor = [UIColor greenColor];
    blueScoreLabel.backgroundColor = [UIColor blueColor];
    
    redScore = 20;
    greenScore = 20;
    blueScore = 20;

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
    [self clearBaddiesFromTile:heroLocation];
    
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

-(void) clearBaddiesFromTile:(int)tileNum
{
    NSMutableDictionary* selectedTile = [tiles objectAtIndex:tileNum];
    [selectedTile setObject:[NSNumber numberWithInt:0] forKey:@"baddies"];
    UILabel* countLabel = [selectedTile objectForKey:@"countLabel"];
    countLabel.text = [NSString stringWithFormat:@"%i",[[selectedTile objectForKey:@"baddies"] intValue]];
//    [countLabel setNeedsDisplay];
}

-(IBAction)rollBaddie:(id)sender
{
    int tileLocation = arc4random() % 6;
    
    if(tileLocation != heroLocation){
    
        NSMutableDictionary* tile = [tiles objectAtIndex:tileLocation];
        int newBaddies = [[tile objectForKey:@"baddies" ] intValue] + 1;
        [tile setObject:[NSNumber numberWithInt:newBaddies] forKey:@"baddies"];
        [self applyDamage:newBaddies toColor:[tile objectForKey:@"color"]];
        
        
        UILabel* tileLabel = [tile objectForKey:@"countLabel"];
        tileLabel.text = [NSString stringWithFormat:@"%i", newBaddies];
        baddieInstructions.text = [NSString stringWithFormat:@"Baddie arrives on TILE %i. %@ takes %i damage.", tileLocation+1,[tile objectForKey:@"color"] ,newBaddies];

    } else {
        baddieInstructions.text = [NSString stringWithFormat:@"Baddie arrives on TILE %i. Biffed away by hero!", tileLocation+1];

    }
}

-(void) applyDamage:(int)damage toColor:(NSString*)color
{
    if([color isEqualToString:@"red"]){
        redScore = redScore - damage;
        redScoreLabel.text = [NSString stringWithFormat:@"%i", redScore];
    }
    
    if([color isEqualToString:@"green"]){
        greenScore = greenScore - damage;
        greenScoreLabel.text = [NSString stringWithFormat:@"%i", greenScore];

    }
    
    if([color isEqualToString:@"blue"]){
        blueScore = blueScore - damage;
        blueScoreLabel.text = [NSString stringWithFormat:@"%i", blueScore];

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
