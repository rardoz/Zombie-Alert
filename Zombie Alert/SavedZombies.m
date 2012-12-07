//
//  SavedZombies.m
//  Zombie Alert
//
//  Created by Robert on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SavedZombies.h"
#import "SavedZombieData.h"
#import "StoryView.h"
@interface SavedZombies ()

@end

@implementation SavedZombies

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
    

}

-(IBAction)edit:(id)sender{
    NSLog(@"This should edit the table.");
    [self adddatatolist];
    
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSInteger myInt = [prefs integerForKey:@"creatplist"];
        
    
    if (myInt == 1) {
        NSLog(@"there is a plist so no need to creat one.");
        [self loadstuff];
        //[self createplist];
    } else {
        NSLog(@"There is no plist.");
        [self createplist];
        
         [prefs setInteger: 1 forKey:@"creatplist"];
    }
    
             
        
    
        [prefs synchronize];
        

    // Do any additional setup after loading the view from its nib.
}



-(void)loadstuff{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    path = [documentsDirectory stringByAppendingPathComponent:@"savedzombies.plist"]; 
    NSLog(@"this is where my list is %@", documentsDirectory);
    data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSLog(@"THIS IS MY ESSENTIAL LOADED DATA COUNT %i", data.count);
    zombiearray = [[NSMutableArray alloc] init];
    savedzombies = [[NSMutableDictionary alloc] init];
    for ( int i = 0; i < [data count]; i++ )    {
        
        savedzombies = [data objectForKey:[NSString stringWithFormat:@"%i", i]];
        
        if (savedzombies) {
            NSString *na = [NSString stringWithFormat:@"%@", [savedzombies objectForKey:@"name"]];
            NSLog(@" %@", na);
            doc = [SavedZombieData alloc];
            doc.name = na;
            [zombiearray addObject:doc];
            [doc release];        }
        
    }
    
[zombietbl reloadData];
    
}
-(void)adddatatolist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    path = [documentsDirectory stringByAppendingPathComponent:@"savedzombies.plist"]; 
    NSMutableDictionary *mydick= [[NSMutableDictionary alloc] init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:@"zombieurl"];
    
    NSLog(@"there are no items in the count!");
    
    NSLog(@"my zombie url better not be dull %@", myString);
    if (myString == NULL) {
        NSLog(@"its null so do nothing");
          myString = @"http://www.heliumdc.com";
        [mydick setObject:myString forKey:@"name"];
        
      
        
        [data setObject:mydick forKey:[NSString stringWithFormat:@"%i",[data count]]];
        [mydick release];
        [data writeToFile: path atomically:YES];

    } else {
        
     
        [mydick setObject:myString forKey:@"name"];
        
        myString = @"http://www.heliumdc.com";
        
        [data setObject:mydick forKey:[NSString stringWithFormat:@"%i",[data count]]];
        [mydick release];
        [data writeToFile: path atomically:YES];
    }
    [self loadstuff];
}
-(void)deleter{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSLog(@"got path");
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
      NSLog(@"got doc dir");
    path = [documentsDirectory stringByAppendingPathComponent:@"savedzombies.plist"]; 
    data = NULL;
    
     //  data = [NSDictionary dictionaryWithObject:zombiearray forKey:@"name"];
   
    for ( int i = 0; i < [data count]; i++ )    {
        /*savedzombies = [data objectForKey:[NSString stringWithFormat:@"%i", i]];
        
        if (savedzombies) {
            NSString *na = [NSString stringWithFormat:@"%@", [savedzombies objectForKey:@"name"]];
            NSLog(@" %@", na);
            SavedZombieData *zombiedatastuff = [SavedZombieData alloc];
            zombiedatastuff.name = na;
            [zombiearray addObject:zombiedatastuff];
            [zombiedatastuff release];  
        
        */
        
        data = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@", [zombiearray objectAtIndex:i]] forKey:[NSString stringWithFormat:@"%i", [data count]]];
        NSLog(@"testimng: %@", [zombiearray objectAtIndex:i]);
    } 
   
    //[data setObject:countriesToLiveInDict forKey:[NSString stringWithFormat:@"%i",[data count]]];
    //[mydick release];
    [data writeToFile: path atomically:YES];

    NSLog(@"wrote to file");
    [self loadstuff];

    
}
- (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array 
{
    id objectInstance;
    //NSUInteger indexKey = 0;
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (objectInstance in array)
        [mutableDictionary setObject:objectInstance forKey:@"name"];
    
        
        return (NSDictionary *)[mutableDictionary autorelease];
}
-(void)createplist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
   path = [documentsDirectory stringByAppendingPathComponent:@"savedzombies.plist"]; 
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) 
    {
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"savedzombies.plist"] ];
    }
    
        
    if ([fileManager fileExistsAtPath: path]) 
    {
        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
      
       // [self loaddatafromlist];
        NSLog(@"if for some reason this isn't working first check the thing above this!");
       
    }
    else
    {
        // If the file doesn’t exist, create an empty dictionary
        data = [[NSMutableDictionary alloc] init];
        [self adddatatolist];
        
    }
    
    //To insert the data into the plist
 
        
    
    //To reterive the data from the plist
   
}

     






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [zombiearray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    if (cell !=nil && [zombiearray count] > 0) {
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
        for (UIView *subview in subviews) {
            [subview removeFromSuperview];
        }
        [subviews release];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    doc = [zombiearray objectAtIndex:indexPath.row];
    UILabel *nametxt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 236, 20)];
    nametxt.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    nametxt.text = [NSString stringWithFormat:@"%@", doc.name];
    nametxt.textColor = [UIColor blackColor];
    nametxt.backgroundColor = [UIColor clearColor];
    nametxt.userInteractionEnabled = NO;
    [cell.contentView addSubview:nametxt];
    [nametxt release];
    // Configure the cell...

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


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source

   
     
     [tableView reloadData];


 //    [self deleter];
     
     }
 }   

 

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    doc = [zombiearray objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:doc.name forKey:@"lastsavedzambiename"];
    [defaults synchronize];
    StoryView   *zambie2 = [[StoryView alloc] initWithNibName:@"StoryView" bundle:nil];
    [self presentViewController:zambie2 animated:YES completion:NULL];
    [zambie2 release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
