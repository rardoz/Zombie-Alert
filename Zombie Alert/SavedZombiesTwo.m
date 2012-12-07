//
//  SavedZombiesTwo.m
//  Zombie Alert
//
//  Created by Robert on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SavedZombiesTwo.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"
#import "ScaryBugDatabase.h"
#import "StoryView.h"
@interface SavedZombiesTwo ()

@end

@implementation SavedZombiesTwo
@synthesize bugs = _bugs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)addTapped:(id)sender {
    ScaryBugDoc *newDoc = [[[ScaryBugDoc alloc] initWithTitle:@"New Contact" initWithPhone:nil initWithLocation:nil initWithFeatures:nil initWithProgress:nil initWithNotes:nil thumbImage:nil fullImage:nil] autorelease];
    [_bugs addObject:newDoc];
    NSLog(@"adding something");
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bugs.count-1 inSection:0];
   // NSArray *indexPaths = [NSArray arrayWithObject:indexPath];    
  //  [mytable insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    [mytable reloadData];
  //[mytable.self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
  // [self tableView:mytable.self didSelectRowAtIndexPath:indexPath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       // Do any additional setup after loading the view from its nib.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
      	
    
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bugs.count;
    NSLog(@"bug count is %i", _bugs.count);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    ScaryBugDoc *doc = [_bugs objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = doc.data.title;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.imageView.image = doc.thumbImage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (editingStyle == UITableViewCellEditingStyleDelete) {  
        ScaryBugDoc *doc = [_bugs objectAtIndex:indexPath.row];
        [doc deleteDoc];
        [_bugs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    /*if (_editBugViewController == nil) {
        self.editBugViewController = [[[EditBugViewController alloc] initWithNibName:@"EditBugViewController" bundle:[NSBundle mainBundle]] autorelease];        
    }*/
    //ScaryBugDoc *doc = [_bugs objectAtIndex:indexPath.row];
    //_editBugViewController.bugDoc = doc;
  //  [self.navigationController pushViewController:_editBugViewController animated:YES]; 
    
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
