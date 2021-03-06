//
//  LocationXMLDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationJSONDataSource.h"

@implementation LocationJSONDataSource

-(id)initWithMyURL:(NSString *)theURL {
	if (self = [super init]) {
		_locationFeedModel = [[LocationJSONDataModel alloc] initWithMyURL:theURL];
	
	}

	return self;
}

-(void)dealloc {
	TT_RELEASE_SAFELY(_locationFeedModel);
	
	[super dealloc];
}

-(id<TTModel>)model {
	return _locationFeedModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
	self.items = [NSMutableArray array];
	self.sections = [NSMutableArray array];
	
	NSMutableArray *locationsFromModel = _locationFeedModel.locations;
	
	NSSortDescriptor *sortByCategory = [[NSSortDescriptor alloc] initWithKey: @"category" ascending:YES];
	NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:sortByCategory, sortByName, nil];
	[locationsFromModel sortUsingDescriptors:sortDescriptors];
	
	TT_RELEASE_SAFELY(sortByCategory);
	TT_RELEASE_SAFELY(sortByName);
	
	NSMutableDictionary *categories = [NSMutableDictionary dictionary];
	
	for (LocationItem *location in locationsFromModel) {
		NSString *categoryName = location.category;
        NSLog(@"Category name is %@", categoryName);
		NSMutableArray *category = [categories objectForKey:categoryName];
		if (!category) {
			category = [NSMutableArray array];
			[categories setObject:category forKey:categoryName];
		}
		
		//		This is the actual creation of the location's cell item. URL is empty as the view controller push is handled elsewhere.
		TTTableSubtitleItem *newTableItem = [TTTableSubtitleItem itemWithText:location.name subtitle:location.address imageURL:location.imageURL URL:@""];
		
		//		Bundle up the location NSObject into userInfo as a query-able dictionary.
		//		We use this in the tableviewcontroller's didSelect method to push the location to the detailviewcontroller.
		newTableItem.userInfo = [NSDictionary dictionaryWithObject:location forKey:@"location"];
		newTableItem.defaultImage = [UIImage imageNamed:@"agg2x.png"];
		
		[category addObject:newTableItem];
	}
	
	NSArray *categoryNames = [categories.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	for (NSString *currentCategory in categoryNames) {
		NSArray *items = [categories objectForKey:currentCategory];
		[_sections addObject:currentCategory];
		[_items addObject:items];
	}
}

-(void)search:(NSString *)text {
	if (text.length) {
		_items = [[NSMutableArray alloc] init];
		NSMutableArray *resultItems = [[NSMutableArray alloc] init];
		NSLog(@"Reached the search!");
		text = [text lowercaseString];
		NSLog(@"text is: %@", text);
		for (LocationItem *location in _locationFeedModel.locations) {
			NSString *locationName = [location.name lowercaseString];
			if ([locationName hasPrefix:text]) {
				NSLog(@"Found a match with location %@", location.name);
				TTTableSubtitleItem *newTableItem = [TTTableSubtitleItem itemWithText:location.name subtitle:location.address imageURL:location.imageURL URL:@""];
				newTableItem.userInfo = [NSDictionary dictionaryWithObject:location forKey:@"location"];
				newTableItem.defaultImage = [UIImage imageNamed:@"agg2x.png"];
				[resultItems addObject:newTableItem];
			}
		}
		[_items addObject:resultItems];
		_sections = [NSArray arrayWithObject:@"Test"];
		
		NSLog(@"items are: %@", _items);		 
		if ([resultItems count] == 0) {
			[resultItems release];
			resultItems	= nil;
		} else {
			resultItems = nil;
		}
		
		[_delegates perform:@selector(modelDidFinishLoad:) withObject:self];

	}
}

-(NSMutableArray *)delegates {
	if (!_delegates) {
		_delegates = TTCreateNonRetainingArray();
	}
	return _delegates;
}

-(NSString *)titleForLoading:(BOOL)reloading {
	return @"Loading...";
}

-(NSString *)titleForEmpty {
	return @"Please try again later.";
}

-(NSString *)titleForError:(NSError *)error {
	return @"There was an error!";
}

-(NSString *)subtitleForError:(NSError *)error {
	return @"Please try again later.";
}


@end
