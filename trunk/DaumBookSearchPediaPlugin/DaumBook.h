//
//  DaumBook.h

#import <Foundation/Foundation.h>
#import "DaumBookControllerForPlugins.h"


@interface DaumBook : NSObject {
	NSMutableArray *resultsTitles;	
	NSString *apiKey;
	NSString *queryString;
	
	int pagenoOfPages;
	int resultOfPage;
	int totalCountOfItems;
	
	id delegate;
	NSMutableData *receivedData;
	NSURLConnection *theConnection;
}

//helper Methods
- (void)downloadWebPage:(NSString *)aWebPage;
- (void)downloadComplete:(NSString *)HTMLSource;

@end
