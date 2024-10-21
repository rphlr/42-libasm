# **************************************************************************** #
#                                                                              #
#                             Makefile Configuration                           #
#                                                                              #
# **************************************************************************** #

# Variables
CC = gcc
NASM = nasm
CFLAGS = -Wall -Wextra -Werror
ASMFLAGS = -f macho64
LDFLAGS = -Wl,-no_pie

# Dossiers
SRC_DIR = srcs
OBJ_DIR = objets
BONUS_OBJ_DIR = bonus_objets
LIB_NAME = libasm.a
MAIN = main.c
NAME = asm_test

# Récupérer tous les fichiers .s et les bonus
ASM_SRCS = $(filter-out %_bonus.s, $(wildcard $(SRC_DIR)/*.s))
BONUS_SRCS = $(wildcard $(SRC_DIR)/*_bonus.s)

# Fichiers objets pour les sources et les bonus
ASM_OBJS = $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(ASM_SRCS))
BONUS_OBJS = $(patsubst $(SRC_DIR)/%_bonus.s, $(BONUS_OBJ_DIR)/%_bonus.o, $(BONUS_SRCS))

# Terminal colors
RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
MAGENTA = \033[1;35m
CYAN = \033[1;36m
GRAY = \033[1;90m
RESET = \033[0m
BOLD = \033[1m

# Escape sequences for overwriting lines
ERASE_LINE = \033[2K
MOVE_UP = \033[1A

# Rules

all: $(LIB_NAME)
	@echo "$(GREEN)┌──────────────────────────────────────────────────────────────────────────┐$(RESET)"
	@echo "$(GREEN)│ $(BOLD)Compilation finished!$(RESET)                                                    $(GREEN)│$(RESET)"
	@echo "$(GREEN)└──────────────────────────────────────────────────────────────────────────┘$(RESET)"

$(LIB_NAME): $(ASM_OBJS)
	@ar rcs $(LIB_NAME) $(ASM_OBJS)
	@echo "$(CYAN)Librairie $(LIB_NAME) créée avec succès.$(RESET)"

# Compilation des fichiers .s en .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	@$(NASM) $(ASMFLAGS) $< -o $@
	@echo "$(YELLOW)Assemblage de $< terminé.$(RESET)"
	@echo "$(MOVE_UP)$(ERASE_LINE)$(YELLOW)Assemblage de $< terminé.$(RESET)"

# Création du dossier des objets si inexistant
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Compilation des fichiers bonus
bonus: $(LIB_NAME) $(BONUS_OBJS)
	@ar rcs $(LIB_NAME) $(BONUS_OBJS)
	@echo "$(MAGENTA)Librairie $(LIB_NAME) avec bonus compilée.$(RESET)"

# Compilation des fichiers .s bonus en .o dans le dossier bonus_objets
$(BONUS_OBJ_DIR)/%_bonus.o: $(SRC_DIR)/%_bonus.s | $(BONUS_OBJ_DIR)
	@$(NASM) $(ASMFLAGS) $< -o $@
	@echo "$(YELLOW)Assemblage du bonus $< terminé.$(RESET)"
	@echo "$(MOVE_UP)$(ERASE_LINE)$(YELLOW)Assemblage du bonus $< terminé.$(RESET)"

# Création du dossier des objets bonus si inexistant
$(BONUS_OBJ_DIR):
	@mkdir -p $(BONUS_OBJ_DIR)

# Compilation et exécution du test avec main.c
test: $(LIB_NAME) $(MAIN)
	@echo "$(BLUE)Compilation de $(NAME)...$(RESET)"
	@$(CC) $(CFLAGS) $(LDFLAGS) -o $(NAME) $(MAIN) $(LIB_NAME)
	@echo "$(GREEN)Compilation de $(NAME) terminée.$(RESET)"
	@echo "$(BLUE)Exécution des tests :$(RESET)"
	@./$(NAME)

# Nettoyage des objets
clean:
	@rm -rf $(OBJ_DIR) $(BONUS_OBJ_DIR)
	@echo "$(RED)Dossiers $(OBJ_DIR) et $(BONUS_OBJ_DIR) supprimés.$(RESET)"

# Nettoyage complet (objets + exécutable + librairie)
fclean: clean
	@rm -f $(NAME) $(LIB_NAME) test_file.txt
	@echo "$(RED)Fichiers $(NAME) et $(LIB_NAME) supprimés.$(RESET)"

# Recompiler tout
re: fclean all
