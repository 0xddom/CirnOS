#include <vga.h>

typedef struct {
	size_t row;
	size_t col;
	color_t color;
	vgaentry_t *buffer;
} term_t;

void term_init(void);
void term_setcolor(color_t color);
void term_putentryat(char c, color_t color, size_t x, size_t y);
void term_putchar(char c);
void term_writestr(const char *str);
