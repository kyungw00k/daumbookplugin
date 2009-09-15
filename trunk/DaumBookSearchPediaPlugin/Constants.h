//
//  Constants.h


// http://bruji.com/howto/creating_templates/tags.html
// Key word that can be used for the details dictionary
// all program keywords

#pragma mark All

#define MKKeyEntryTitle @"title"
#define MKKeyEntryASIN @"asin"
#define MKKeyEntryDateAdded @"dateAdded"
#define MKKeyEntryMyRating @"myRating"
#define MKKeyEntryRelease @"releaseDate"
#define MKKeyEntryGenre @"genre"
#define MKKeyEntryCollection @"collectionID"
#define MKKeyEntryComments @"comments"
#define MKKeyEntryListPrice @"price"
#define MKKeyEntryPaidPrice @"PaidPrice"
#define MKKeyEntryPurcahsedAt @"purcahsedAt"
#define MKKeyEntryPurchasedOn @"purchasedOn"
#define MKKeyEntryBorrowedBy @"borrowedBy"
#define MKKeyEntryBorrowedOn @"borrowedOn"
#define MKKeyEntryDueDate @"dueDate"
#define MKKeyEntrySummary @"summary"
#define MKKeyEntryCustomOne @"custom1"
#define MKKeyEntryCustomTwo @"custom2"
#define MKKeyEntryCustomThree @"custom3"
#define MKKeyEntryCustomFour @"custom4"
#define MKKeyEntryAwards @"awards"
//A URL starting with http: that leads to the details page
#define MKKeyEntryProductURL @"url"


#pragma mark DVDpedia

#define MKKeyDVDDirector @"director"
#define MKKeyDVDStudio @"studio"
#define MKKeyDVDTheatrical @"theatrical"
#define MKKeyDVDDuration @"duration"
#define MKKeyDVDStarring @"starring"
#define MKKeyDVDViewerRating @"rating"
#define MKKeyDVDAspectRatio @"aspectRatio"
#define MKKeyDVDSound @"sound"
#define MKKeyDVDVideoFormat @"videoFormat"
#define MKKeyDVDRated @"rated"
#define MKKeyDVDRegion @"region"
#define MKKeyDVDDiscs @"discs"
#define MKKeyDVDUPC @"upc"
#define MKKeyDVDWriter @"writer"
#define MKKeyDVDProducer @"producer"
#define MKKeyDVDLanguage @"languages"
#define MKKeyDVDSubtitles @"subtitles"
#define MKKeyDVDPictureFormat @"pictureFormat"
#define MKKeyDVDLastSeen @"lastSeen"
#define MKKeyDVDMedia @"media"
#define MKKeyDVDIMDB @"imdb"
#define MKKeyDVDCountry @"country"
#define MKKeyDVDFeatures @"features"


#pragma mark Bookpedia

#define MKKeyBookAuthor @"author"
#define MKKeyBookAskingPrice @"askingPrice"
#define MKKeyBookBuyerName @"buyerName"
#define MKKeyBookBuyerEmail @"buyerEmail"
#define MKKeyBookBuyerAddress @"buyerAddress"
#define MKKeyBookReaderRating @"rating"
#define MKKeyBookChildrenReadingLevel @"children"
#define MKKeyBookCondition @"condition"
#define MKKeyBookDewey @"dewey"
#define MKKeyBookDimensions @"dimensions"
#define MKKeyBookEdition @"edition"
#define MKKeyBookEditor @"editor"
#define MKKeyBookFormat @"format"
#define MKKeyBookGift @"gift"
#define MKKeyBookIllustrator @"illustrator"
#define MKKeyBookLastRead @"lastRead"
#define MKKeyBookLCCN @"lccn"
#define MKKeyBookLocation @"location"
#define MKKeyBookISBN @"isbn"
#define MKKeyBookMarketPrice @"lowestNewPrice"
#define MKKeyBookPageMark @"pageMark"
#define MKKeyBookPages @"pages"
#define MKKeyBookPlacePublished @"placePublished"
#define MKKeyBookPlacedForSaleAt @"placedForSaleAt"
#define MKKeyBookPublisher @"publisher"
#define MKKeyBookSeries @"series"
#define MKKeyBookSoldOn @"soldOn"
#define MKKeyBookTranslator @"translator"
#define MKKeyBookNotes @"notes"
#define MKKeyBookSubjects @"subjects"
//NSNumber Bool YES or NO
#define MKKeyBookSigned @"signed"
#define MKKeyBookOnSale @"onSale"
#define MKKeyBookSoldBook @"hasBeenSold"


#pragma mark CDpedia

#define MKKeyCDArtist @"artist"
#define MKKeyCDProducer @"producer"
#define MKKeyCDDuration @"duration"
#define MKKeyCDComposer @"composer"
#define MKKeyCDLabel @"label"
#define MKKeyCDCustomerRating @"rating"
#define MKKeyCDConductor @"conductor"
#define MKKeyCDDiscs @"discs"
#define MKKeyCDUPC @"upc"
#define MKKeyCDArrangedBy @"arrangedBy"
#define MKKeyCDMixedBy @"mixedBy"
#define MKKeyCDDiscID @"discID"


#pragma mark Gamepedia

#define MKKeyGameDeveloper @"developer"
#define MKKeyGamePlataform @"plataform"
#define MKKeyGamePublisher @"publisher"
#define MKKeyGameScore @"score"
#define MKKeyGameRated @"rated"
#define MKKeyGamePlayerRating @"rating"
#define MKKeyGameTime @"time"
#define MKKeyGameSeries @"series"
#define MKKeyGameRegion @"region"
#define MKKeyGameDiscs @"discs"
#define MKKeyGameUPC @"upc"
#define MKKeyGameSystemRequirements @"systemRequirements"
#define MKKeyGameAchievements @"achievements"
#define MKKeyGameAwards @"awards"
#define MKKeyGameNumberOfPlayers @"numberOfPlayers"
#define MKKeyGameMulitplayer @"mulitplayer"
#define MKKeyGameLastPlayed @"lastPlayed"
#define MKKeyGameFeatures @"features"
//NSNumber Bool YES or NO
#define MKKeyGameNowPlaying @"nowPlaying"
#define MKKeyGameCompleted @"completed"
#define MKKeyGameManual @"manual"
#define MKKeyGameSpecialEdition @"specialEdition"

#pragma mark Special Keywords

// URL to the image
#define MKKeyEntryImageLocation @"imageLocation"

//An array of dictionaries with keys 'name', 'url', 'type'
#define MKKeyEntryArrayLinks @"linksSet"

//An Array of dictionaries with values for "name" and/or "role"
#define MKKeyDVDArrayCredits @"creditsSet"

//An Array of dictionaries with values for "name" and/or "artist" and/or "duration"
#define MKKeyCDArrayTracks @"tracksSet"
