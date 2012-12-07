//
//  SandboxViewController.m
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//
 
#import "SandboxViewController.h"
#import <Twitter/Twitter.h>

@implementation SandboxViewController

/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
- (void)updateTableview
{
  // Update the row count used by tableview
  numberOfTwitterAccounts = [arrayOfAccounts count];

  // Reload the table with twitter account data
  [mainTableView reloadData];
}

/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
- (void)buttonPressed:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:NULL];
 }
-(void)gettheaccounts{
    // Is Twitter is accessible is there at least one account
    // setup on the device
 

}

/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
- (void)loadView 
{
  [self setView:[[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease]];
	[[self view] setBackgroundColor:[UIColor blackColor]];
  
  testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [testButton setFrame:CGRectMake(20, 30, 280, 40)];
	[testButton setTitle:@"Never mind..." forState:UIControlStateNormal];
  [testButton addTarget:self action:@selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];        
  [[self view] addSubview:testButton];

  //~~~~~~~~~~~~~~~~~~~~
  // Create table view
  //~~~~~~~~~~~~~~~~~~~~
  mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, 360) style: UITableViewStylePlain];
  [mainTableView setDelegate:self];
  [mainTableView setDataSource:self];
  [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

  numberOfTwitterAccounts = 0;
  
  [[self view] addSubview:mainTableView];
    [self gettheaccounts];
  
}

#pragma mark -
#pragma mark Table Management

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
  return 1;
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Set to number of twitter accounts
  return numberOfTwitterAccounts;
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCellStyle style =  UITableViewCellStyleDefault;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];

	if (!cell) 
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"tableCell"] autorelease];

  // View the array data 
  NSLog(@"Debug: %@", arrayOfAccounts);
  
  // Access the account data for each entry
  ACAccount *acct = [arrayOfAccounts objectAtIndex:indexPath.row];

  // Set the cell text to the username of the twitter account
  [[cell textLabel] setText:[acct username]];

	return cell;
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
      ACAccount *acct = [arrayOfAccounts objectAtIndex:indexPath.row];
    // This identifier can be used to look up the account using [ACAccountStore accountWithIdentifier:].

    NSLog(@"table cell pressed: %@",[acct username]);
    NSLog(@"table cell pressed: %@", [acct accountDescription]);
    NSLog(@"tablec cell Pressed: %@", [acct identifier]);
    NSDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:
                              [acct dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"properties"]]];
    NSString *tempUserID = [[tempDict objectForKey:@"properties"] objectForKey:@"user_id"];

    NSLog(@"this is my useride: %@", tempUserID);
    
    NSUserDefaults *prefs = [[NSUserDefaults alloc] init];
    
    [prefs setObject:tempUserID forKey:@"twitterid"];
    [prefs setObject:acct.username forKey:@"twittername"];
    [prefs setInteger:1 forKey:@"twitteron"];
    [prefs synchronize];
   
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}



/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
- (void)dealloc 
{
	[testButton release];
  [mainTableView release];

  if (arrayOfAccounts != nil)
    [arrayOfAccounts release];
  
  if (account != nil)
    [account release];
  
	[super dealloc];
}

@end
