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
#define LIGHT_YELLOW "\033[1;93m"
#define LIGHT_BLUE "\033[1;94m"
#define LIGHT_MAGENTA "\033[1;95m"
#define LIGHT_CYAN "\033[1;96m"
#define RED "\033[1;31m"
#define GREEN "\033[1;32m"
#define RESET "\033[0m"

void test_ft_strlen() {
    printf(BLUE "\n=== Test ft_strlen ===\n" RESET);
    printf("ft_strlen(\"\"): %zu (expected: 0)\n", ft_strlen(""));
    printf("ft_strlen(\"Hello\"): %zu (expected: 5)\n", ft_strlen("Hello"));
    printf("ft_strlen(\"Hello, world!\"): %zu (expected: 13)\n", ft_strlen("Hello, world!"));
}

void test_ft_strcpy() {
    char dest[100];
    printf("\n" YELLOW "=== Test ft_strcpy ===\n" RESET);
    printf("ft_strcpy(dest, \"Hello\"): %s (expected: Hello)\n", ft_strcpy(dest, "Hello"));
    printf("ft_strcpy(dest, \"World\"): %s (expected: World)\n", ft_strcpy(dest, "World"));
}

void test_ft_strcmp() {
    printf("\n" MAGENTA "=== Test ft_strcmp ===\n" RESET);
    printf("ft_strcmp(\"abc\", \"abc\"): %d (expected: 0)\n", ft_strcmp("abc", "abc"));
    printf("ft_strcmp(\"abc\", \"abd\"): %d (expected: negative)\n", ft_strcmp("abc", "abd"));
    printf("ft_strcmp(\"abd\", \"abc\"): %d (expected: positive)\n", ft_strcmp("abd", "abc"));
    printf("ft_strcmp(\"\", \"\"): %d (expected: 0)\n", ft_strcmp("", ""));
    printf("ft_strcmp(\"a\", \"\"): %d (expected: positive)\n", ft_strcmp("a", ""));
    printf("ft_strcmp(\"\", \"a\"): %d (expected: negative)\n", ft_strcmp("", "a"));
}

void test_ft_write() {
    printf("\n" CYAN "=== Test ft_write ===\n" RESET);
    ssize_t ret;

    ret = ft_write(1, "Hello, world!\n", 14);
    printf("ft_write(1, \"Hello, world!\\n\", 14): %zd (expected: 14)\n", ret);

    // Test avec un file descriptor invalide
    ret = ft_write(-1, "Hello", 5);
    perror("ft_write avec fd invalide");
    printf("ft_write(-1, \"Hello\", 5): %zd (expected: -1)\n", ret);
}

void test_ft_read() {
    printf("\n" GRAY "=== Test ft_read ===\n" RESET);
    char buffer[100];
    ssize_t ret;

    int fd = open("test_file.txt", O_CREAT | O_RDWR, 0644);
    if (fd == -1) {
        perror("open");
        return;
    }

    // Écrire dans le fichier pour tester la lecture
    write(fd, "Hello, world!", 13);
    lseek(fd, 0, SEEK_SET);  // Revenir au début du fichier

    // Lecture avec ft_read
    ret = ft_read(fd, buffer, 13);
    if (ret != -1) {
        buffer[ret] = '\0';  // Ajout de la fin de chaîne
        printf("ft_read(fd, buffer, 13): %zd, buffer: \"%s\" (expected: \"Hello, world!\")\n", ret, buffer);
    } else {
        perror("ft_read");
    }

    // Test avec un file descriptor invalide
    ret = ft_read(-1, buffer, 5);
    perror("ft_read avec fd invalide");
    printf("ft_read(-1, buffer, 5): %zd (expected: -1)\n", ret);

    close(fd);
}

void test_ft_strdup() {
    printf("\n" LIGHT_RED "=== Test ft_strdup ===\n" RESET);
    char *dup;

    dup = ft_strdup("Hello");
    if (dup) {
        printf("ft_strdup(\"Hello\"): %s (expected: Hello)\n", dup);
        free(dup);
    } else {
        printf("ft_strdup(\"Hello\"): NULL (allocation error)\n");
    }

    dup = ft_strdup("");
    if (dup) {
        printf("ft_strdup(\"\"): \"%s\" (expected: empty string)\n", dup);
        free(dup);
    } else {
        printf("ft_strdup(\"\"): NULL (allocation error)\n");
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