NAME = libasm.a
BONUS_NAME = libasm_bonus.a

AS = as
AS_FLAGS = -arch arm64

CC = gcc
CFLAGS = -Wall -Wextra -Werror

AR = ar
AR_FLAGS = rcs

SRC = ft_strlen.s
# SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJ = $(SRC:.s=.o)

BONUS_SRC = ft_atoi_base_bonus.s ft_list_push_front_bonus.s ft_list_size_bonus.s ft_list_sort_bonus.s ft_list_remove_if_bonus.s
BONUS_OBJ = $(BONUS_SRC:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(AR_FLAGS) $@ $^

bonus: $(BONUS_NAME)

$(BONUS_NAME): $(OBJ) $(BONUS_OBJ)
	$(AR) $(AR_FLAGS) $@ $^

%.o: %.s
	$(AS) $(AS_FLAGS) $< -o $@

clean:
	rm -f $(OBJ) $(BONUS_OBJ)

fclean: clean
	rm -f $(NAME) $(BONUS_NAME) test_libasm

re: fclean all

test: $(NAME)
	$(CC) $(CFLAGS) -arch arm64 main.c -L. -lasm -o test_libasm
	./test_libasm

.PHONY: all bonus clean fclean re test