#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>

// Déclarations des fonctions obligatoires
size_t ft_strlen(const char *s);
char *ft_strcpy(char *dest, const char *src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
char *ft_strdup(const char *s);

// Déclarations des fonctions bonus
int ft_atoi_base(char *str, char *base);
typedef struct s_list
{
    void *data;
    struct s_list *next;
} t_list;
void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);
void ft_list_sort(t_list **begin_list, int (*cmp)());
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

// Tests pour les fonctions obligatoires
void test_ft_strlen()
{
    printf("Test ft_strlen:\n");
    const char *str = "Hello, World!";
    printf("Longueur de '%s': %zu (attendu: %zu)\n", str, ft_strlen(str), strlen(str));
    printf("\n");
}

void test_ft_strcpy()
{
    printf("Test ft_strcpy:\n");
    const char *src = "Test de copie";
    char dest[20];
    printf("Résultat: '%s' (attendu: '%s')\n", ft_strcpy(dest, src), src);
    printf("\n");
}

void test_ft_strcmp()
{
    printf("Test ft_strcmp:\n");
    const char *s1 = "abc";
    const char *s2 = "abd";
    printf("Comparaison de '%s' et '%s': %d (attendu: %d)\n", s1, s2, ft_strcmp(s1, s2), strcmp(s1, s2));
    printf("\n");
}

void test_ft_write()
{
    printf("Test ft_write:\n");
    const char *str = "Test d'écriture\n";
    ssize_t ret = ft_write(1, str, strlen(str));
    printf("Retour: %zd (attendu: %zu)\n", ret, strlen(str));
    printf("Errno: %d\n", errno);
    printf("\n");
}

void test_ft_read()
{
    printf("Test ft_read:\n");
    char buffer[100];
    ssize_t ret = ft_read(0, buffer, sizeof(buffer));
    if (ret > 0)
    {
        buffer[ret] = '\0';
        printf("Lu: '%s'\n", buffer);
    }
    printf("Retour: %zd\n", ret);
    printf("Errno: %d\n", errno);
    printf("\n");
}

void test_ft_strdup()
{
    printf("Test ft_strdup:\n");
    const char *original = "Chaîne à dupliquer";
    char *duplicate = ft_strdup(original);
    printf("Original: '%s'\n", original);
    printf("Dupliqué: '%s'\n", duplicate);
    free(duplicate);
    printf("\n");
}

// Tests pour les fonctions bonus
void test_ft_atoi_base()
{
    printf("Test ft_atoi_base:\n");
    printf("'123' en base '0123456789': %d\n", ft_atoi_base("123", "0123456789"));
    printf("'1010' en base '01': %d\n", ft_atoi_base("1010", "01"));
    printf("'FF' en base '0123456789ABCDEF': %d\n", ft_atoi_base("FF", "0123456789ABCDEF"));
    printf("\n");
}

void print_list(t_list *list)
{
    while (list)
    {
        printf("%s -> ", (char *)list->data);
        list = list->next;
    }
    printf("NULL\n");
}

void free_list(t_list *list)
{
    t_list *tmp;
    while (list)
    {
        tmp = list;
        list = list->next;
        free(tmp->data);
        free(tmp);
    }
}

int cmp_str(void *a, void *b)
{
    return strcmp((char *)a, (char *)b);
}

void test_ft_list_push_front()
{
    printf("Test ft_list_push_front:\n");
    t_list *list = NULL;
    ft_list_push_front(&list, strdup("World"));
    ft_list_push_front(&list, strdup("Hello"));
    print_list(list);
    free_list(list);
    printf("\n");
}

void test_ft_list_size()
{
    printf("Test ft_list_size:\n");
    t_list *list = NULL;
    ft_list_push_front(&list, strdup("World"));
    ft_list_push_front(&list, strdup("Hello"));
    printf("Taille de la liste: %d\n", ft_list_size(list));
    free_list(list);
    printf("\n");
}

void test_ft_list_sort()
{
    printf("Test ft_list_sort:\n");
    t_list *list = NULL;
    ft_list_push_front(&list, strdup("World"));
    ft_list_push_front(&list, strdup("Hello"));
    ft_list_push_front(&list, strdup("OpenAI"));
    printf("Avant le tri: ");
    print_list(list);
    ft_list_sort(&list, cmp_str);
    printf("Après le tri: ");
    print_list(list);
    free_list(list);
    printf("\n");
}

void test_ft_list_remove_if()
{
    printf("Test ft_list_remove_if:\n");
    t_list *list = NULL;
    ft_list_push_front(&list, strdup("World"));
    ft_list_push_front(&list, strdup("Hello"));
    ft_list_push_front(&list, strdup("OpenAI"));
    ft_list_push_front(&list, strdup("Hello"));
    printf("Avant la suppression: ");
    print_list(list);
    ft_list_remove_if(&list, "Hello", cmp_str, free);
    printf("Après la suppression: ");
    print_list(list);
    free_list(list);
    printf("\n");
}

int main()
{
    // Tests des fonctions obligatoires
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();

    // Tests des fonctions bonus
    test_ft_atoi_base();
    test_ft_list_push_front();
    test_ft_list_size();
    test_ft_list_sort();
    test_ft_list_remove_if();

    return 0;
}