//
//  EntryViewController.m
//  TableViewWithApp
//
//  Created by Kevin Remigio on 4/20/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController () {
    NSDictionary *jsonDictionary;
    
    NSString *hp;
    NSString *attack;
    NSString *defense;
    NSString *specialAttack;
    NSString *specialDefense;
    NSString *speed;
    
    NSString *stats;
    

}

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pokemonInfoLabel.text = [NSString stringWithFormat:@"%@", self.pokeInfo];
    [self downloadPokemonWithName:self.pokeInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)downloadPokemonWithName:(NSString*)name {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://pokeapi.co/api/v1/pokemon/%@/",name]];
    NSURLSession *session =  [NSURLSession sharedSession];
    NSLog(@"%@", url);
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSHTTPURLResponse *resp = (NSHTTPURLResponse*) response;
            if (resp.statusCode == 200) {
                NSError *errorJSON;
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJSON];
                //NSLog(@"%@", dataDictionary);
                if (!errorJSON) {
                    //This is where the magic happens
                    jsonDictionary = [[NSDictionary alloc] initWithDictionary:dataDictionary];
                    
                    //nextURL = [jsonDictionary objectForKey:@"next"];
                    
                    //
                    NSLog(@"%@", jsonDictionary);
                    
                    for (NSDictionary *dict in [jsonDictionary objectForKey:@"results"]) {
                        NSString *pokemonName = [dict objectForKey:@"name"];
                        //                        NSLog(@"%@",pokemonName);
                        //[myPokemonArray addObject:pokemonName];
                        //shouldICheckScroll = YES;
                    }
                    attack = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"attack"]];
                    defense = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"defense"]];
                    speed = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"speed"]];
                    hp = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"hp"]];
                    specialAttack = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"sp_atk"]];
                    specialDefense = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"sp_def"]];
                    stats = [NSString stringWithFormat:@"HP: %@ ATTACK: %@ Defense: %@ Special Attack: %@ Special Defense: %@ Speed: %@",hp,attack,defense,specialAttack,specialDefense,speed];
                    NSLog(@"%@",stats);
                    [self performSelectorOnMainThread:@selector(printStats) withObject:nil waitUntilDone:YES];
                    //NSLog(@"%@", jsonDictionary);
                } else {
                    //alert error with json data
                    [self brokenJSONDataAlert];
                }
            } else {
                //alert status code not 200
                [self brokenWebPageAlert];
            }
        } else {
            //alert error with the session
            [self brokenSessionAlert];
        }
        

    }];
    [dataTask resume];

}
-(void)printStats {
    //NSLog(@"%@", jsonDictionary);
    self.pokemonStats.text = [NSString stringWithFormat:@"%@", stats];
}
-(void) brokenJSONDataAlert {
    NSLog(@"Broken JSON!");
}
-(void) brokenWebPageAlert {
    NSLog(@"Broken Webpage!");
}
-(void) brokenSessionAlert {
    NSLog(@"Broken Session!");
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
