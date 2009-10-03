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
	int receivedDataLength;
	
	id delegate;
	NSMutableData *receivedData;
	NSURLConnection *theConnection;
}

//helper Methods
- (void)downloadDataFromURL:(NSString *)urlString;
- (void)downloadComplete:(NSString *)HTMLSource;

@end
