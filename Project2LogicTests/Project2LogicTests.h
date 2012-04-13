//
//  Project2LogicTests.h
//  Project2LogicTests
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "EvilGamePlay.h"
#import "GoodGamePlay.h"
#import "GamePlay.h"



@interface Project2LogicTests : SenTestCase

@property (nonatomic, strong) EvilGamePlay *evilLogic;
@property (nonatomic, strong) GoodGamePlay *goodLogic;
@property (nonatomic, strong) GamePlay *gameLogic;

@end
