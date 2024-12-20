// libasm.h

#ifndef LIBASM_H
#define LIBASM_H

#include <stddef.h>
#include <unistd.h>

extern "C" {
    size_t  ft_strlen(const char *s);
    int     ft_write(int fd, const void *buf, size_t count);
    int     ft_read(int fd, void *buf, size_t count);
    char    *ft_strdup(const char *s);
    char    *ft_strcpy(char *dest, const char *src);
    int     ft_strcmp(const char *s1, const char *s2);
}

#endif
