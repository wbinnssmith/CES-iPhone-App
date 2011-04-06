//
//  LocationXMLDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "LocationItem.h"

#import <Three20/Three20.h>
#import <extThree20XML/extThree20XML.h>
#import <extThree20JSON/extThree20JSON.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"

@interface LocationJSONDataModel : TTURLRequestModel {
	NSString* _myurl; // url of XML file containing locations
	NSMutableArray *_locations; // array of locations in NSObject form
	
	BOOL _finished;
}

@property (nonatomic, copy) NSString *myurl;
@property (nonatomic, readonly) NSMutableArray *locations;
@property (nonatomic, readonly) BOOL finished;
@property (nonatomic, readonly) CLLocation *currentCoords;

-(id)initWithMyURL:(NSString *)theURL;

@end
