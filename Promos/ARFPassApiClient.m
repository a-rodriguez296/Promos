//
//  ARFPassApiClient.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPassApiClient.h"
#import "ARFConstants.h"

#import <AFURLSessionManager.h>


static ARFPassApiClient *sharedClient = nil;
static NSString *passSuffix = @"download/pass/";

@implementation ARFPassApiClient

+(ARFPassApiClient *) sharedClient{
    
    //Singleton para crear la instancia del api client
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedClient = [[ARFPassApiClient alloc] initWithBaseURL:[NSURL URLWithString:kWalletBaseUrl]];
    });
    
    return sharedClient;
}

-(void) downloadPassWithId:(NSString *) passID
               withSuccess:(void (^)(NSData *passData))successBlock
                   failure:(void (^)(NSError *error))failureBlock{
    
    NSString * suffixURL = [NSString stringWithFormat:@"%@41a3a688-7147-49f2-83bc-7b069a19a7c8", passSuffix];
    [self GET:suffixURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        
        successBlock(responseObject);
    }
      failure:^(AFHTTPRequestOperation *operation, NSError *error){
          
      }];
}


@end
