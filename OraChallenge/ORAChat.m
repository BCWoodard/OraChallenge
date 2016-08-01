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
        _chatName = [chatDictionary valueForKey:@"name"];
        _chatOwner = [[chatDictionary objectForKey:@"user"] valueForKey:@"name"];
        _chatLastMsg = [[chatDictionary objectForKey:@"last_message"] valueForKey:@"message"];
    }
    
    return self;
}

//+ (instancetype)initChatWithName:(NSString *)chatName {
//
//    ORAChat *chat = [[ORAChat alloc] initChatWithName:chatName];
//    
//    return chat;
//    
//}

@end
