//
//  SandboxViewController.h
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

@interface SandboxViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	UIButton        *testButton;
  UITableView     *mainTableView;
  NSInteger       numberOfTwitterAccounts;
  ACAccountStore  *account;
  NSArray         *arrayOfAccounts;

}

@end

