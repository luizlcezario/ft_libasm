// libasm.h

#ifndef LIBASM_H
#define LIBASM_H

#include <stddef.h>
#include <unistd.h>

extern "C" {
    int  ft_strlen(const char *s);
    ssize_t ft_write(int fd, const void *buf, size_t count);
    ssize_t ft_read(int fd, void *buf, size_t count);
}

#endif
