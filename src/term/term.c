#include <term/term.h>
#include <libc/string.h>

#define xy2i(x,y) y * VGA_WIDTH + x

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

void term_putentryat (char c, color_t color, size_t x, size_t y) {
	term.buffer[xy2i (x,y)] = make_vgaentry (c, color);
}

void term_putchar (char c) {
	term_putentryat (c, term.color, term.col, term.row);
	if (++term.col == VGA_WIDTH) {
		term.col = 0;
		if (++term.row == VGA_HEIGHT) {
			term.row = 0;
		}
	}
}

void term_writestr (const char *str) {
	size_t len = strlen (str);
	size_t i;
	for (i = 0; i < len; i++) 
		term_putchar (str[i]);
}
