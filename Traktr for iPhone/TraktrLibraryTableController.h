//
//  TraktrLibraryTableController.h
//  Traktr for iPhone
//
//  Created by Atharv Vaish on 8/23/13.
//  Copyright (c) 2013 Atharv Vaish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraktrLibraryTableController :
UITableViewController <NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSMutableData *libraryResponseData;
@property (strong, nonatomic) NSArray *libraryData;

typedef NS_ENUM(NSUInteger, LibrarySort) {
  watchProgress
};

- (void)populateLibraryWithShows:(BOOL)shows
                        withSort:(LibrarySort)sort
                         forUser:(NSString *)user;

@end
