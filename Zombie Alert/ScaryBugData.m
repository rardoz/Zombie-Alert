//
//  ScaryBugData.m
//  ScaryBugs
//
//  Created by Ray Wenderlich on 8/24/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData
@synthesize title = _title;

@synthesize phone = _phone;
@synthesize location = _location;
@synthesize features = _features;
@synthesize progress= _progress;
@synthesize notes = _notes;
- (id)initWithTitle:(NSString*)title initWithPhone:(NSString*)phone initWithLocation:(NSString*)location initWithFeatures:(NSString*)features initWithProgress:(NSString *)progress initWithNotes:(NSString *)notes; {
    if ((self = [super init])) {
        _title = [title copy];
   
        _phone = [phone copy];
        _location = [location copy];
        _features = [features copy];;
        _progress = [progress copy];
        _notes = [notes copy];
    }
    return self;
}
- (void)dealloc {
       [_title release];
    _title = nil;    
    [super dealloc];
}

#pragma mark NSCoding

#define kTitleKey       @"Title"
#define kPhoneKey       @"Phone"
#define kLocationKey    @"Location"
#define kFeaturesKey    @"Features"
#define KProgressKey    @"Progress"
#define KNotesKey       @"Notes"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeObject:_phone forKey:kPhoneKey];
    [encoder encodeObject:_location forKey:kLocationKey];
    [encoder encodeObject:_features forKey:kFeaturesKey];
    [encoder encodeObject:_progress forKey:KProgressKey];
    [encoder encodeObject:_notes forKey:KNotesKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    NSString *phone = [decoder decodeObjectForKey:kPhoneKey];
    
    NSString *location = [decoder decodeObjectForKey:kLocationKey];
    NSString *features = [decoder decodeObjectForKey:kFeaturesKey];
    NSString *progress = [decoder decodeObjectForKey:KProgressKey];
    NSString *notes = [decoder decodeObjectForKey:KNotesKey];
      return [self initWithTitle:title initWithPhone:phone initWithLocation:location initWithFeatures:features initWithProgress:progress initWithNotes:notes];
 
    
}

@end
