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
        _chatLastMsgDate = [self getTimeSinceLastPost:[[chatDictionary objectForKey:@"last_message"] valueForKey:@"created"]];
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

-  (NSString *)getTimeSinceLastPost:(NSString *)messageDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    NSDate *postedDate = [formatter dateFromString:messageDate];
    
    NSTimeInterval secondsBetweenDates = [postedDate timeIntervalSinceNow];

    return [self stringFromInterval:- secondsBetweenDates];

}

- (NSString *)stringFromInterval:(NSTimeInterval)interval {
    NSString *returnString;
    NSInteger ti = (NSInteger)interval;
    NSInteger days = ((NSInteger)ti / 3600) % 24;
    NSInteger hours = ((NSInteger)ti / 3600) % 60;
    NSInteger minutes = ((NSInteger)ti / 60) % 60;
    
    if (days == 0) {
        if (hours == 0) {
            returnString = [NSString stringWithFormat:@"%li minutes ago", minutes];
        } else {
            returnString = [NSString stringWithFormat:@"%li hours and %li minutes ago", hours, minutes];
        }
    } else {
        if (hours == 0) {
            returnString = [NSString stringWithFormat:@"%li days ago", days];
        } else if (days == 1) {
            returnString = [NSString stringWithFormat:@"%li day %li hours ago", days, hours];
        } else {
            returnString = [NSString stringWithFormat:@"%li days %li hours ago", days, hours];
        }
    }
//    NSLog(@"number of days: %li, hours: %li and minutes: %li", (long)days, (long)hours, (long)minutes);

    return returnString;
}

@end
