NAME			=	main
LIB				=	libasm.a
CLASS			=	ft_strlen.s ft_write.s ft_read.s ft_strcpy.s ft_strdup.s ft_strcmp.s
SRC				=	$(addprefix lib/, $(CLASS))

MAIN			=	main.s 

SOURCES_DIR		=	.

OBJ_DIR			=	obj

SOURCES			=	$(addprefix $(SOURCES_DIR)/, $(SRC))

OBJS			=	$(SOURCES:$(SOURCES_DIR)/%.s=$(OBJ_DIR)/%.o)


$(OBJS): $(OBJ_DIR)

$(OBJ_DIR)/%.o:   $(SOURCES_DIR)/%.s
	nasm -f elf64 $< -o $@  

all: $(LIB) $(NAME)

$(NAME):  $(OBJ_DIR) $(LIB)
	nasm  -f elf64 $(MAIN) -o $(MAIN:%.s=$(OBJ_DIR)/%.o)
	gcc -fPIE -pie -nostartfiles -o $(NAME) ./obj/main.o -L. -lasm  


$(OBJ_DIR): 
	mkdir -p $(OBJ_DIR)
	mkdir -p $(addprefix $(OBJ_DIR)/, lib)

$(LIB):  $(OBJS) 
	ar rc $(LIB) $^
	ranlib $(LIB)

clean:
					rm -rf $(OBJ_DIR)

fclean:				clean
					rm -rf $(NAME)
					rm -rf $(LIB)
					make -C tester fclean

re:					fclean all

test: fclean $(LIB)
	make -C tester re && ./tester/tester

.PHONY:				all clean fclean re test