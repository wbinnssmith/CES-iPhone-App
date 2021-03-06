//
//  LocationItemJSONDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationItemJSONDataModel.h"
#import "LocationItem.h"
#import "Three20/Three20.h"

@interface LocationItemJSONDataSource : TTSectionedDataSource {
    LocationItemJSONDataModel *_locationItemDataModel;
    NSString *_locationId;
}

-(id)initWithLocationId:(NSString *)locationId;
-(NSString *) formatPhoneString:(NSString *) rawString;
//-(NSString* )openGoogleMapsWithStartingCoordinate:(CLLocationCoordinate2D)destination;
-(NSString* )openGoogleMapsWithDestinationLatitude:(NSString *)latitude longitude:(NSString *)longitude;


@end
