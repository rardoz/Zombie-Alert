//
//  SavedZombies.h
//  Zombie Alert
//
//  Created by Robert on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SavedZombieData;
@interface SavedZombies : UIViewController  <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UIButton *donebtn;
    IBOutlet UIButton  *editbtn;
    IBOutlet UITableView *zombietbl;
    NSMutableDictionary *data;
    NSMutableArray *zombiearray;
    NSMutableDictionary *savedzombies;
    NSMutableDictionary *testdick;
    NSString *path;
    int delmode;
    SavedZombieData *doc;
}
//-(void)loaddatafromlist;
-(IBAction)back:(id)sender;
-(IBAction)edit:(id)sender;
-(void)createplist;
-(void)loadstuff;
-(void)deleter;
- (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array ;
@end
