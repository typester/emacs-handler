#import "App.h"

#import "NSURL+L0URLParsing.h"

@implementation App

-(void)awakeFromNib {
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    path = [d objectForKey:@"path"];

    NSAppleEventManager *appleEventManager = [NSAppleEventManager sharedAppleEventManager];
    [appleEventManager setEventHandler:self andSelector:@selector(handleGetURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

-(void)handleGetURLEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    if (nil == path) return;

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
                [task setLaunchPath:path];
                [task setArguments:[NSArray arrayWithObjects:@"-n", [NSString stringWithFormat:@"+%d:%d", [line integerValue], [column integerValue]], file, nil]];
                [task launch];
                [task release];
            }
        }
    }
}

-(IBAction)showPrefPanel:(id)sender {
    if (path) {
        [textField setStringValue:path];
    }
    else {
        [textField setStringValue:@""];
    }
    [prefPanel makeKeyAndOrderFront:nil];
}

-(IBAction)applyChange:(id)sender {
    path = [textField stringValue];

    if (path) {
        NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
        [d setObject:path forKey:@"path"];
    }

    [prefPanel orderOut:nil];
}

@end
