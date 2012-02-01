//
//  MainViewController.m
//  NetHack
//
//  Created by Dirk Zimmermann on 2/1/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#include <sys/stat.h> // mkdir()

#import "MainViewController.h"

#import "RoguelikeTextView.h"
#import "NHYNQuestion.h"
#import "NHHandler.h"
#import "GlobalConfig.h"

extern int unix_main(int argc, char **argv);

@interface MainViewController () {
    
    IBOutlet UITextView *messageView;
    IBOutlet UILabel *statusLine1;
    IBOutlet UILabel *statusLine2;
    RoguelikeTextView *dummyTextView;
    NSThread *netHackThread;
    
}

@property (nonatomic, retain) NHYNQuestion *currentYNQuestion;

- (void)netHackMainLoop:(id)arg;
- (void)addMessageLine:(NSString *)line;

@end

@implementation MainViewController

@synthesize currentYNQuestion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    dummyTextView = [[RoguelikeTextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:dummyTextView];
    dummyTextView.delegate = self;
    [dummyTextView release];
    
    [[GlobalConfig sharedInstance] setObject:self forKey:kNHHandler];
    
	netHackThread = [[NSThread alloc] initWithTarget:self selector:@selector(netHackMainLoop:) object:nil];
	[netHackThread start];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - NetHack main loop

- (void)netHackMainLoop:(id)arg {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
#ifdef SLASHEM
	char *argv[] = {
		"SlashEM",
	};
#else
	char *argv[] = {
		"NetHack",
	};
#endif
	int argc = sizeof(argv)/sizeof(char *);
	
	// create necessary directories
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *baseDirectory = [paths objectAtIndex:0];
	DLog(@"baseDir %@", baseDirectory);
	setenv("NETHACKDIR", [baseDirectory cStringUsingEncoding:NSASCIIStringEncoding], 1);
	//setenv("SHOPTYPE", "G", 1); // force general stores on every level in wizard mode
	NSString *saveDirectory = [baseDirectory stringByAppendingPathComponent:@"save"];
	mkdir([saveDirectory cStringUsingEncoding:NSASCIIStringEncoding], 0777);
	
	// show directory (for debugging)
#if 0	
	for (NSString *filename in [[NSFileManager defaultManager] enumeratorAtPath:baseDirectory]) {
		DLog(@"%@", filename);
	}
#endif
	
	// call it
	unix_main(argc, argv);
	
	// clean up thread pool
	[pool drain];
}

#pragma mark - Internal API

- (void)addMessageLine:(NSString *)line {
    if ([messageView hasText]) {
        NSString *content = [NSString stringWithFormat:@"%@\n%@", messageView.text, line];
        messageView.text = content;
    } else {
        messageView.text = line;
    }
}

#pragma mark - NHHandler

- (void)handleYNQuestion:(NHYNQuestion *)question {
    self.currentYNQuestion = question;
    [self addMessageLine:question.question];
}

- (void)handleMenuWindow:(NHMenuWindow *)w {
    
}

- (void)handleRawPrintWithMessageWindow:(NHMessageWindow *)w {
    
}

- (void)handleMessageWindow:(NHMessageWindow *)w shouldBlock:(BOOL)b {
    
}

- (void)handlePoskey:(NHPoskey *)p {
    
}

- (void)handleMapWindow:(NHMapWindow *)w shouldBlock:(BOOL)b {
    
}

- (void)handleStatusWindow:(NHStatusWindow *)w {
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (text.length == 1) {
        char c = [text characterAtIndex:0];
        if (self.currentYNQuestion) {
            currentYNQuestion.choice = c;
            [currentYNQuestion signal];
            self.currentYNQuestion = nil;
        }
    }
    return NO;
}

@end
