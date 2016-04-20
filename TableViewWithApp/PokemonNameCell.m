//
//  PokemonNameCell.m
//  TableViewWithApp
//
//  Created by Kevin Remigio on 3/29/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "PokemonNameCell.h"

@implementation PokemonNameCell
- (IBAction)testButtonPressed:(id)sender {
    NSLog(@"%@",self.pokemonNameLabel.text);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)incrementButton:(UIButton*)sender {
    int count = [self.countLabel.text intValue];
    self.countLabel.text = [NSString stringWithFormat:@"%d", ++count];
    if (sender.tag == 0) {
        NSLog(@"Incremented %@",self.pokemonNameLabel.text);
    }
    
    
    
}

- (IBAction)decrementButton:(id)sender {
    int count = [self.countLabel.text intValue];
    self.countLabel.text = [NSString stringWithFormat:@"%d", --count];
    NSLog(@"Decremented %@",self.pokemonNameLabel.text);
}
@end
