//
//  XMPPManager.m
//  iConnect
//
//  Created by 祝发冬 on 15/6/29.
//  Copyright (c) 2015年 祝发冬. All rights reserved.
//

#import "XMPPManager.h"

@implementation XMPPManager
{
    XMPPStream* _xmppStream;
    XMPPJID* _xmppJid;
}
+(XMPPManager*)shareManager
{
    static XMPPManager*manager;
   static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        manager = [[XMPPManager alloc] init];
    });
    return manager;
    
}
-(void)setupXMPPStream
{
    _xmppStream=[[XMPPStream alloc]init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    _xmppJid=[XMPPJID jidWithUser:@"kai2" domain:@"zhufadong" resource:@"iPhone"];
    [_xmppStream setMyJID:_xmppJid];
    
}
-(void)connectToHost
{
    
    NSError* err=nil;
  BOOL isConnected =[_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err];
    if (!isConnected)
    {
        NSLog(@"err=%@",err);
    }
}
-(void)sendPassWord
{
    [_xmppStream authenticateWithPassword:@"123456" error:nil];
}
-(void)sendPresence
{
    XMPPPresence*presence=[XMPPPresence presence];
    [_xmppStream sendElement:presence];
}
#pragma mark XMPP
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"连接主机成功");
    
    [self sendPassWord];
    
}
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"登录成功");
    [self sendPresence];
}
-(void)connect
{
    [self setupXMPPStream];
    
    [self connectToHost];
}
-(void)disConnect
{
    XMPPPresence*offline=[XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    [_xmppStream disconnect];
}
@end
