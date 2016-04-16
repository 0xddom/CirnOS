#include <stddef.h>
//#include <stdint.h>
#include <libc/types.h>

typedef char color_t;
typedef short int vgaentry_t;

enum vga_color {
	COLOR_BLACK = 0,
	COLOR_BLUE = 1,
	COLOR_GREEN = 2,
	COLOR_CYAN = 3,
	COLOR_RED = 4,
	COLOR_MAGENTA = 5,
	COLOR_BROWN = 6,
	COLOR_LIGHT_GREY = 7,
	COLOR_DARK_GREY = 8,
	COLOR_LIGHT_BLUE = 9,
	COLOR_LIGHT_GREEN = 10,
	COLOR_LIGHT_CYAN = 11,
	COLOR_LIGHT_RED = 12,
	COLOR_LIGHT_MAGENTA = 13,
	COLOR_LIGHT_BROWN = 14,
	COLOR_WHITE = 15
};

color_t make_color(enum vga_color fg, enum vga_color bg);
vgaentry_t make_vgaentry(char c, color_t color);

#define DEFAULT_COLOR make_color (COLOR_LIGHT_GREY, COLOR_BLACK)
#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define FRAMEBUFFER_ADDR (vgaentry_t*) 0xB8000
