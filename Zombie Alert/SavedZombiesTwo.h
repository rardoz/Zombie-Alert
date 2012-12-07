//
//  SavedZombiesTwo.h
//  Zombie Alert
//
//  Created by Robert on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedZombiesTwo : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_bugs;
 


 //   FourthViewController *ivControllerToolbar;
   // FourthViewController *ivControllerCell;
    IBOutlet UITableView *mytable;
}

@property (retain) NSMutableArray *bugs;


-(void)addTapped:(id)sender;
@end
