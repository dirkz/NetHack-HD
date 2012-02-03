//
//  Position.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/3/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#ifndef NetHack_IntPosition_h
#define NetHack_IntPosition_h

typedef struct _IntPosition {
    int x;
    int y;
} IntPosition;

static inline IntPosition IntPositionMake(int i, int j) { IntPosition p = {i,j}; return p; }

#endif
