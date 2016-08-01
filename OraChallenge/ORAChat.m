//
//  ORAChat.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/31/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORAChat.h"

@implementation ORAChat

- (id) init {
    return [self initChatWithDictionary:_chatDictionary];
}

- (instancetype)initChatWithDictionary:(NSDictionary *)chatDictionary {
    self = [super init];
    
    if (self) {
        _chatDictionary = chatDictionary;
        _chatStartDate = [self getCreatedDateFromString:[chatDictionary valueForKey:@"created"]];
        _chatName = [chatDictionary valueForKey:@"name"];
        _chatOwner = [[chatDictionary objectForKey:@"user"] valueForKey:@"name"];
        _chatLastMsg = [[chatDictionary objectForKey:@"last_message"] valueForKey:@"message"];
        _chatLastMsgOwner = [[[chatDictionary objectForKey:@"last_message"] objectForKey:@"user"] valueForKey:@"name"];
    }
    
    return self;
}

- (NSString *)getCreatedDateFromString:(NSString *)chatDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    NSDate *date = [formatter dateFromString:chatDate];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:@"LLLL dd"];
    
    return [newFormatter stringFromDate:date];
}

@end
