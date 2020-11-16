#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*1. If the word begins with a consonant then take all the letters up until the first vowel and put
them at the end and then add “ay” at the end.
2. If the word begins with a vowel then simply add “yay” to the end.
*/


// strcat to concatenate to the end;
// strpbrk to find the first vowel in the word
// strncpy
//argc = number of words + 1
//argv starts at [1] for first word
int main (int argc, char** argv)
{
	int test = 0;
	int i, j, k;
	char c;
	char* s = NULL; 
	char* s2 = NULL;
	s = ("yay");
	s2 = ("ay");
	
	//Create own holder for argv strings
	char** wordList = (char**) malloc(sizeof(char*) * (argc-1));
	for(i = 0; i < argc-1; i++)
		wordList[i] = (char*) malloc(sizeof(char) * (strlen(argv[i]) + 0));
		
	//Populate holder with argv strings
	for(i = 0; i < argc-1; i++)
	{
		wordList[i] = argv[i+1];
	}
		
	for(i = 0; i < argc-1; i++)
	{
		c = wordList[i][0];
		//First letter vowel
		if(c == 'a' || c == 'A' || c == 'e' || c == 'E' || c == 'i' || c == 'I' || c == 'o' || c == 'O' || c == 'u' || c == 'U')
		{
			char* vowelSub = (char*) malloc(sizeof(char) * (strlen(wordList[i]) + 4));
			//int x = strlen(wordList[i]);
			//printf("%d", x);
			for(j = 0; j < strlen(wordList[i]); j++)
				vowelSub[j] = wordList[i][j];
			strcat(vowelSub, s);
			wordList[i] = vowelSub;
			//free(vowelSub);
			
			
			//strcat(wordList[i], s);
		}		
		//First letter consonant
		else
		{
			for(j = 0; j < strlen(wordList[i]); j++)
			{
				c = wordList[i][j];
				if(c == 'a' || c == 'A' || c == 'e' || c == 'E' || c == 'i' 
				|| c == 'I' || c == 'o' || c == 'O' || c == 'u' || c == 'U')
				{
					//remove the first j elements and add them to the end of the string, then add ay
					//Allocate space for the first jth elements, plus an additional 3 for ay and \0
					char* sub1 = (char*) malloc(sizeof(char) * (j + 3));
					//Allocate space
					char* sub2 = (char*) malloc(sizeof(char) * (strlen(wordList[i]) + 3));
					
					for(k = 0; k < j; k++)
					{
						sub1[k] = wordList[i][k];	
					}
					strcat(sub1, s2);
					
					for(k = 0; k < (strlen(wordList[i]) - j); k++)
					{
						sub2[k] = wordList[i][k+j];
					}
					
					//printf("Substring 1 = \033[1;31m%s\n\033[0m", sub1);
					//printf("Substring 2 = \033[1;31m%s\n\033[0m", sub2);
					strcat(sub2, sub1);
					//strcpy(wordList[i], sub2);
					wordList[i] = sub2;
					//free(sub1);
					//free(sub2);
					test = 1;
					break;
				}
			}
			if(test == 0)
				strcat(wordList[i], s2);
		}
	}
	
	//printf("Concatenated Word = \033[1;31m%s\033[0m", wordList[i]);
	
	for(i = 0; i < argc-1; i++)
		printf("%s ", wordList[i]);
	printf("\n");
	/*for(i = 0; i < argc-1; i++)
		free(wordList[i]);*/
	//free(wordList);
	return 0;
}

