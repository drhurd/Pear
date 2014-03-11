//
//  CHViewController.m
//  Pear
//
//  Created by Chris O'Neil on 3/11/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "CHViewController.h"
#import <Firebase/Firebase.h>

@interface CHViewController ()

@end

@implementation CHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* url = @"https://pearsync.firebaseio.com/sound";
    Firebase* dataRef = [[Firebase alloc] initWithUrl:url];
    [dataRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self renderSignal:snapshot];
    }];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://pearsync.firebaseio.com/sound"];
    
    // Write data to Firebase
    NSArray *vals = @[@"red", @"green", @"blue", @"orange"];
    int index = arc4random()%4;
    NSLog(@"index %i", index);
    
    [f setValue:vals[index]];
}

- (void)renderSignal:(FDataSnapshot*)snapshot {
    NSLog(@"snapshot: %@", snapshot);
    if (snapshot.value) {
        if ([snapshot.value isEqualToString:@"red"]) {
            self.view.backgroundColor = [UIColor redColor];
        } else if ([snapshot.value isEqualToString:@"blue"]) {
            self.view.backgroundColor = [UIColor blueColor];
        } else if ([snapshot.value isEqualToString:@"orange"]) {
            self.view.backgroundColor = [UIColor orangeColor];
        } else if ([snapshot.value isEqualToString:@"green"]) {
            self.view.backgroundColor = [UIColor greenColor];
        }
    }
}

@end
