/*
 *  winios.h
 *  SlashEM
 *
 *  Created by Dirk Zimmermann on 6/26/09.
 *  Copyright (c) 2009 Dirk Zimmermann. All rights reserved.
 *
 */

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

#include "hack.h"

void ios_init_nhwindows(int* argc, char** argv);
void ios_askname(void);
void ios_player_selection(void);
void ios_get_nh_event(void);
void ios_exit_nhwindows(const char *str);
void ios_suspend_nhwindows(const char *str);
void ios_resume_nhwindows(void);
winid ios_create_nhwindow(int type);
void ios_clear_nhwindow(winid wid);
void ios_display_nhwindow(winid wid, BOOLEAN_P block);
void ios_destroy_nhwindow(winid wid);
void ios_curs(winid wid, int x, int y);
void ios_putstr(winid wid, int attr, const char *text);
void ios_display_file(const char *filename, BOOLEAN_P must_exist);
void ios_start_menu(winid wid);
void ios_add_menu(winid wid, int glyph, const ANY_P *identifier,
					 CHAR_P accelerator, CHAR_P group_accel, int attr, 
					 const char *str, BOOLEAN_P presel);
void ios_end_menu(winid wid, const char *prompt);
int ios_select_menu(winid wid, int how, menu_item **menu_list);
void ios_update_inventory(void);
void ios_mark_synch(void);
void ios_wait_synch(void);
void ios_cliparound(int x, int y);
void ios_cliparound_window(winid wid, int x, int y);
void ios_print_glyph(winid wid, XCHAR_P x, XCHAR_P y, int glyph);
void ios_raw_print(const char *str);
void ios_raw_print_bold(const char *str);
int ios_nhgetch(void);
int ios_nh_poskey(int *x, int *y, int *mod);
void ios_nhbell(void);
int ios_doprev_message(void);
char ios_yn_function(const char *question, const char *choices, CHAR_P def);
void ios_getlin(const char *prompt, char *line);
int ios_get_ext_cmd(void);
void ios_number_pad(int num);
void ios_delay_output(void);
void ios_start_screen(void);
void ios_end_screen(void);
void ios_outrip(winid wid, int how);

extern boolean ios_getpos;

coord CoordMake(xchar i, xchar j);

#ifdef __OBJC__

@interface WiniOS : NSObject {}

+ (const char *)baseFilePath;
+ (void)expandFilename:(const char *)filename intoPath:(char *)path;

@end

#endif