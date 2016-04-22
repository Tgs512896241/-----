//
//  TgsNetHelperShare.m
//  随心所欲
//
//  Created by Tgs on 16/4/22.
//  Copyright © 2016年 Tgs. All rights reserved.
//

#import "TgsNetHelperShare.h"

static TgsNetHelperShare *sharedManager = nil;

@implementation TgsNetHelperShare
@synthesize httpManager;

+(TgsNetHelperShare *)sharedNetManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[TgsNetHelperShare allocWithZone:NULL]init];
    });
    return sharedManager;
}


#pragma mark--通用网络接口POST
-(void)getPostNetInfoWithUrl:(NSString *)urlPath andType:(RequestType)type andWith:(NSDictionary *)paramters andReturn:(void (^)(NSDictionary *dic))block{
    
    NSNumber *index = [NSNumber numberWithInteger:type];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithCapacity:5];
    NSString *path;
    [dataDic setObject:[NSString stringWithFormat:@"%@%@",path,urlPath] forKey:@"url"];
    [dataDic setObject:index forKey:@"userinfo"];
    if (paramters.allKeys.count>0) {
        [dataDic setObject:paramters forKey:@"parameters"];
    }
    [self setPostReturnNetWorkWith:dataDic andReturn:^(NSDictionary *dic) {
        if (block) {
            block(dic);
        }
    }];
}

-(void)setPostReturnNetWorkWith:(NSDictionary *)dictionary andReturn:(void (^)(NSDictionary *dic))block{
    //    AFNetWorking下载数据
    httpManager = [AFHTTPRequestOperationManager manager];
    ((AFJSONResponseSerializer *)httpManager.responseSerializer).removesKeysWithNullValues = YES;
//    RequestType type = [[dictionary objectForKey:@"userinfo"] intValue];
    httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    NSDictionary *postDic = [[NSDictionary alloc]initWithDictionary:[dictionary valueForKey:@"parameters"]];
    [httpManager POST:[dictionary valueForKey:@"url"] parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [operation responseData];
        [dataDic setValue:@"Success" forKey:@"info"];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [dataDic setValue:resultDic forKey:@"result"];
        if (block) {
            block(dataDic);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[operation responseString]);
        [dataDic setValue:@"Fail" forKey:@"info"];
        [dataDic setValue:nil forKey:@"result"];
        if (block) {
            block(dataDic);
        }
    }];
}
#pragma mark--网络请求GET
-(void)getGetNetInfoWithUrl:(NSString *)urlPath andType:(RequestType)type andWith:(NSDictionary *)paramters andReturn:(void (^)(NSDictionary *dic))block{
    NSNumber *index = [NSNumber numberWithInteger:type];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithCapacity:5];
    NSString *path;
    [dataDic setObject:[NSString stringWithFormat:@"%@%@",path,urlPath] forKey:@"url"];
    [dataDic setObject:index forKey:@"userinfo"];
    if (paramters.allKeys.count>0) {
        [dataDic setObject:paramters forKey:@"parameters"];
    }
    [self setGetTheadNetworkWithUrl:dataDic andReturn:^(NSDictionary *dic) {
        if (block) {
            block(dic);
        }
    }];

}
-(void)setGetTheadNetworkWithUrl:(NSDictionary *)dictionary andReturn:(void (^)(NSDictionary *dic))block{
    httpManager = [AFHTTPRequestOperationManager manager];
    ((AFJSONResponseSerializer *)httpManager.responseSerializer).removesKeysWithNullValues = YES;
//    RequestType type = [[dictionary objectForKey:@"userinfo"] intValue];
    httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    [httpManager GET:[dictionary valueForKey:@"url"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [operation responseData];
        [dataDic setValue:@"Success" forKey:@"info"];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [dataDic setValue:resultDic forKey:@"result"];
        if (block) {
            block(dataDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [dataDic setValue:@"Fail" forKey:@"info"];
        [dataDic setValue:nil forKey:@"result"];
        if (block) {
            block(dataDic);
        }
    }];
}


@end
