//
//  EntryViewController.h
//  TableViewWithApp
//
//  Created by Kevin Remigio on 4/20/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryViewController : UIViewController

@property (nonatomic) NSString *pokeInfo;
@property (weak, nonatomic) IBOutlet UILabel *pokemonInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonStats;

@end
