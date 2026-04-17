#include "../funcs.h"

void _start(void) {
    const char hello[] = "Hello, world!\n";
    sys_write(STDOUT, hello, get_len(hello));
    sys_exit(0);
}
