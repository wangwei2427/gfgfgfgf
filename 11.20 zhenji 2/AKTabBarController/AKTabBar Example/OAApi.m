//
//  OAApi.m
//  OA
//
//  Created by FengXingTianXia on 13-10-10.
//  Copyright (c) 2013年 Clover. All rights reserved.
//

#import "OAApi.h"
#import "json/SBJson.h"

@implementation OAApi
//POST上传
+ (NSArray*) httpPostToUrl:(NSString*)url withFields:(NSArray*)fields ofValues:(NSArray*)values
{
    
    NSMutableString *post = [NSMutableString stringWithCapacity:50];
    for (int i =0 ; i < [fields count]; i++){
        if ([values objectAtIndex:i] != nil) {
            [post appendFormat:@"%@=%@&",[fields objectAtIndex:i],[values objectAtIndex:i]];
        }else
        {
            [post appendFormat:@"%@=%@&",[fields objectAtIndex:i],@""];
        }
    }
    if (post.length > 0) {
        [post deleteCharactersInRange:NSMakeRange([post length] - 1, 1)];
    }
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSUserDefaults *domainUD=[NSUserDefaults standardUserDefaults];
    NSString *domain=[domainUD objectForKey:@"domain"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",domain,url]]];
    
    NSLog(@"http post url: %@",[NSString stringWithFormat:@"%@%@",domain,url]);
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLResponse *response;
    
    
    //服务器返回数据
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSUTF8StringEncoding];
    
    
    NSLog(@"theReply---->%@",theReply);
    SBJsonParser *parser = [[SBJsonParser alloc ] init];
    NSArray *jsonobj = [parser objectWithString:theReply];
    if (jsonobj == nil) {
        //[[Singleton sharedSingleton] contentFiled];
        return nil;
    }
    
//    NSString* ret_code = [jsonobj objectForKey:@"flag"];
//    if (ret_code ==nil || [ret_code intValue] == 0)
//    {
//        //提示是否加载成功
//        [[Singleton sharedSingleton] contentFiled];
//        //return nil;
//    }
    
    return jsonobj;
}
//地图坐标
+(NSArray *)Url:(NSString *)url strLat:(NSString *)strLat strLon:(NSString *)strLon
{
    NSString *posturl = url;
    
    NSMutableArray* values = [NSMutableArray  arrayWithObjects:nil];
    NSMutableArray* fileds = [NSMutableArray  arrayWithObjects:nil];
    [values addObject:strLat];
    [fileds addObject:@"lng"];
    
    [values addObject:strLon];
    [fileds addObject:@"lat"];
    
    NSArray  *jsonObj = [self httpPostToUrl:posturl withFields:fileds ofValues:values];
    return jsonObj;
    
}


@end
