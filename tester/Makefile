NAME = tester

SRC = main.cpp

OBJ = $(SRC:.cpp=.o)

all: $(NAME)

$(NAME): $(OBJ)
	g++ -o $(NAME) $(OBJ) -L.. -lasm 


$(OBJ): $(SRC)
	g++ -c $(SRC) -o $(OBJ) 

clean: 
	rm -f $(NAME)

re: clean all


.PHONY: all clean re