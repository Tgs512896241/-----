//
//  TgsNetHelperShare.h
//  随心所欲
//
//  Created by Tgs on 16/4/22.
//  Copyright © 2016年 Tgs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#define ViewBackGroundColor ([UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1])
#import "AFNetworking.h"


typedef enum : NSUInteger {
    All = 0
} RequestType;

@interface TgsNetHelperShare : NSObject


@property(nonatomic,strong)AFHTTPRequestOperationManager *httpManager;
+(TgsNetHelperShare *)sharedNetManager;

-(void)getPostNetInfoWithUrl:(NSString *)urlPath andType:(RequestType)type andWith:(NSDictionary *)paramters andReturn:(void (^)(NSDictionary *dic))block;
-(void)getGetNetInfoWithUrl:(NSString *)urlPath andType:(RequestType)type andWith:(NSDictionary *)paramters andReturn:(void (^)(NSDictionary *dic))block;

@end
