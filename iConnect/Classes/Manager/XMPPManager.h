//
//  XMPPManager.h
//  iConnect
//
//  Created by 祝发冬 on 15/6/29.
//  Copyright (c) 2015年 祝发冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

@interface XMPPManager : NSObject <XMPPStreamDelegate>
+(XMPPManager*)shareManager;
-(void)setupXMPPStream;
-(void)connectToHost;
-(void)sendPassWord;
-(void)sendPresence;
-(void)connect;
-(void)disConnect;

@end
