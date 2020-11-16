#include <stdio.h>
#include <stdlib.h>
int i, j, k;

double** matrixTranspose(double**, int, int);
double** matrixMultiplication(double**, double**, int, int, int, int);
double** matrixInverse(double**, int, int);
void matrixPrint(double**, int, int);
void cleanse(double**, int);

void cleanse(double** inMatrix, int row)
{
	for(i = 0; i < row; i++)
		free(inMatrix[i]);
	free(inMatrix);
}

double** matrixTranspose(double** inMatrix, int row, int col)
{
	double** matrixTransposed = (double**) malloc(sizeof(double*) * col);
	for(i = 0; i < col; i++)
		matrixTransposed[i] = (double*) malloc(sizeof(double) * row);
	for(i = 0; i < row; i++)
		for(j = 0; j < col; j++)
			matrixTransposed[j][i] = inMatrix[i][j];

	return matrixTransposed;
}

double** matrixMultiplication(double** matrix1, double** matrix2, int row1, int row2, int col1, int col2)
{
	int i, j, k;
	//Create resultant matrix
	double** resultant = (double**) malloc(sizeof(double*) * row1);
	for(i = 0; i < row1; i++)
		resultant[i] = (double*) malloc(sizeof(double) * col2);
	
	for(i = 0; i < row2; i++)
		for(j = 0; j < row1; j++)
			for(k = 0; k < col2; k++)
				resultant[j][k] = resultant[j][k] + (matrix1[j][i] * matrix2[i][k]);
			
	return resultant;
}

double** matrixInverse(double** inMatrix, int row, int col)
{
	double** inverseMatrix = (double**) malloc(sizeof(double*) * row);
	for(i = 0; i < row; i++)
		inverseMatrix[i] = (double*) malloc(sizeof(double) * ((col)*2));
	//Copy original matrix to inverse matrix
	for(i = 0; i < row; i++)
		for(j = 0; j < col; j++)
			inverseMatrix[i][j] = inMatrix[i][j];
	//Add augmented part of matrix		
	for(i = 0; i < row; i++)
		for(j = col; j < col*2; j++)
		{
			if(i+col == j)
				inverseMatrix[i][j] = (double) 1.000000;
			else
				inverseMatrix[i][j] = (double) 0.000000;
		}
		
		
	//Bottom triangle
	double diff = 0;
	for(i = 0; i < row; i++)
		for(j = 0; j <= i; j++)
		{
			if(i == j && inverseMatrix[i][j] != 1)
			{
				diff = 1/inverseMatrix[i][j];
				for(k = 0; k < col*2; k++)
					inverseMatrix[i][k] = inverseMatrix[i][k] * diff;
			}
			else if(i != j && inverseMatrix[i][j] != 0)
			{
				diff = inverseMatrix[i][j];
				for(k = 0; k < col*2; k++)
					inverseMatrix[i][k] = inverseMatrix[i][k] - diff*inverseMatrix[j][k];
			}
		}
	
	//Upper triangle
	for(i = row-2; i >= 0; i--)
		for(j = col-1; j > i; j--)
		{
			diff = inverseMatrix[i][j];
			for(k = 0; k < col*2; k++)
				inverseMatrix[i][k] = inverseMatrix[i][k] - diff*inverseMatrix[j][k];
		}
		
	for(i = 0; i < row; i++)
		for(j = 0; j < col; j++)
			inMatrix[i][j] = inverseMatrix[i][j+col];
	
	return inMatrix;
}

void matrixPrint(double** inMatrix, int row, int col)
{
	for(i = 0; i < row; i++)
	{
		if(i != 0)
			printf("\n");
		for(j = 0; j < col; j++)
			printf("%0.0lf", inMatrix[i][j]);
	}
	printf("\n");
	return;
}

int main (int argc, char** argv)
{
	int N, M, K;
 	
 	FILE *fp, *fp2;
 	fp = fopen(argv[1], "r");
 	fp2 = fopen(argv[2], "r");
	if(fp == NULL || fp2 == NULL)
	{
		printf("error\n");
 		return 0;
	}
	fscanf(fp2, "%d", &M);
	fscanf(fp, "%d", &K);
	fscanf(fp, "%d", &N);
	
	double** Y = (double**) malloc(sizeof(double*) * N);
	for(i = 0; i < N; i++)
		Y[i] = (double*) malloc(sizeof(double));
		
	double** X = (double**) malloc(sizeof(double*) * N);
	for(i = 0; i < N; i++)
		X[i] = (double*) malloc(sizeof(double) * (K+1));
		
	double** testX = (double**) malloc(sizeof(double*) * M);
	for(i = 0; i < M; i++)
		testX[i] = (double*) malloc(sizeof(double) * (K+1));
		
	for(i = 0; i < N; i++)
		for(j = 0; j < K+2; j++)
		{
			if(j == 0)
				X[i][j] = 1.0000000;
			else if(j == K+1)
				fscanf(fp, "%lf, ", &Y[i][0]);
			else
				fscanf(fp, "%lf, ", &X[i][j]);
		}
	for(i = 0; i < M; i++)
		for(j = 0; j < K+1; j++)
		{
			if(j == 0)
				testX[i][j] = 1.0000000;
			else
				fscanf(fp2, "%lf, ", &testX[i][j]);
		}
	double** xT = matrixTranspose(X, N, K+1);
	double** xTx = matrixMultiplication(xT, X, K+1, N, N, K+1);
	double** xTxInverse = matrixInverse(xTx, K+1, K+1);
	double** inverseXT = matrixMultiplication(xTxInverse, xT, K+1, K+1, K+1, N);
	double** W = matrixMultiplication(inverseXT, Y, K+1, N, N, 1);
	double** result = matrixMultiplication(testX, W, M, K+1, K+1, 1);
	matrixPrint(result, M, 1);
	cleanse(X, N);	cleanse(testX, M); cleanse(Y, N); cleanse(xT, K+1); cleanse(xTx, K+1); cleanse(inverseXT, K+1); cleanse(W, K+1); cleanse(result, M);
	fclose(fp);
	return 0;
}
