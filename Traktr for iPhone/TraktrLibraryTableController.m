//
//  TraktrLibraryTableController.m
//  Traktr for iPhone
//
//  Created by Atharv Vaish on 8/23/13.
//  Copyright (c) 2013 Atharv Vaish. All rights reserved.
//

#import "TraktrLibraryTableController.h"

@interface TraktrLibraryTableController ()

@end

@implementation TraktrLibraryTableController

@synthesize libraryResponseData = _libraryResponseData;
@synthesize libraryData = _libraryData;

- (void)populateLibraryWithShows:(BOOL)shows
                        withSort:(LibrarySort)sort
                         forUser:(NSString *)user
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSString *apikey = @"";
  
  if (standardUserDefaults) {
    apikey = [standardUserDefaults objectForKey:@"apikey"];
  }
  
  NSURL *url = [NSURL URLWithString:
                [NSString
                 stringWithFormat:
                 @"http://api.trakt.tv/user/library/shows/watched.json/%@/%@",
                 apikey, user]];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"GET"];
  
  NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self];
  if (con) {
    self.libraryResponseData = [NSMutableData new];
  } else {
    NSLog(@"Connection Error");
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  [self.libraryResponseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  self.libraryData = [NSJSONSerialization
                      JSONObjectWithData:self.libraryResponseData
                      options:kNilOptions error:nil];
  
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  
  if (standardUserDefaults) {
    [standardUserDefaults setObject:self.libraryData
                             forKey:@"libraryData"];
    [standardUserDefaults synchronize];
  }
  
  [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  
  if (standardUserDefaults) {
    self.libraryData = [standardUserDefaults objectForKey:@"libraryData"];
  }
  
  [self.tableView reloadData];
  
  [self populateLibraryWithShows:true withSort:watchProgress forUser:@"atharv"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.libraryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"LibraryCell";
  UITableViewCell *cell = [tableView
                           dequeueReusableCellWithIdentifier:CellIdentifier
                           forIndexPath:indexPath];
  
  NSString *imageURL = [(NSDictionary *)[(NSDictionary *)self.libraryData
                                         [indexPath.row] objectForKey:@"images"]
                        objectForKey:@"poster"];
  
  cell.textLabel.text = [(NSDictionary *)self.libraryData[indexPath.row]
                         objectForKey:@"title"];
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
