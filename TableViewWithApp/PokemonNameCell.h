//
//  PokemonNameCell.h
//  TableViewWithApp
//
//  Created by Kevin Remigio on 3/29/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokemonNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
- (IBAction)incrementButton:(id)sender;
- (IBAction)decrementButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
