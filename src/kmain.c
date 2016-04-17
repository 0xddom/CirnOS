#include <io/term.h>
#include <cpu/cpu.h>

#define OS_NAME "CirnOS"
#define OS_VERSION "0.0.0"

static char *mascot = 
"\n"
"      #####\n"
"    ##     ##\n"
"   #         #\n"
"  #   #####   #\n"
"  #  #     #  #\n"
" #   #     #   #\n"
" #   #     #   #       " OS_NAME "\n"
" #    ######   #\n"
" #         #   #       " OS_VERSION "\n"
" #         #   #\n"
"  #  #     #  #\n"
"  #   #####   #\n"
"   #         #\n"
"    ##     ##\n"
"      #####\n";

static void init () {
	term_init ();
}

static void banner () {
	term_writestr (mascot);
	char cpu_name[13];
	cpu_vendor_name (cpu_name);
	term_writestr (cpu_name);
	term_writechar ('\n');
}

void kmain () {
	init ();
	banner ();
}
