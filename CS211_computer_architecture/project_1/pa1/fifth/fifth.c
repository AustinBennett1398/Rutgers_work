#include <stdio.h>
#include <stdlib.h>
#define MAX 15

int n;

int magicChecker(int, int**);

int magicChecker(int n, int** matrix)
{
 int i,j,k,l;
  int magicSum = 0;
 int sum = 0; int actualSum = 0;
 int duplicate = 0;
 for (i = 0; i<=n*n; i++){
 	actualSum += i;
 }
 for (i=0; i<n; i++)
 {
	magicSum +=  matrix[i][0];
	}

//Check for uniqueness
for(i = 0; i < n; i++)
	for(j = 0; j < n; j++)
		for(k = 0; k < n; k++)
			for(l = 0; l < n; l++)
			{
				if(matrix[i][j] == matrix[k][l])
				{
					//printf("matrix[%d][%d]: %d\n", i, j, matrix[i][j]);
					//printf("matrix[%d][%d]: %d\n\n", k, l, matrix[k][l]);
					duplicate++;
				}
			}
//printf("predup: %d\n", duplicate);
if(duplicate > n*n)
	return 0;
//printf("postdup\n");
	
//Check Major Diagnol
 sum = 0;
 for(i = 0; i<n; i++)
 {
	sum += matrix[i][i];
 }
 if(sum != magicSum)
 {
	return 0;
 }
 //printf("Major Diagnol sum: %d\n", sum);
//Check Minor Diagnol
 sum = 0; j = 0;
 for(i = n-1; i>=0; i--)
 {
	sum += matrix[i][j];
	j++;
 }
 if(sum != magicSum)
 {
	return 0;
 }
 //printf("Minor Diagnol sum: %d\n", sum);
//Checking rows
 sum = 0;
 for (i=0; i<n; i++)
 {
	for (j=0; j<n; j++)
	{
		sum += matrix[i][j];
	}
	if(sum != magicSum)
	{
		return 0;
	}
	//printf("Row%d sum: %d\n", i, sum);
	sum = 0;
 }
//Checking cols
//FILE1 BREAKING HERE
 sum = 0;
 for (j=0; j<n; j++)
 {
	for (i=0; i<n; i++)
	{
		sum += matrix[i][j];
	}
	if(sum != magicSum)
	{
		return 0;
	}
	//printf("Col%d sum: %d\n", j, sum);
	sum = 0;
 }
//Check diagnols and fix row/cols to produce correct output
return 1;
}




int main (int argc, char** argv)
{
//Start of file read
 int b, i, j;
 int** magicMatrix = NULL;
 
 if(argc != 2)
 {
  printf("Not enough arguments\n");
  return 0;
 }
 FILE *fp;
 fp = fopen(argv[1], "r");
 if(fp == NULL) return 0;

 char c[MAX];
 fgets(c, MAX, fp);
 n = atoi(c);
 //int magicMatrix[n][n];
 magicMatrix = (int **) malloc(sizeof(int*) * n);
 for(i = 0; i < n; i++)
 	magicMatrix[i] = (int *) malloc(sizeof(int) * n);
 i = 0; j = 0;
 while(fscanf(fp, "%d", &b) == 1)
 {
	magicMatrix[i][j] = b;
	j++;
	if(j == n)
	{
		j = 0;
		i++;
	}	
 } 

 if(magicChecker(n, magicMatrix) == 0)
 {
	printf("not-magic\n");
 }
 else
 {
	printf("magic\n");
 }
 
 for(i = 0; i < n; i++)
 {
 	free(magicMatrix[i]);
 }
 free(magicMatrix);
 
 
 /*for(i = 0; i<n; i++)
	for(j = 0; j<n; j++)
		printf("Matrix[%d][%d]: %d\n", i, j, magicMatrix[i][j]);*/
fclose(fp);
//End of file read


 return 0;
}
