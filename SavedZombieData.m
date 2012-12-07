//
//  SavedZombieData.m
//  Zombie Alert
//
//  Created by Robert on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SavedZombieData.h"

@implementation SavedZombieData
@synthesize name;
- (void) dealloc {
	NSLog(@"remvoing all this beutiful info!");
    [name release];
    [super dealloc];
}
-(id)copyWithZone:(NSZone *)zone
{
    SavedZombieData *obj = [[[self class] alloc] init];
    obj.name = self.name;
    return obj;
}
@end