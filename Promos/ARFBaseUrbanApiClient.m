//
//  ARFBaseUrbanApiClient.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBaseUrbanApiClient.h"

@implementation ARFBaseUrbanApiClient

-(id)initWithBaseURL:(nullable NSURL *)url{
    
    if (self = [super initWithBaseURL:url]) {
        
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/vnd.apple.pkpass"]];
    }
    return self;
}

@end
