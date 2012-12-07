//
//  ScaryBugData.h
//  ScaryBugs
//
//  Created by Ray Wenderlich on 8/24/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject <NSCoding> {
    NSString *_title;

    NSString *_phone;
    NSString *_location;
    NSString *_features;
    NSString *_progress;
    NSString *_notes;
    
}

@property (copy) NSString *title;
@property (copy) NSString *phone;
@property (copy) NSString *location;
@property (copy) NSString *features;
@property (copy) NSString *progress;
@property (copy) NSString *notes;


- (id)initWithTitle:(NSString*)title initWithPhone:(NSString*)phone initWithLocation:(NSString*)location initWithFeatures:(NSString*)features initWithProgress:(NSString *)progress initWithNotes:(NSString *)notes;

@end
