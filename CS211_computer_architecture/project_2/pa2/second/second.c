#include <stdio.h>
#include <stdlib.h>

int completeChecker(int**, int);
int validPoint(int**, int, int, int, int, int);
int validMatrix(int **, int, int, int, int); 
void matrixPrint(int**, int, int);

//Return 1 for complete and 0 for incomplete
int completeChecker(int** puzzle, int n)
{
	int i,j;
	for(i = 0; i < n; i++)
		for(j = 0; j < n; j++)
			if(puzzle[i][j] == 0)
				return 0;
	return 1;
}


int validPuzzle(int** puzzle, int n)
{
	int i,j;

	for(i = 0; i < n; i++)
		for(j = 0; j < n; j++)
			if(puzzle[i][j] != 0)
				if(validPoint(puzzle, n, i, j, puzzle[i][j], 1) == 0)
					return 0;
	return 1;

}

//return 1 for valid 0 for invalid
int validPoint(int** puzzle,int n ,int row, int col, int numToCheck, int validPuzzle)
{
	int i,j;
	//An individual point is valid
	if(puzzle[row][col] != 0 && validPuzzle == 0)
		return 0;
	for(i = 0; i < n; i++)
		if(puzzle[i][col] == numToCheck && i != row)
			return 0;
	for(j = 0; j < n; j++)
		if(puzzle[row][j] == numToCheck && j != col)
			return 0;
	for(i = ((row/3)*3); i <= ((row/3)*3)+2; i++)
		for(j = ((col/3)*3); j <= ((col/3)*3)+2; j++)
			if(puzzle[i][j] == numToCheck && i != row && j != col)
				return 0;
	return 1;
	//Confirm that it is the only valid point in the entire square
	//if(validMatrix(puzzle, n, row, col, numToCheck) == 1)
		//return 1;
	//else 
	//	return 0;
}

void matrixPrint(int** inMatrix, int row, int col)
{
	int i,j;
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

int main(int argc, char** argv)
{
	int n = 9;
	int x;
	int i,j, temp;
	FILE *fp;
 	fp = fopen(argv[1], "r");
	if(fp == NULL)
	{
		printf("error\n");
 		return 0;
	}
	
	int** puzzle = (int**) malloc(sizeof(int*) * n);
	for(i = 0; i < n; i++)
		puzzle[i] = (int*) malloc(sizeof(int) * n);
	for(i = 0; i < n; i++)
		for(j = 0; j < n; j++)
		{
			temp = 0;
			fscanf(fp, "%d ", &temp);
			puzzle[i][j] = temp;
		}
	
	
	/*int validSum = 0;
	int validNum = 0;
	for(x = 1; x <= n; x++)
	{		
		if(validPoint(puzzle, n, 4, 3, x) == 0)
			printf("invalid\n");
		else
		{
			printf("valid\n");
			validNum = x;
			validSum++;
		}
	}
	if(validSum == 1)
	{
		printf("inserted\n");
		puzzle[4][3] = validNum;
	}*/
	//while(completeChecker(puzzle, n) == 0)
	int counter = 0;
	int validSum;
	int validNum;
	if(validPuzzle(puzzle, n) == 1)
	{
		while(counter <= 1000)
		{
			for(i = 0; i < n; i++)
				for(j = 0; j < n; j++)
				{
					validSum = 0;
					validNum = 0;
					for(x = 1; x <= n; x++)
					{		
						if(validPoint(puzzle, n, i, j, x, 0) == 1)
						{
							validNum = x;
							validSum++;
						}
					}
					if(validSum == 1)
					{	
						puzzle[i][j] = validNum;
					}
				}

			counter++;
		}
		matrixPrint(puzzle, n, n);
	}
	else
	{
		printf("no-solution\n");
	}
	fclose(fp);
	
	return 0;
}
