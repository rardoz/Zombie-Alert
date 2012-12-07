//
//  ScaryBugDoc.h
//  ScaryBugs
//
//  Created by Ray Wenderlich on 8/24/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaryBugData;

@interface ScaryBugDoc : NSObject {
    ScaryBugData *_data;
    UIImage *_thumbImage;
    UIImage *_fullImage;
    
    NSString *_docPath;    
}

@property (readwrite, nonatomic, retain) ScaryBugData *data;
@property (readwrite, nonatomic, retain) UIImage *thumbImage;
;
@property (readwrite, nonatomic, retain) UIImage *fullImage;
@property (copy) NSString *docPath;

- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (id)initWithTitle:(NSString*)title initWithPhone:(NSString*)phone initWithLocation:(NSString*)location initWithFeatures:(NSString*)features initWithProgress:(NSString *)progress initWithNotes:(NSString *)notes thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;
//- (id)initWithPhone:(NSString*)phone;
//- (id)initWithLocation:(NSString*)location;
//- (id)initWithFeatures:(NSString*)features;
//- (id)initWithProgress:(NSString*)progress;
//- (id)initWithNotes:(NSString*)notes;
- (void)saveData;
- (void)saveImages;
- (void)deleteDoc;

@end
