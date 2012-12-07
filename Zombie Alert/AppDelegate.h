//
//  AppDelegate.h
//  Zombie Alert
//
//  Created by Robert on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "DataSet.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {

    Facebook *facebook;
    DataSet *apiData;
    NSMutableDictionary *userPermissions;

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, retain) Facebook *facebook;

@property (nonatomic, retain) DataSet *apiData;

@property (nonatomic, retain) NSMutableDictionary *userPermissions;

@end
