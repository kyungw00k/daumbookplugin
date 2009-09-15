//
//  DaumBook.m

#import "DaumBook.h"
#import "Constants.h"

@interface DaumBook (private)
- (void)makeXMLDocument:(NSString *)HTMLSource;
- (NSString *)cleanHTMLEncoding:(NSString *)stringToClean;
- (NSString *)stringForPath:(NSString *)xp ofNode:(NSXMLNode *)n;
@end


@implementation DaumBook

- (void)searchFor:(NSDictionary *)searchDict sender:(id)sender{
	delegate = sender;
	pagenoOfPages = 0;
	resultOfPage = 0;
	totalCountOfItems = 0;

	NSMutableString *searchString = [NSMutableString string];
	
	if ([searchDict objectForKey:@"keyword"]) {
		[searchString setString:[searchDict objectForKey:@"keyword"]];
	} else if ([searchDict objectForKey:@"title"] != nil) {
		[searchString setString:[searchDict objectForKey:@"title"]];
	} else {
		[delegate searchReturnedNumberOfResults:0 sender:self];
		return;
	}
	[searchString replaceOccurrencesOfString:@" " withString:@"+" options:NSLiteralSearch range:NSMakeRange(0, [searchString length])];

	NSString *encodedString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	queryString = [[NSMutableString alloc] initWithFormat:@"http://apis.daum.net/search/book?q=%@&result=20&apikey=DAUM_SEARCH_DEMO_APIKEY",encodedString ];

	[self downloadWebPage:queryString];
}


- (void)downloadComplete:(NSString *)HTMLSource {

	[self makeXMLDocument:HTMLSource ];
	[delegate searchReturnedNumberOfResults:totalCountOfItems sender:self];
}


