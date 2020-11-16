#include <stdio.h>
#include <stdlib.h>
int i, j;

int** matrixMultiplication(int**, int**, int, int, int, int);
void matrixPrint(int**, int, int);

void matrixPrint(int** inMatrix, int row, int col)
{
	for(i = 0; i < row; i++)
	{
		if(i != 0)
			printf("\n");
		for(j = 0; j < col; j++)
			printf("%d\t" , inMatrix[i][j]);
	}
	printf("\n");
	return;
}

int** matrixMultiplication(int** matrix1, int** matrix2, int row1, int row2, int col1, int col2)
{

	int i, j, k;
	//Create resultant matrix
	int** resultant = (int**) malloc(sizeof(int*) * row1);
	for(i = 0; i < row1; i++)
		resultant[i] = (int*) malloc(sizeof(int) * col2);
	
	
	for(i = 0; i < row2; i++)
	{
		for(j = 0; j < row1; j++)
		{
			for(k = 0; k < col2; k++)
			{
				//printf("resultant[%d][%d]: %d\n matrix1[%d][%d]: %d\n matrix2[%d][%d]: %d\n", j, k, resultant[j][k], j, i, matrix1[j][i], i, k, matrix2[i][k]);
				resultant[j][k] = resultant[j][k] + (matrix1[j][i] * matrix2[i][k]);
				//printf(" resultant[%d][%d]: %d\n\n", j, k, resultant[j][k]);
				//printf("i: %d\t j:%d\t k%d\t\n", i, j, k);
			}
		}
	}
			
	return resultant;
}

int main (int argc, char** argv)
{
	//int i, j;
	int row1, col1;
	int row2, col2;
	
 	if(argc != 2)
 	{
 		printf("Not enough arguments\n");
 		return 0;
 	}
 	
 	FILE *fp;
 	fp = fopen(argv[1], "r");

	if(fp == NULL)
	{
		printf("error\n");
 		return 0;
	}
	//Create and populate matrix1
	fscanf(fp, "%d %d\n", &row1, &col1);
	int** matrix1;		
	matrix1 = (int**) malloc(sizeof(int*) * row1);
	for(i = 0; i < row1; i++)
		matrix1[i] = (int*)malloc(sizeof(int) * col1);
	for(i = 0; i < row1; i++)
		for(j = 0; j < col1; j++)
			fscanf(fp, "%d", &matrix1[i][j]);
	
	//Create and populate matrix2
	fscanf(fp, "%d %d\n", &row2, &col2);		
	int** matrix2;		
	matrix2 = (int**) malloc(sizeof(int*) * row2);
	for(i = 0; i < row2; i++)
		matrix2[i] = (int*) malloc(sizeof(int) * col2);
	for(i = 0; i < row2; i++)
		for(j = 0; j < col2; j++)
			fscanf(fp, "%d", &matrix2[i][j]);
	//matrixPrint(matrix1, row1, col1);
	
	int** resultant = NULL;
	
	if(col1 == row2)
	{
		resultant = matrixMultiplication(matrix1, matrix2, row1, row2, col1, col2);	
		matrixPrint(resultant, row1, col2);
		
		for(i = 0; i < row1; i++)
	 	{
	 		free(resultant[i]);
	 	}
		free(resultant);
		resultant = NULL;
	}
	else
	{
		printf("bad-matrices");
	}
	
	
	for(i = 0; i < row1; i++)
 	{
 		free(matrix1[i]);
 	}
	free(matrix1);
	matrix1 = NULL;
	
	for(i = 0; i < row2; i++)
 	{
 		free(matrix2[i]);
 	}
	free(matrix2);
	matrix2 = NULL;
		
	fclose(fp);

 return 0;
}
