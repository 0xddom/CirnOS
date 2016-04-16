#include <term.h>

void kmain () {
	term_init ();
	term_writestr ("Hello, kernel\n");
}
