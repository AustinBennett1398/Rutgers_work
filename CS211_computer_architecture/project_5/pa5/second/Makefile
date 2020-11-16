all: second

second: second.c
	gcc -lm -g -Wall -Werror -fsanitize=address second.c -o second
clean:
	rm -rf second
