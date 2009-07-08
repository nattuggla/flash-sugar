//
//  ZDActionScript3ImportTagItem.m
//  ExampleSugar
//

#import "ZDActionScript3ImportTagItem.h"


//
// Example item; open a HTML file to see it in action
//
@implementation ZDActionScript3ImportTagItem

- (void)initializeWithCapturedZones:(NSDictionary *)captures recipeInfo:(NSDictionary *)recipeInfo
{
	[super initializeWithCapturedZones:captures recipeInfo:recipeInfo];
	
	name = [[[captures objectForKey:@"name"] text] retain];
}

- (void)dealloc
{
	[name release];
	name = nil;
	[super dealloc];
}

- (BOOL)transformIntoItem:(ZDActionScript3ImportTagItem *)otherItem
{
	// Note: the passed argument can actually be any item class, but casting it to this specific class makes it easy to write the transformation code. The default (super) implementation takes care of checking the class, so this is perfectly valid.
	if (![super transformIntoItem:otherItem])
		return NO;
	
	// Clean up our own old values
	[name release];
	name = nil;
	
	// Take over the new values from the other item
	name = [otherItem->name retain];
	
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
	//NSString* imagePath = @"~/Library/Application Support/Espresso/Sugars/FlashSugar.sugar/Contents/Resources/package_go.png";
	//return [[NSImage alloc] initWithContentsOfFile:[imagePath stringByExpandingTildeInPath]];
	
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"package_go" ofType:@"png"];
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
	[image autorelease];
	
	return image;
}

- (BOOL)isTextualizer
{
	return YES;
}

- (NSString *)title
{
	return name;
}

@end
