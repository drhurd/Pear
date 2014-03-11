//
//  FirebaseManager.m
//  Pear
//
//  Created by Billy Irwin on 3/11/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "FirebaseManager.h"

@implementation FirebaseManager

static FirebaseManager *fb = nil;

+ (FirebaseManager*)singleton {
    if (!fb) {
        fb = [[FirebaseManager alloc] init];
    }
    
    return fb;
}

- (id)init {
    self = [super init];
    if (self) {
        self.delegates = [[NSMutableArray alloc] init];
        [self registerForFirebase];
    }
    
    return self;
}

- (void)addDelegate:(id)delegate {
    [self.delegates addObject:delegate];
}

- (void)registerForFirebase {
    NSString* url = @"https://pearsync.firebaseio.com/sound";
    Firebase* dataRef = [[Firebase alloc] initWithUrl:url];
    [dataRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"got snapshot");
        if (snapshot.value != [NSNull null] && snapshot.value) {
            for (id delegate in self.delegates) {
                [delegate receivedSnapshot:snapshot];
            }
        }
    }];
    [self connectUser];
}

- (void)connectUser {
    Firebase* countRef = [[Firebase alloc] initWithUrl:@"https://pearsync.firebaseio.com/users"];
    [countRef runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
        NSNumber *countVal = currentData.value;
        if (![countVal isEqual:[NSNull null]]) {
            [currentData setValue:@(countVal.integerValue + 1)];
        }
        return [FTransactionResult successWithValue:currentData];
    }];
}

- (void)disconnectUser {
    NSLog(@"disconnect");
    Firebase* countRef = [[Firebase alloc] initWithUrl:@"https://pearsync.firebaseio.com/users"];
    [countRef runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
        NSNumber *countVal = currentData.value;
        if (![countVal isEqual:[NSNull null]]) {
            [currentData setValue:@(countVal.integerValue - 1)];
            NSLog(@"actually diconnecting");
        }
        FTransactionResult *t = [FTransactionResult successWithValue:currentData];
        NSLog(@"asdfas");
        return t;
    }];
}

@end
