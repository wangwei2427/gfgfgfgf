//
//  OAApi.h
//  OA
//
//  Created by FengXingTianXia on 13-10-10.
//  Copyright (c) 2013年 Clover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAApi : NSObject
//POST上传
+ (NSArray*) httpPostToUrl:(NSString*)url withFields:(NSArray*)fields ofValues:(NSArray*)values;
//登录
+(NSArray *)Url:(NSString *)url strLat:(NSString *)strLat strLon:(NSString *)strLon;

@end
