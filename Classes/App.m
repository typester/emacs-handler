#import "App.h"

#import "NSURL+L0URLParsing.h"

@implementation App

-(void)applicationDidFinishLaunching:(NSNotification*)n {
    NSAppleEventManager *appleEventManager = [NSAppleEventManager sharedAppleEventManager];
    [appleEventManager setEventHandler:self andSelector:@selector(handleGetURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

-(void)handleGetURLEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    // emacs://open/?url=file://~/.bash_profile&line=11&column=2
    NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];

    if (url && [[url host] isEqualToString:@"open"]) {
        NSDictionary *params = [url dictionaryByDecodingQueryString];
        NSURL *file_url = [NSURL URLWithString:[params objectForKey:@"url"]];

        if (file_url && [[file_url scheme] isEqualToString:@"file"]) {
            NSString *file = [file_url path];
            NSString *line = [params objectForKey:@"line"];
            NSString *column = [params objectForKey:@"column"];

            if (file) {
                NSTask *task = [[NSTask alloc] init];
                [task setLaunchPath:@"/Applications/CarbonEmacs.app/Contents/MacOS/bin/emacsclient"];
                [task setArguments:[NSArray arrayWithObjects:@"-n", [NSString stringWithFormat:@"+%d:%d", [line integerValue], [column integerValue]], file, nil]];
                [task launch];
                [task release];
            }
        }
    }
}

@end
