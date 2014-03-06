//
//  AppDelegate.m
//  Lorem Ipsum
//
//  Created by Francisco Crizul on 2/27/14.
//  Copyright (c) 2014 Francisco Crizul. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    NSMutableData * receivedData;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [_count setStringValue:@"5"];
    [_typeOfResult selectItemAtIndex:0];
    [self hideProgressIndicator];
}

- (IBAction)startWith:(id)sender {
    
}
- (void) showProgressIndicator{
    [_progressIndicator setHidden:NO];
    [_progressIndicator startAnimation:self];
    [_genButton setEnabled:NO];
}
- (void) hideProgressIndicator{
    [_progressIndicator stopAnimation:self];
    [_progressIndicator setHidden:YES];
    [_genButton setEnabled:YES];
}

- (IBAction)GenerateButton:(id)sender {
    [self showProgressIndicator];
    NSString * startStr = @"no";
    if ([_start state] == NSOnState){
        startStr = @"yes";
    }
    NSString * option;
    switch ([_typeOfResult indexOfSelectedItem]) {
        case 0:
            option = @"paras";
            break;
        case 1:
            option = @"words";
            break;
        case 2:
            option = @"bytes";
            break;
        case 3:
            option = @"lists";
            break;
        default:
            option = @"paras";
            break;
    }
    
    NSURL * url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.lipsum.com/feed/json?amount=%@&what=%@&start=%@&generate=Generate+Lorem+Ipsum",_count.stringValue,option,startStr]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    receivedData = [[NSMutableData alloc] init];
    [connection start];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self hideProgressIndicator];
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    
}
-(void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString * temp = [[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\n" withString:@"|"];
    
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:[temp dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if(!error)
    {
        if([json isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = json;
            NSDictionary * feed = [results objectForKey:@"feed"];
            if (!feed) {
                return;
            }
            NSString * generated = [feed objectForKey:@"generated"];
            if (generated) {
                [_infoLipsum setStringValue:generated];
            }
            NSString * lipsum = [feed objectForKey:@"lipsum"];
            if (lipsum) {
                [_lipsum setString:[lipsum stringByReplacingOccurrencesOfString:@"|" withString:@"\n\n"]];
            }
        }
    }
    [self hideProgressIndicator];
}
@end
