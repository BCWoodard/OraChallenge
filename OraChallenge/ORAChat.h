//
//  ORAChat.h
//  OraChallenge
//
//  Created by Brad Woodard on 7/31/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORAChat : NSObject

@property (nonatomic, strong) NSDictionary *chatDictionary;
@property (nonatomic, strong) NSString *chatStartDate;
@property (nonatomic, strong) NSString *chatName;
@property (nonatomic, strong) NSString *chatOwner;
@property (nonatomic, strong) NSString *chatLastMsgDate;
@property (nonatomic, strong) NSString *chatLastMsg;
@property (nonatomic, strong) NSString *chatLastMsgOwner;


- (id)initChatWithDictionary:(NSDictionary *)chatDictionary;

//+ (instancetype)initChatWithName:(NSString *)chatName;


@end
