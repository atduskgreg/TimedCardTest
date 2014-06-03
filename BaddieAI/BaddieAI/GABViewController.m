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
    
    int moveDestination = 3;
    
    NSLog(@"to move from %i to %i, go to: %i", heroLocation, moveDestination, [self nextTileFrom:heroLocation toTile:moveDestination]);

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

-(void) executeBaddieAI:(int)tileNum
{
    NSMutableDictionary* tile = tiles[tileNum];
    
    NSMutableDictionary* baddestTile = [self tileWithMostBaddies];
    
    // while there are greater than 0 baddies on the tile
    if([[tile objectForKey:@"baddies"] intValue] > 0){
    // if there are more baddies on another tile than my tile
        if(![tile isEqual:baddestTile]){
            if([[tile objectForKey:@"baddies"] intValue]  < [[baddestTile objectForKey:@"baddies"] intValue]){
                //  move one tile towards the tile with the highest number of baddies
                
                
                
            } else { // if I'm tied for highest
                
                //   whichever tile is closest to the hero sends baddies
            }
            
        }
    
    }
    
    // if my move would put me onto the hero's square
    //  do something else instead
}

-(int) nextTileFrom:(int)fromTile toTile:(int)toTile
{
    int result = fromTile;

    NSArray* rows = @[@0,@0,@1,@1,@2,@2];
    NSArray* cols = @[@0, @1, @0, @1, @0, @1];
    
    NSInteger* fromCol = [cols[fromTile] intValue];
    NSInteger* fromRow = [rows[fromTile] intValue];
    
    NSInteger* toCol = [cols[toTile] intValue];
    NSInteger* toRow = [rows[toTile] intValue];
    
    
    if(fromCol == toCol){
        // if they're in the same col they must be in different rows
        if(fromRow > toRow){
            // move up by 1 row
            result = fromTile - 2;
        } else {
            // move down by 1 row
            result = fromTile + 2;
        }
        
    } else {
        
        if(fromRow == toRow){ // different cols but the same row
            // we just move into the other row
            if(fromCol == 0){
                result = fromTile + 1;
            } else {
                result = fromTile - 1;
            }

        } else { // different cols and different rows
            // randomly decide whether to move row or column first
            if(arc4random() % 2 == 0){
                if(fromCol == 0){
                    result = fromTile + 1;
                } else {
                    result = fromTile - 1;
                }
                
            } else {
                if(fromRow > toRow){
                    // move up by 1 row
                    result = fromTile - 2;
                } else {
                    // move down by 1 row
                    result = fromTile + 2;
                }
                
            }
            
        }
    }
    
//    if(fromTile % 2){ // left column
//        if(toTile % 2){ // same column
//            if(fromTile > toTile){
//                result = fromTile - 2;
//            } else {
//                result = toTile + 2;
//            }
//        } else { // different column
//        
//        }
//    
//    } else { // right column
//        if(toTile % 2){ // different column
//            
//        } else { // same column
//            if(fromTile > toTile){
//                result = fromTile - 2;
//            } else {
//                result = toTile + 2;
//            }
//        }
//    }
    
    return result;
}

-(NSMutableDictionary*) tileWithMostBaddies
{
    NSMutableDictionary* result;
    
    int maxBaddies = 0;
    
    for(int i =0; i < [tiles count]; i++){
        NSMutableDictionary* tile = tiles[i];
        int tileBaddies = [[tile objectForKey:@"baddies"] intValue];
        if(tileBaddies >= maxBaddies){
            maxBaddies = tileBaddies;
            result = tile;
        }
    }
    
    return result;
}

-(void) moveBaddieFromTile:(int)fromTile toTile:(int)toTile
{
    NSMutableDictionary* fTile = tiles[fromTile];
    NSMutableDictionary* tTile = tiles[toTile];
    
    int fromBefore = [[fTile objectForKey:@"baddies"] intValue];
    int toBefore = [[tTile objectForKey:@"baddies"] intValue];
    
    if(fromBefore > 0){
        [fTile setObject:[NSNumber numberWithInt:(fromBefore-1)] forKey:@"baddies"];
        [tTile setObject:[NSNumber numberWithInt:(toBefore+1)] forKey:@"baddies"];
        
        NSLog(@"move 1 baddie from: %i to: %i", fromTile+1, toTile+1);
    }
}

+(BOOL) tile:(int)tileNum isNeighborOf:(int)neighborNum
{
    BOOL result = NO;
    
    if(tileNum == 1){
        if(neighborNum == 2 || neighborNum == 3){
            result = YES;
        }
    }
    if(tileNum == 2){
        if(neighborNum == 1 || neighborNum == 4){
            result = YES;
        }
    }
    if(tileNum == 3){
        if(neighborNum == 1 || neighborNum == 4){
            result = YES;
        }
    }
    if(tileNum == 4){
        if(neighborNum == 2 || neighborNum == 3){
            result = YES;
        }
    }
    if(tileNum == 5){
        if(neighborNum == 3 || neighborNum == 6){
            result = YES;
        }
    }
    if(tileNum == 6){
        if(neighborNum == 5 || neighborNum == 4){
            result = YES;
        }
    }
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
