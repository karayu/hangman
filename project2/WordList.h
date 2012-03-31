//
//  WordList.h
//  project2
//
//  Created by Kara Yu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordList : NSObject

@property (strong, nonatomic) NSMutableDictionary *words;
@property (strong, nonatomic) NSMutableDictionary *potential_words;

@property (nonatomic) BOOL *evil;
@property (nonatomic) int *remaining_guesses;
@property (nonatomic) int word_length;
@property (nonatomic) int *total_guesses;
@property (nonatomic) NSArray *used_letters;


@end
