#define SYS_WRITE 1
#define SYS_EXIT 60
#define STDOUT 1

void sys_write(int fd, const void *buf, unsigned long count) {
    asm volatile (
        "syscall"
        :
        : "a"(SYS_WRITE), "D"(fd), "S"(buf), "d"(count)
        : "rcx", "r11", "memory"
    );
}

void sys_exit(int status) {
    asm volatile (
        "syscall"
        :
        : "a"(SYS_EXIT), "D"(status)
        : "rcx", "r11"
    );
}

unsigned long get_len(const char *s) {
    unsigned long len = 0;
    while (s[len]) {
        len++;
    }

    return len;
}
