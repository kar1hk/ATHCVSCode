//
//  CVSLegacyNetwork.h
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// TODO : Not Finished
#import <Foundation/Foundation.h>

// Define HTTP Method as enum
typedef NS_ENUM(NSInteger, CVSHTTPMethod) {
    CVSHTTPMethodGET,
    CVSHTTPMethodPOST
};

// Define Network Errors as enum
typedef NS_ENUM(NSInteger, CVSNetworkError) {
    CVSNetworkErrorInvalidURL,
    CVSNetworkErrorInvalidResponse,
    CVSNetworkErrorInvalidStatusCode,
    CVSNetworkErrorInvalidJSON,
    CVSNetworkErrorNoConnectivity,
    CVSNetworkErrorTimeout
};

// Completion Block for the network handler
typedef void (^CVSNetworkingCompletion)(id _Nullable result, NSError * _Nullable error);

// CVS Legacy Network Manager
@interface CVSLegacyNetwork : NSObject

// Singleton manager
+ (instancetype)shared;

// Request Method 
- (void)requestWithURL:(NSString *)urlString
                method:(CVSHTTPMethod)method
                  body:(id _Nullable)body
            completion:(CVSNetworkingCompletion)completion;

@end
