NAME = tester

SRC = main.cpp


all: $(NAME)

$(NAME):
	g++ -o $(NAME) $(SRC) -L.. -lasm
	

clean: 
	rm -f $(NAME)

re: clean all


.PHONY: all clean re