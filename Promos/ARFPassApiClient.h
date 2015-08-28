//
//  ARFPassApiClient.h
//  Promos
//
//  Created by Alejandro Rodriguez on 8/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBaseUrbanApiClient.h"

@interface ARFPassApiClient : ARFBaseUrbanApiClient

+(ARFPassApiClient *) sharedClient;

-(void) downloadPassWithId:(NSString *) passID
               withSuccess:(void (^)(NSData *passData))successBlock
                   failure:(void (^)(NSError *error))failureBlock;

@end
