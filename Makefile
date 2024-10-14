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

# Règles
all: $(LIB_NAME)

$(LIB_NAME): $(ASM_OBJS)
	@ar rcs $(LIB_NAME) $(ASM_OBJS)
	@echo "Librairie $(LIB_NAME) créée avec succès."

# Compilation des fichiers .s en .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	@$(NASM) $(ASMFLAGS) $< -o $@
	@echo "Assemblage de $< terminé."

# Création du dossier des objets si inexistant
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Compilation des fichiers bonus
bonus: $(LIB_NAME) $(BONUS_OBJS)
	@ar rcs $(LIB_NAME) $(BONUS_OBJS)
	@echo "Librairie $(LIB_NAME) avec bonus compilée."

# Compilation des fichiers .s bonus en .o dans le dossier bonus_objets
$(BONUS_OBJ_DIR)/%_bonus.o: $(SRC_DIR)/%_bonus.s | $(BONUS_OBJ_DIR)
	@$(NASM) $(ASMFLAGS) $< -o $@
	@echo "Assemblage du bonus $< terminé."

# Création du dossier des objets bonus si inexistant
$(BONUS_OBJ_DIR):
	@mkdir -p $(BONUS_OBJ_DIR)

# Compilation et exécution du test avec main.c
test: $(LIB_NAME) $(MAIN)
	@$(CC) $(CFLAGS) $(LDFLAGS) -o $(NAME) $(MAIN) $(LIB_NAME)
	@echo "Compilation de $(NAME) terminée."
	@echo "Exécution des tests :"
	@./$(NAME)

# Nettoyage des objets
clean:
	@rm -rf $(OBJ_DIR) $(BONUS_OBJ_DIR)
	@echo "Dossiers $(OBJ_DIR) et $(BONUS_OBJ_DIR) supprimés."

# Nettoyage complet (objets + exécutable + librairie)
fclean: clean
	@rm -f $(NAME) $(LIB_NAME) test_file.txt
	@echo "Fichiers $(NAME) et $(LIB_NAME) supprimés."

# Recompiler tout
re: fclean all
