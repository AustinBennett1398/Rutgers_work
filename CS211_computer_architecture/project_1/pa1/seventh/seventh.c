#include <stdio.h>
#include <string.h>
int main (int argc, char** argv){	for(int i = 1; i < argc; i++)		printf("%c", argv[i][strlen(argv[i])-1]); return 0;}