- (NSDictionary *)resultNumber:(int)number {
	if ( !resultsTitles ) {
		return nil;
	}
	
	NSMutableDictionary *returnData = [NSMutableDictionary dictionaryWithCapacity:10];

	if (number > totalCountOfItems) {
		NSLog(@"Error: DaumBook requested out of range: %d of %d", number, [resultsTitles count]);
		[returnData setObject:@"No data found on DaumBook" forKey:@"title"];
		return returnData;
	}
	
	// 현재 페이지안에 자료가 없으면 다운로드함
	NSURLRequest *theRequest = nil;
	NSString *HTMLSource = nil;
	
	if ( number > pagenoOfPages*resultOfPage-1 ) { 
		theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[queryString stringByAppendingFormat:@"&pageno=%d",pagenoOfPages+1]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];		
	} else if ( pagenoOfPages-1 && number < (pagenoOfPages-1)*resultOfPage ) {
		theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[queryString stringByAppendingFormat:@"&pageno=%d",pagenoOfPages-1]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];		
	}
	
	if ( theRequest != nil ) {
		HTMLSource = [[[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil] encoding:NSUTF8StringEncoding] autorelease];
		[self makeXMLDocument:HTMLSource];
	}

	// 페이지 정보 Index
	int currentItemIdx = (number%resultOfPage);
	
	NSString *url = [self stringForPath:@"link" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (url) {
		[returnData setObject:[self cleanHTMLEncoding:url] forKey:@"url"];
	}
	
	NSString *title = [self stringForPath:@"title" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (title) {
		[returnData setObject:[self cleanHTMLEncoding:title] forKey:@"title"];
	}
	
	NSString *imageUrl = [self stringForPath:@"cover_l_url" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	NSString *largeUrl = [[imageUrl stringByReplacingOccurrencesOfString:@"medium" withString:@"large"] stringByReplacingOccurrencesOfString:@"/m" withString:@"/l"];
	// NSString *xlargeUrl = [[imageUrl stringByReplacingOccurrencesOfString:@"medium" withString:@"xlarge"] stringByReplacingOccurrencesOfString:@"/m" withString:@"/x"];

	if (largeUrl) {
		[returnData setObject:largeUrl forKey:MKKeyEntryImageLocation];
	}
	
	NSString *description = [self stringForPath:@"description" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (description) {
		[returnData setObject:description forKey:MKKeyEntrySummary];
	}

	NSString *author = [self stringForPath:@"author" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (author) {
		[returnData setObject:author forKey:MKKeyBookAuthor];
	}
	
	NSString *translator = [self stringForPath:@"translator" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (translator) {
		[returnData setObject:translator forKey:MKKeyBookTranslator];
	}

	NSString *pub_nm = [self stringForPath:@"pub_nm" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (pub_nm) {
		[returnData setObject:pub_nm forKey:MKKeyBookPlacePublished];
	}

	NSString *pub_date = [self stringForPath:@"pub_date" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (pub_date) {
		[returnData setObject:pub_date forKey:MKKeyEntryRelease];
	}

	NSString *category = [self stringForPath:@"category" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (category) {
		[returnData setObject:category forKey:MKKeyEntryGenre];
	}

	NSString *isbn = [self stringForPath:@"isbn" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (isbn) {
		[returnData setObject:isbn forKey:MKKeyBookISBN];
	}

//	NSString *sale_yn = [self stringForPath:@"sale_yn" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
//	if (sale_yn) {
//		[returnData setObject:sale_yn forKey:MKKeyBookOnSale];
//	}

	NSString *placedAt= @"교보문고";
	if (placedAt) {
		[returnData setObject:placedAt forKey:MKKeyBookPlacedForSaleAt];
	}
	
	NSString *status_des = [self stringForPath:@"status_des" ofNode:[resultsTitles objectAtIndex:currentItemIdx]];
	if (status_des) {
		[returnData setObject:status_des forKey:MKKeyBookCondition];
	}

	NSString *list_price = [[self stringForPath:@"list_price" ofNode:[resultsTitles objectAtIndex:currentItemIdx]] stringByAppendingString:@"원"];
	if (list_price) {
		[returnData setObject:list_price forKey:MKKeyBookAskingPrice];
	}

	NSString *sale_price = [[self stringForPath:@"sale_price" ofNode:[resultsTitles objectAtIndex:currentItemIdx]] stringByAppendingFormat:@"원" ];
	if (sale_price) {
		[returnData setObject:sale_price forKey:MKKeyBookMarketPrice];
	}

	NSString *sale_price2 = [[self stringForPath:@"list_price" ofNode:[resultsTitles objectAtIndex:currentItemIdx]] stringByAppendingString:@"원"];
	if (sale_price2) {
		[returnData setObject:sale_price2 forKey:MKKeyEntryListPrice];
	}
	
	// Code from other plug-ins showing more complicated parse, the return here would be the last thing, but since for the DaumBook we don't want to keep parsing we put a a return here
	return returnData;
}

#pragma mark -
- (void)makeXMLDocument:(NSString *)HTMLSource {	
	if ( !HTMLSource ) {
		return ;
	}
	
	NSXMLDocument *resultsSet = [[NSXMLDocument alloc] initWithXMLString:HTMLSource options:NSXMLDocumentXMLKind error:nil];

	if ( [[resultsSet nodesForXPath:@"apierror" error:nil] count] > 0 ) { // ERROR NODE가 있으면,
		int errorCode = [[self stringForPath:@"code" ofNode:[[resultsSet nodesForXPath:@"apierror" error:nil] objectAtIndex:0]] intValue];
		NSString *errorMessage = [self stringForPath:@"message" ofNode:[[resultsSet nodesForXPath:@"apierror" error:nil] objectAtIndex:0]];
		int errorDcode = [[self stringForPath:@"dcode" ofNode:[[resultsSet nodesForXPath:@"apierror" error:nil] objectAtIndex:0]] intValue];
		NSString *errorDmessage = [self stringForPath:@"dmessage" ofNode:[[resultsSet nodesForXPath:@"apierror" error:nil] objectAtIndex:0]];

		NSAlert *errorAlert = [NSAlert alertWithMessageText:errorMessage defaultButton:@"OK" alternateButton:@"" otherButton:@"" informativeTextWithFormat:@"%@(%d|%d)",errorDmessage,errorCode,errorDcode];
		[errorAlert runModal];
		[resultsSet release];
		return ;
	}
	
	pagenoOfPages = [[self stringForPath:@"pageno" ofNode:[[resultsSet nodesForXPath:@"channel" error:nil] objectAtIndex:0]] intValue];
	resultOfPage = [[self stringForPath:@"result" ofNode:[[resultsSet nodesForXPath:@"channel" error:nil] objectAtIndex:0]] intValue];
	totalCountOfItems = [[self stringForPath:@"totalCount" ofNode:[[resultsSet nodesForXPath:@"channel" error:nil] objectAtIndex:0]] intValue];	

	[resultsTitles removeAllObjects];
	resultsTitles = [[resultsSet nodesForXPath:@"channel/item" error:nil] mutableCopy];
	[resultsSet release];
}

- (NSString *)cleanHTMLEncoding:(NSString *)stringToClean {
	
	NSMutableString *cleanString = [NSMutableString stringWithString:stringToClean];
		
	//Look for &#[anumber]; and change it to it's decimal value in UTF8
	NSScanner *searchScanner = [NSScanner scannerWithString:cleanString];	
	while (YES) {
		int tempInt = 0;
		[searchScanner scanUpToString:@"&#" intoString:nil];
		if ([searchScanner isAtEnd])
			break;
		[searchScanner setScanLocation:[searchScanner scanLocation] +2];
		[searchScanner scanInt:&tempInt];
		
		if (tempInt)
			[cleanString replaceOccurrencesOfString:[NSString stringWithFormat:@"&#%d;", tempInt] withString:[NSString stringWithFormat:@"%c", tempInt]  options:NSLiteralSearch range:NSMakeRange(0, [cleanString length])];
	}
	
	if (cleanString)
		return cleanString;
	else 
		return stringToClean;
}

- (NSString *)stringForPath:(NSString *)xp ofNode:(NSXMLNode *)n {
	NSError *error;
	NSArray *nodes = [n nodesForXPath:xp error:&error];
	
	if ( !nodes ) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return nil;
	}
	
	if ( [nodes count] == 0 ) {
		return nil;
	}
	
	NSString *withTags = [[nodes objectAtIndex:0] stringValue ]; // b 테그 제거 전
	return [[withTags stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""]; 
}

#pragma mark -
#pragma mark Getter


#pragma mark Init
+ (id)plugin;
{ 
    return [[[self alloc] init] autorelease];
}


- (id)init {
	if (self = [super init]) {
		resultsTitles = nil;		
		queryString = nil;
	}
	return self;
}


- (void)dealloc {
	[resultsTitles release];
	[queryString release];
	[super dealloc];
}




#pragma mark Connection Delegation
- (void)downloadWebPage:(NSString *)aWebPage {
		
	//Create request for http query
	NSURLRequest *httpRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:aWebPage] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
	
	theConnection = [[NSURLConnection alloc] initWithRequest:httpRequest delegate:self];
	
	if (theConnection) {
		receivedData = [[NSMutableData data] retain];
	} else {
		[delegate searchReturnedNumberOfResults:0 sender:self];
	}	
}


/* If there are any redirects this notification is sent and we reset the data to 0  */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//redirects and such
    [receivedData setLength:0];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    [receivedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    [receivedData release];
	receivedData = nil;
	
	[delegate searchReturnedNumberOfResults:0 sender:self];
}


-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
	return request;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//Turn recievedData into a  string try NSUTF encoding if that fails use Latin
	NSString *HTMLSource = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];	
	
	if (HTMLSource == nil) {
		HTMLSource = [[[NSString alloc] initWithData:receivedData encoding:NSISOLatin1StringEncoding] autorelease];
	}
	
    // release the connection, and the data object
    [connection release];
    [receivedData release];
	receivedData = nil;
	
	//All encodings failed return no results otherwise parse
	if (HTMLSource == nil) {
		[delegate searchReturnedNumberOfResults:0 sender:self];
	} else {
		[self downloadComplete:HTMLSource];
	}
	
}


@end
