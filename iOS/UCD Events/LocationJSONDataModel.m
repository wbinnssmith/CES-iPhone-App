//
//  LocationXMLDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationJSONDataModel.h"


@implementation LocationJSONDataModel

@synthesize myurl = _myurl;
@synthesize locations = _locations;
@synthesize finished = _finished;

-(id)initWithMyURL:(NSString *)theURL {
	if (self = [super init]) {
		self.myurl = theURL;
		_locations = [[NSMutableArray array] retain];
	}
	
	return self;
}

-(void) dealloc {
	TT_RELEASE_SAFELY(_myurl);
	TT_RELEASE_SAFELY(_locations);
	[super dealloc];
}

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading && TTIsStringWithAnyText(_myurl)) {
		// Create a request for the XML file passed by the init method
		TTURLRequest *request = [TTURLRequest requestWithURL:self.myurl delegate:self];
	
		// Define a cacheTimeout of 7 days
		NSTimeInterval cacheTimeout = 7 * 24 * 60 * 60;
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = cacheTimeout;

		// Prepare a response for the request
		TTURLJSONResponse *response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		// Send out the request
		if ([request send]) {
			NSLog(@"Loaded URL From cache");
		} else {
			NSLog(@"Loaded URL from web");
		}
	}
}

-(void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLJSONResponse *response = request.response;
    NSLog(@"%@", [response.rootObject class]);
	TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
	
	// rootObject represents the parsed JSON feed in an array of dictionaries representing nodes
	NSArray *feed = response.rootObject;
    
	NSArray *theLocations = feed;

	NSMutableArray *locations = [[NSMutableArray alloc] init];

	for (NSDictionary *currentLocationDictionary in theLocations) {
        NSDictionary *currentLocation = [currentLocationDictionary objectForKey:@"location"];
		LocationItem *location = [[LocationItem alloc] initWithLocationDictionary:currentLocation];

		[locations addObject:location];
		TT_RELEASE_SAFELY(location);
	}

	_finished = TRUE;
	
	// Clear out locations just in case we've done this before
	[_locations removeAllObjects];
	[_locations addObjectsFromArray:locations];

	TT_RELEASE_SAFELY(locations);
	
	[super requestDidFinishLoad:request];
}

@end
