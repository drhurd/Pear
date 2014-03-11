//
//  CHViewController.m
//  Pear
//
//  Created by Chris O'Neil on 3/11/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "CHViewController.h"
#import <Firebase/Firebase.h>
#import <AVFoundation/AVFoundation.h>

@interface CHViewController ()

@end

@implementation CHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FirebaseManager *fb = [FirebaseManager singleton];
    [fb addDelegate:self];

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

- (void)receivedSnapshot:(FDataSnapshot *)snapshot {
    NSLog(@"snapshot: %@", snapshot);
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


- (void)playSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"test"
                                                              ofType:@"m4a"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                   error:nil];
    player.numberOfLoops = -1; //Infinite
    
    [player play];
}
@end
