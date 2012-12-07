#import <Foundation/Foundation.h>

@interface ScaryBugDatabase : NSObject {

}

+ (NSMutableArray *)loadScaryBugDocs;
+ (NSString *)nextScaryBugDocPath;

@end
