//
//  ZDActionScript3ClassTagItem.m
//  ExampleSugar
//

#import "ZDActionScript3ClassTagItem.h"


//
// Example item; open a HTML file to see it in action
//
@implementation ZDActionScript3ClassTagItem

- (void)initializeWithCapturedZones:(NSDictionary *)captures recipeInfo:(NSDictionary *)recipeInfo
{
	[super initializeWithCapturedZones:captures recipeInfo:recipeInfo];
	
	name = [[[captures objectForKey:@"name"] text] retain];
	extends = [[[captures objectForKey:@"extends"] text] retain];
}

- (void)dealloc
{
	[name release];
	[extends release];
	
	name = nil;
	extends = nil;
	
	[super dealloc];
}

- (BOOL)transformIntoItem:(ZDActionScript3ClassTagItem *)otherItem
{
	// Note: the passed argument can actually be any item class, but casting it to this specific class makes it easy to write the transformation code. The default (super) implementation takes care of checking the class, so this is perfectly valid.
	if (![super transformIntoItem:otherItem])
		return NO;
	
	// Clean up our own old values
	[name release];
	[extends release];
	
	name = nil;
	extends = nil;
	
	// Take over the new values from the other item
	name = [otherItem->name retain];
//	extends = [otherItem->variable retain];
	//NSLog(NSStringFromSelector(otherItem));
	
	return YES;
}

- (BOOL)isDecorator
{
	return YES;
}

- (CEItemDecorationType)decorationType
{
	return 0;
}

- (NSColor *)backgroundColor
{
	return [NSColor new];
}

- (NSImage *)image {
	NSString* imagePath = @"~/Library/Application Support/Espresso/Sugars/ActionScript3.sugar/Contents/Resources/script_gear.png";
	return [[NSImage alloc] initWithContentsOfFile:[imagePath stringByExpandingTildeInPath]];
}

- (BOOL)isTextualizer
{
	return YES;
}

- (NSString *)title
{
	return [NSString stringWithFormat:@"%@", name];
}

@end
