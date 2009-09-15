// DaumBook Controller For Plugins

#import <Cocoa/Cocoa.h>

// Application Controller 
@interface DaumBookControllerForPlugins : NSObject
- (NSManagedObject *)selectedEntry;
@end


//The method that the delgate implements to be told about search results
@interface NSObject (DelegateMethod) 
- (void)searchReturnedNumberOfResults:(int)numberOfResults sender:(id)sender;
@end


@protocol PediaPluginMandatory
+ (id)plugin;
@end


@interface NSObject (PediaPluginOptional)
- (void)setController:(DaumBookControllerForPlugins *)aController;
- (NSArray *)menuCommandFor:(NSMutableArray *)entries;

- (void)searchFor:(NSDictionary *)searchDict sender:(id)sender;
- (NSArray *)resultsTitles;
- (NSDictionary *)resultNumber:(int)number;
@end



//Extensions methods for NSString to help parse information
@interface NSString (NSStringExtensions)
//Returns the first string that occurs between the given strings or nil if none do
- (NSString *)stringBetween:(NSString *)startString and:(NSString *)endString;
	// Same as above but you can move the search to start at a given string, instead of the beginning
- (NSString *)stringBetween:(NSString *)startString and:(NSString *)endString startingFrom:(NSString *)primeString;
	// Return an array of all the strings that occur between the given strings or nil if none do
- (NSArray *)stringsBetween:(NSString *)startString and:(NSString *)endString;

- (BOOL)isNotEmpty;
@end
