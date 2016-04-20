//
//  EntryViewController.m
//  TableViewWithApp
//
//  Created by Kevin Remigio on 4/20/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pokemonInfoLabel.text = [NSString stringWithFormat:@"%@", self.pokeInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
