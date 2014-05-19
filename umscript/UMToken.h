//
//  UMToken.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>

@interface UMToken : UMObject
{
    NSString *string;
    id      token;
}

@property(readwrite,retain) NSString *string;
@property(readwrite,retain) id token;

@end
