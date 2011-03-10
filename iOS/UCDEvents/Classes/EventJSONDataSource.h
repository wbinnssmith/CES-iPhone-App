//
//  EventXMLDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "EventJSONDataModel.h"
#import "EventItem.h"

#import <Three20Core/NSDateAdditions.h>


@interface EventJSONDataSource : TTSectionedDataSource {
	EventJSONDataModel *_eventFeedModel;
}

-(id)initWithMyURL:(NSString *)theURL;

@end