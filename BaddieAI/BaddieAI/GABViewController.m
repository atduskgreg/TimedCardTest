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
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray* tileButtons = @[buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix];
    
    NSMutableArray* colors = [[NSMutableArray alloc] initWithArray:@[@"red", @"red", @"green", @"green", @"blue", @"blue"]];
    
    for(int i = 0; i < 6; i++){
        int colorIndex = arc4random() % [colors count];
        
        NSString* selectedColor = [colors objectAtIndex:colorIndex];
        
        if([selectedColor isEqualToString:@"red"]){
            UIButton* button = [tileButtons objectAtIndex:i];
            button.backgroundColor = [UIColor redColor];
        }
        
        if([selectedColor isEqualToString:@"green"]){
            UIButton* button = [tileButtons objectAtIndex:i];
            button.backgroundColor = [UIColor greenColor];
        }
        
        if([selectedColor isEqualToString:@"blue"]){
            UIButton* button = [tileButtons objectAtIndex:i];
            button.backgroundColor = [UIColor blueColor];
        }
        
        
        
        [colors removeObjectAtIndex:colorIndex]; // without replacement
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
