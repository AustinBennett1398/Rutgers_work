#include <stdio.h>
#include <stdlib.h>
#define MAX 15

 int totalArraySize, oddArraySize;
 int evenArraySize = 0;

/*

First number is total number of numbers in txt
Sort evens and then odds, do not necessairily have the same amount of evens and odds

*/

void sort(int[]);

void sort(int inArray[])
{
	int temp,i,j;
	if(inArray[0] % 2 == 0)
		for(i = 0; i<evenArraySize; i++)
		{
			for(j = 0; j<evenArraySize; j++)
				if(inArray[j] > inArray[i])
				{	
					temp = inArray[i];
					inArray[i] = inArray[j];
					inArray[j] = temp;
				}
		}
	else
		for(i = 0; i<oddArraySize; i++)
		{
			for(j = 0; j<oddArraySize; j++)
				if(inArray[j] > inArray[i])
				{	
					temp = inArray[i];
					inArray[i] = inArray[j];
					inArray[j] = temp;
				}
		}
}

int main (int argc, char** argv)
{

//Start of file read
 int b, i;
 int tracker = 0;
 if(argc != 2)
 {
  printf("Not enough arguments\n");
  return 0;
 }
 FILE *fp;
 fp = fopen(argv[1], "r");
 if(fp == NULL) return 0;

 //char c = fgetc(fp);
 char c[MAX];
 fgets(c, MAX, fp);
 totalArraySize = atoi(c);
 int array[totalArraySize];

 while(fscanf(fp, "%d", &b) == 1)
 {
	if(b % 2 == 0)
		evenArraySize++;
	array[tracker] = b;
	tracker++;	
 } 
 //printf("%d\n", array[0]);
 //printf("Even Array Size: %d\n", evenArraySize);
 oddArraySize = totalArraySize - evenArraySize;
 //printf("Odd Array Size: %d\n", oddArraySize);

 tracker = 0;
 int evenArray[evenArraySize];
 for(i = 0; i<totalArraySize; i++)
 { 
	if(abs(array[i]) % 2 == 0)
	{
		evenArray[tracker] = array[i];
		tracker++;
	}
 }


 tracker = 0;
 int oddArray[oddArraySize];
 for(i = 0; i<totalArraySize; i++)
 { 
	if(abs(array[i]) % 2 == 1)
	{
		oddArray[tracker] = array[i];
		tracker++;
	}
 }

 sort(oddArray);
 sort(evenArray);

 for(i = 0; i<totalArraySize; i++)
 {
	if(i<evenArraySize)
		array[i] = evenArray[i];
	else
		array[i] = oddArray[i-evenArraySize];
 }

 for(i = 0; i<totalArraySize; i++)
	printf("%d\t", array[i]);
 
 
fclose(fp);
//End of file read


 return 0;
}
