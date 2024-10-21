#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

// Déclaration des fonctions ASM
size_t  ft_strlen(const char *s);
char    *ft_strcpy(char *dest, const char *src);
int     ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
char    *ft_strdup(const char *s);

#define BLUE "\033[1;34m"
#define YELLOW "\033[1;33m"
#define MAGENTA "\033[1;35m"
#define CYAN "\033[1;36m"
#define GRAY "\033[1;90m"
#define LIGHT_RED "\033[1;91m"
#define LIGHT_GREEN "\033[1;92m"
#define RESET "\033[0m"

void print_section_header(const char *color, const char *title) {
    printf("%s┌──────────────────────────────────────────────────────────────────────────┐\n", color);
    printf("│ %-72s │\n", title);
    printf("└──────────────────────────────────────────────────────────────────────────┘%s\n", RESET);
}

void print_test_header(const char *color, const char *title) {
    printf("\n%s=== %s ===%s\n", color, title, RESET);
}

void test_ft_strlen() {
    print_test_header(BLUE, "Test ft_strlen");
    print_section_header(BLUE, "Testing string length");
    printf("ft_strlen(\"\"): %zu (expected: 0)\n", ft_strlen(""));
    printf("ft_strlen(\"Hello\"): %zu (expected: 5)\n", ft_strlen("Hello"));
    printf("ft_strlen(\"Hello, world!\"): %zu (expected: 13)\n", ft_strlen("Hello, world!"));
    printf("ft_strlen(\"This is a longer string, just for testing purposes!\"): %zu (expected: 47)\n", ft_strlen("This is a longer string, just for testing purposes!"));
}

void test_ft_strcpy() {
    char dest[100];
    print_test_header(YELLOW, "Test ft_strcpy");
    print_section_header(YELLOW, "Copying strings");
    printf("ft_strcpy(dest, \"Hello\"): %s (expected: Hello)\n", ft_strcpy(dest, "Hello"));
    printf("ft_strcpy(dest, \"World\"): %s (expected: World)\n", ft_strcpy(dest, "World"));
    printf("ft_strcpy(dest, \"This is a longer test string.\"): %s (expected: This is a longer test string.)\n", ft_strcpy(dest, "This is a longer test string."));
    printf("ft_strcpy(dest, \"\"): %s (expected: empty string)\n", ft_strcpy(dest, ""));
}

void test_ft_strcmp() {
    print_test_header(MAGENTA, "Test ft_strcmp");
    print_section_header(MAGENTA, "Comparing strings");
    printf("ft_strcmp(\"abc\", \"abc\"): %d (expected: 0)\n", ft_strcmp("abc", "abc"));
    printf("ft_strcmp(\"abc\", \"abd\"): %d (expected: negative)\n", ft_strcmp("abc", "abd"));
    printf("ft_strcmp(\"abd\", \"abc\"): %d (expected: positive)\n", ft_strcmp("abd", "abc"));
    printf("ft_strcmp(\"\", \"\"): %d (expected: 0)\n", ft_strcmp("", ""));
    printf("ft_strcmp(\"a\", \"\"): %d (expected: positive)\n", ft_strcmp("a", ""));
    printf("ft_strcmp(\"\", \"a\"): %d (expected: negative)\n", ft_strcmp("", "a"));
    printf("ft_strcmp(\"long string with same start\", \"long string with different end!\"): %d (expected: negative)\n", ft_strcmp("long string with same start", "long string with different end!"));
}

void test_ft_write() {
    print_test_header(CYAN, "Test ft_write");
    print_section_header(CYAN, "Writing to file descriptors");
    ssize_t ret;

    ret = ft_write(1, "Hello, world!\n", 14);
    printf("ft_write(1, \"Hello, world!\\n\", 14): %zd (expected: 14)\n", ret);

    ret = ft_write(1, "", 0);  // Write nothing
    printf("ft_write(1, \"\", 0): %zd (expected: 0)\n", ret);

    ret = ft_write(-1, "Hello", 5);  // Invalid file descriptor
    perror("ft_write avec fd invalide");
    printf("ft_write(-1, \"Hello\", 5): %zd (expected: -1)\n", ret);
}

void test_ft_read() {
    print_test_header(GRAY, "Test ft_read");
    print_section_header(GRAY, "Reading from file descriptors");
    char buffer[100];
    ssize_t ret;

    int fd = open("test_file.txt", O_CREAT | O_RDWR, 0644);
    if (fd == -1) {
        perror("open");
        return;
    }

    write(fd, "Hello, world!", 13);
    lseek(fd, 0, SEEK_SET);

    ret = ft_read(fd, buffer, 13);
    if (ret != -1) {
        buffer[ret] = '\0';
        printf("ft_read(fd, buffer, 13): %zd, buffer: \"%s\" (expected: \"Hello, world!\")\n", ret, buffer);
    } else {
        perror("ft_read");
    }

    ret = ft_read(-1, buffer, 5);  // Invalid file descriptor
    perror("ft_read avec fd invalide");
    printf("ft_read(-1, buffer, 5): %zd (expected: -1)\n", ret);

    close(fd);
}

void test_ft_strdup() {
    print_test_header(LIGHT_RED, "Test ft_strdup");
    print_section_header(LIGHT_RED, "Duplicating strings");
    char *dup;

    dup = ft_strdup("Hello");
    if (dup) {
        printf("ft_strdup(\"Hello\"): %s (expected: Hello)\n", dup);
        free(dup);
    }

    dup = ft_strdup("");
    if (dup) {
        printf("ft_strdup(\"\"): \"%s\" (expected: empty string)\n", dup);
        free(dup);
    }

    dup = ft_strdup("A much longer string for strdup testing purposes, just to make sure it handles larger allocations.");
    if (dup) {
        printf("ft_strdup(\"A much longer string...\"): %s\n", dup);
        free(dup);
    }
}

int main() {
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();
    return 0;
}
