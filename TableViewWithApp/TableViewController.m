//
//  TableViewController.m
//  TableViewWithApp
//
//  Created by Kevin Remigio on 3/29/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "TableViewController.h"
#import "PokemonNameCell.h"
#import "EntryViewController.h"
@interface TableViewController () {
    
    NSMutableArray *myPokemonArray;
    NSDictionary *jsonDictionary;
    NSString *nextURL;
    BOOL shouldICheckScroll;

}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //myPokemonArray = @[@"Caterpie", @"Jolteon", @"Dragonite"];
    myPokemonArray = [[NSMutableArray alloc]init];
    nextURL = @"http://pokeapi.co/api/v2/pokemon-species/";
    shouldICheckScroll = NO;
    [self performSelectorInBackground:@selector(downloadPokemons) withObject:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return myPokemonArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //PokemonNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //cell.pokemonNameLabel.text = [myPokemonArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [myPokemonArray objectAtIndex:indexPath.row];
    
//    if (cell == nil) {
//    
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//    }
//    UISwitch *switchObj = [[UISwitch alloc] initWithFrame:CGRectMake(1.0, 1.0, 20.0, 20.0)];
//    
//    switchObj.on = YES;
//    //[switchObj addTarget:self action:@selector(toggleSoundEffects:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
//    
//    cell.accessoryView = switchObj;
    
    //cell.incrementButton.tag = indexPath.row;
    
  //  cell.selected = [accessoriSelezionati containsObject:cell.];

    //[cell.incrementButton addTarget:self action:@selector(incrementButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Configure the cell...
//    cell.textLabel.text = [myPokemonArray objectAtIndex:indexPath.row];

    
    return cell;
}
//- (void)toggleSoundEffects:(id)sender {
//    [self.soundEffectsOn = [(UISwitch*)sender isOn];
//     [self reset]
//}

-(void) downloadPokemons {
    shouldICheckScroll = NO;
    
//    NSString *strURL =
    NSURL *url = [NSURL URLWithString:nextURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSHTTPURLResponse *resp = (NSHTTPURLResponse*) response;
            if (resp.statusCode == 200) {
                NSError *errorJSON;
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJSON];
                if (!errorJSON) {
                    //This is where the magic happens
                    jsonDictionary = [[NSDictionary alloc] initWithDictionary:dataDictionary];
                    
                    nextURL = [jsonDictionary objectForKey:@"next"];
                    NSLog(@"%@", nextURL);
                    for (NSDictionary *dict in [jsonDictionary objectForKey:@"results"]) {
                        NSString *pokemonName = [dict objectForKey:@"name"];
//                        NSLog(@"%@",pokemonName);
                        [myPokemonArray addObject:pokemonName];
                        shouldICheckScroll = YES;
                    }
                    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
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
    //nextURL = [jsonDictionary objectForKey:@"next"];
    

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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (shouldICheckScroll) {
        
        float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            [self performSelectorInBackground:@selector(downloadPokemons) withObject:nil];
            NSLog(@"Download More");
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            // Reflect selection in data model
        } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        // Reflect deselection in data model
    }

}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    EntryViewController *entry = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"moreInfo"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *pokemonName = [myPokemonArray objectAtIndex:indexPath.row];
        
        entry.pokeInfo = [NSString stringWithFormat:@"%@",pokemonName];
        
    }
    
}


@end
