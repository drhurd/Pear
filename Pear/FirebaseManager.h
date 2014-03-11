//
//  FirebaseManager.h
//  Pear
//
//  Created by Billy Irwin on 3/11/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@protocol FirebaseManagerDelegate <NSObject>

- (void)receivedSnapshot:(FDataSnapshot*)snapshot;

@end



@interface FirebaseManager : NSObject

@property (strong, nonatomic) NSMutableArray *delegates;


- (void)addDelegate:(id)delegate;

- (void)connectUser;
- (void)disconnectUser;

+ (FirebaseManager*)singleton;

@end
