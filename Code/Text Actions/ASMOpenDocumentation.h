//
//  ASMOpenDocumentation.h
//  FlashSugar
//
//  Created by Michael Murray on 4/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


@interface ASMOpenDocumentation : NSObject {
	IBOutlet id docWidnow;
	
	IBOutlet WebView *webView;
	
	NSString *docURL;
	
}

- (void) webViewLoadRequest:(NSString *) url;

- (IBAction) goBack:(id)sender;
- (IBAction) goForward:(id)sender;


@end
