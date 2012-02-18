//
//  NHAction.h
//  NetHack
//
//  Created by Dirk Zimmermann on 11/24/11.
//  Copyright (c) 2011 Dirk Zimmermann. All rights reserved.
//

/*
 * NetHack
 * Copyright (C) 2012  Dirk Zimmermann (me AT dirkz DOT com)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#import <Foundation/Foundation.h>

@class NHAction;

typedef void (^ActionBlock)(NHAction *action);

@interface NHAction : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) ActionBlock block;

+ (id)actionWithTitle:(NSString *)t block:(ActionBlock)b;

- (id)initWithTitle:(NSString *)t block:(ActionBlock)b;
- (void)perform;

@end
