#include <vga.h>

color_t make_color (enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

vgaentry_t make_vgaentry (char c, color_t color) {
	short int c16 = c;
	short int col16 = color;
	return c16 | col16 << 8;
}
