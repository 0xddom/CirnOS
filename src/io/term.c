#include <io/term.h>
#include <libc/string.h>
#include <io/io.h>

#define xy2i(x,y) y * VGA_WIDTH + x

#define NEWLINE 0x0a
#define RETCARR 0x0d

#define TAB		0x09
#define TABSIZ	4

static term_t term;

void term_init () {
	term.row = term.col = 0;
	term.color = DEFAULT_COLOR;
	term.buffer = FRAMEBUFFER_ADDR;
	size_t y, x;

	for (y = 0; y < VGA_HEIGHT; y++) {
		for (x = 0; x < VGA_WIDTH; x++) {
			const size_t i = xy2i (x,y);
			term.buffer[i] = make_vgaentry (' ', term.color);
		}
	}
}

void term_setcolor (color_t color) {
	term.color = color;
}

void term_putentry_at (char c, color_t color, size_t x, size_t y) {
	term.buffer[xy2i (x,y)] = make_vgaentry (c, color);
}

void term_putchar (char c) {
	term_putentry_at (c, term.color, term.col, term.row);
	if (++term.col == VGA_WIDTH) {
		term.col = 0;
		if (++term.row == VGA_HEIGHT) {
			term.row = 0;
		}
	}
	term_move_cursor ();
}

void term_writechar(char c) {
	switch (c) {
	case NEWLINE:
		term.row++;
		term.col = 0;
		term_move_cursor ();
		break;
	case RETCARR:
		term.col = 0;
		term_move_cursor ();
		break;
	case TAB:
		term_writestr ("    ");
		break;
	default:
		term_putchar (c);
	}
}

void term_writestr (const char *str) {
	size_t len = strlen (str);
	size_t i;
	for (i = 0; i < len; i++) 
		term_writechar (str[i]);
}

void term_move_cursor () {
	term_move_cursor_at (term.col, term.row);
}

void term_move_cursor_at (size_t x, size_t y) {
	uint8_t pos = xy2i (x, y);
	io_send_byte (FB_COMMAND_PORT, FB_HIGH_BYTE_COMMAND);
	io_send_byte (FB_DATA_PORT, ((pos >> 8) & 0x00FF));
	io_send_byte (FB_COMMAND_PORT, FB_LOW_BYTE_COMMAND);
	io_send_byte (FB_DATA_PORT, pos & 0x00FF);
}
