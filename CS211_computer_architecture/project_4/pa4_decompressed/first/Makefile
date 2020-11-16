all: first

first: first.c
	gcc -lm -g -Wall -Werror -fsanitize=address first.c -o first
clean:
	rm -rf first
