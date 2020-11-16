#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int i, k;

struct element
{
	int numSelectors;
	int numInputs;
	char identifier[100];
	char directive[100];
	char* input[100];
	char* output[100];
	int outputValue;
};

int graycode(int n, int numInput)
{
	int total = 0;
	int power = 0;
	for(i = 0; i < numInput; i++)
	{
		power = pow(2, i);
		if(i < (numInput-1))
			total += (((n>>i)%2) ^ (((n>>(i+1))%2))) * power;
		else
			total += ((n>>i)%2) * power;
	}
	return total;
}

int set(struct element** varList, char* name)
{
	int n = 0;
	while(strcmp(varList[n]->identifier, name) != 0)
	{
		n++;
	}
	return n;
}

void sort(struct element** varList, int len)
{
	int j, p; 
	struct element* temp = NULL;
	for(p = 2; p < len; p++)
	{
		for(i = 2; i < len; i++)
		{
			if(strcmp(varList[i]->directive, "MULTIPLEXER") != 0)
			{
				for(j = 0; j < varList[i]->numInputs; j++)
				{
					if(set(varList, varList[i]->input[j]) > i)
					{
						temp = varList[i];
						varList[i] = varList[i+1];
						varList[i+1] = temp;
						break;
					}
				}
			}
			else
			{
				for(j = 0; j < varList[i]->numSelectors; j++)
				{
					if(set(varList, varList[i]->output[j]) > i)
					{
						temp = varList[i];
						varList[i] = varList[i+1];
						varList[i+1] = temp;
						break;
					}
				}
			}
		}
	}
}

int find(struct element** varList, char* name)
{
	int n = 0;
	while(strcmp(varList[n]->identifier, name) != 0)
	{
		n++;
	}
	return varList[n]->outputValue;
}

int NOT(int in1){return !in1;}
int AND(int in1, int in2){return in1&in2;}
int OR(int in1, int in2){return in1|in2;}
int NAND(int in1, int in2){return !(in1&in2);}
int NOR(int in1, int in2){return !(in1|in2);}
int XOR(int in1, int in2){return in1^in2;}

int MULTIPLEXER(char** inputs, char** selectors, int numSelectors, int numInput, struct element** total)
{
	int n, w;
	int temp;
	int diff;
	int counter = 0;
	for(n = 0; n < numInput; n++)
	{
		diff = numSelectors-1;
		temp = graycode(n, numSelectors);
		for(w = 0; w < numSelectors; w++)
		{
			if(find(total, selectors[w]) == ((temp>>diff)%2))
				counter++;
			else
				break;
			diff--;
		}
		if(counter == numSelectors)
			return find(total, inputs[n]);
		else
			counter = 0;
	}
	return 0;
}

char* DECODERFUNC(char** inputs, char** outputs, int numInputs, struct element** total)
{
	int n, w;
	int temp;
	int diff;
	int power = pow(2, numInputs);
	int counter = 0;
	for(n = 0; n < power; n++)
	{
		diff = numInputs-1;
		temp = graycode(n, numInputs);
		for(w = 0; w < numInputs; w++)
		{
			if(find(total, inputs[w]) == ((temp>>diff)%2))
				counter++;
			else
				break;
			diff--;
		}
		if(counter == numInputs)
			return outputs[n];
		else
			counter = 0;
	}
	return inputs[0];
}

int main(int argc, char** argv)
{
	FILE *fp;
	fp = fopen(argv[1], "r");
	if(fp == NULL)
	{	
		printf("error\n");
		return 0;
	}
			
	char trash[1000];
	int throwaway = 0;
	int power = 0;
	int trash2;
	int j;
	char* DECODER = "DECODER";

	int numTemp = 0; int numInput = 0;	int numOutput = 0;
	fscanf(fp, "%s", trash);
	fscanf(fp, "%d", &numInput);
	fscanf(fp, "%[^\n]", trash);
	fscanf(fp, "%s", trash);
	fscanf(fp, "%d", &numOutput);
	fscanf(fp, "%[^\n]", trash);
	fscanf(fp, "%s", trash);
	if(strcmp(trash, DECODER) == 0)
	{
		fscanf(fp, "%d", &trash2);
		numTemp += pow(2, trash2);
		numTemp--;
	}
	while(fscanf(fp, "%[^\n]", trash) > 0)
	{
		fscanf(fp, "%s", trash);
		if(strcmp(trash, DECODER) == 0)
		{
			fscanf(fp, "%d", &trash2);
			numTemp += pow(2, trash2);
			numTemp--;
		}
		numTemp++;
	}
	numTemp = numTemp - numOutput;
	
	//Second read thru----------------------------------------------------------------------
	int totalVars = numInput + numOutput + numTemp + 2;
	struct element** total = (struct element**) malloc(sizeof(struct element*) * totalVars);
	struct element* zero = (struct element*) malloc(sizeof(struct element));
	strcpy(zero->identifier, "0");
	zero->outputValue = 0;
	total[0] = zero;
	struct element* one = (struct element*) malloc(sizeof(struct element));
	strcpy(one->identifier, "1");
	one->outputValue = 1;
	total[1] = one;
	
	fp = fopen(argv[1], "r");
	i = 0; j = 0; k = 0;
	int inputIndex = 2;
	int tempIndex = inputIndex+numInput; 
	int outputIndex = tempIndex+numTemp;
	while(fscanf(fp, "%s", trash) != EOF)
	{
		struct element* tempElement;
		if(strcmp(trash, "INPUTVAR") == 0)
		{
			fscanf(fp, "%s", trash);
			for(j = 0; j < numInput; j++)
			{
				tempElement = (struct element*) malloc(sizeof(struct element));
				fscanf(fp, "%s", tempElement->identifier);
				total[inputIndex++] = tempElement;
			}
			i++;
		}
		else if(strcmp(trash, "OUTPUTVAR") == 0)
		{
			fscanf(fp, "%s", trash);
			for(j = 0; j < numOutput; j++)
			{
				tempElement = (struct element*) malloc(sizeof(struct element));
				fscanf(fp, "%s", tempElement->identifier);
				total[outputIndex++] = tempElement;
			}
			i++;
		}
		else if(strcmp(trash, "NOT") == 0)
		{
			tempElement = (struct element*) malloc(sizeof(struct element));
			tempElement->numInputs = 1;
			strcpy(tempElement->directive, trash);
			for(k = 0; k < 1; k++)
			{
				fscanf(fp, "%s", trash);
				tempElement->input[k] = malloc(strlen(trash)+1);
				strcpy(tempElement->input[k], trash);
			}
			fscanf(fp, "%s", tempElement->identifier);
			if(tempElement->identifier[0] <= 90)
			{
				for(k = (totalVars-numOutput); k < totalVars; k++)
				{
					if(strcmp(total[k]->identifier, tempElement->identifier) == 0)
						total[k] = tempElement;
				}
						
			}
			else
				total[tempIndex++] = tempElement;
			i++;
		}
		else if(strcmp(trash, "DECODER") == 0)
		{
			tempElement = (struct element*) malloc(sizeof(struct element));
			strcpy(tempElement->directive, trash);
			fscanf(fp, "%d", &throwaway);
			tempElement->numInputs = throwaway;
			power = pow(2, throwaway);
			for(k = 0; k < throwaway; k++)
			{
				fscanf(fp, "%s", trash);
				tempElement->input[k] = malloc(strlen(trash)+1);
				strcpy(tempElement->input[k], trash);
			}
			for(k = 0; k < power; k++)
			{
				fscanf(fp, "%s", trash);
				tempElement->output[k] = malloc(strlen(trash)+1);
				strcpy(tempElement->output[k], trash);
			}
			for(k = 0; k < power; k++)
			{
				struct element* tempElement2 = (struct element*) malloc(sizeof(struct element));
				for(j = 0; j < throwaway; j++)
					tempElement2->input[j] = tempElement->input[j];
				for(j = 0; j < power; j++)
					tempElement2->output[j] = tempElement->output[j];
				tempElement2->numInputs = tempElement->numInputs;
				strcpy(tempElement2->directive, tempElement->directive);
				strcpy(tempElement2->identifier, tempElement->output[k]);
				if(tempElement2->identifier[0] <= 90)
				{
					for(j = (totalVars-numOutput); j < totalVars; j++)
					{
						if(strcmp(total[j]->identifier, tempElement2->identifier) == 0)
							total[j] = tempElement2;
					}
						
				}
				else
					total[tempIndex++] = tempElement2;
			}
			i++;
		}
		else if(strcmp(trash, "MULTIPLEXER") == 0)
		{
			tempElement = (struct element*) malloc(sizeof(struct element));
			strcpy(tempElement->directive, trash);
			fscanf(fp, "%d", &throwaway);
			tempElement->numInputs = throwaway;
			int numSelectors = log2(throwaway);
			tempElement->numSelectors = numSelectors;
			for(k = 0; k < throwaway; k++)
			{
				fscanf(fp, "%s", trash);
				tempElement->input[k] = malloc(strlen(trash)+1);
				strcpy(tempElement->input[k], trash);
			}
			for(k = 0; k < numSelectors; k++)
			{
				fscanf(fp, "%s", trash);
				tempElement->output[k] = malloc(strlen(trash)+1);
				strcpy(tempElement->output[k], trash);
			}
			fscanf(fp, "%s", tempElement->identifier);
			if(tempElement->identifier[0] <= 90)
			{
				for(k = (totalVars-numOutput); k < totalVars; k++)
				{
					if(strcmp(total[k]->identifier, tempElement->identifier) == 0)
						total[k] = tempElement;
				}
						
			}
			else
				total[tempIndex++] = tempElement;
			i++;
		}
		else
		{
			tempElement = (struct element*) malloc(sizeof(struct element));
			tempElement->numInputs = 2;
			strcpy(tempElement->directive, trash);
			for(k = 0; k < 2; k++)
			{
				fscanf(fp, "%s", trash);
				tempElement->input[k] = malloc(strlen(trash)+1);
				strcpy(tempElement->input[k], trash);
			}
			fscanf(fp, "%s", tempElement->identifier);
			if(tempElement->identifier[0] <= 90)
			{
				for(k = (totalVars-numOutput); k < totalVars; k++)
				{
					if(strcmp(total[k]->identifier, tempElement->identifier) == 0)
						total[k] = tempElement;
				}
						
			}
			else
				total[tempIndex++] = tempElement;
			i++;
		}
	}
	
	sort(total, totalVars);	
	
	power = pow(2, numInput);
	int blah = numInput+2;
	for(k = 0; k < power; k++)
	{
		throwaway = graycode(k, numInput);
		for(j = 2; j < blah; j++)
		{
			total[j]->outputValue = (throwaway>>(numInput-(j-1)))%2;
			printf("%d ", total[j]->outputValue);
		}
			
		//do calculations now and print output variables
		for(j = numInput+2; j < totalVars; j++)
		{
			if(strcmp(total[j]->directive, "NOT") == 0)
				total[j]->outputValue = NOT(find(total, total[j]->input[0]));
			else if(strcmp(total[j]->directive, "AND") == 0)
				total[j]->outputValue = AND(find(total, total[j]->input[0]), find(total, total[j]->input[1]));
			else if(strcmp(total[j]->directive, "OR") == 0)
				total[j]->outputValue = OR(find(total, total[j]->input[0]), find(total, total[j]->input[1]));
			else if(strcmp(total[j]->directive, "NAND") == 0)
				total[j]->outputValue = NAND(find(total, total[j]->input[0]), find(total, total[j]->input[1]));
			else if(strcmp(total[j]->directive, "NOR") == 0)
				total[j]->outputValue = NOR(find(total, total[j]->input[0]), find(total, total[j]->input[1]));
			else if(strcmp(total[j]->directive, "XOR") == 0)
				total[j]->outputValue = XOR(find(total, total[j]->input[0]), find(total, total[j]->input[1]));
			else if(strcmp(total[j]->directive, "MULTIPLEXER") == 0)
				total[j]->outputValue = MULTIPLEXER(total[j]->input, total[j]->output, total[j]->numSelectors, pow(2, total[j]->numSelectors), total);
			else if(strcmp(total[j]->directive, "DECODER") == 0)
			{
				char* val = DECODERFUNC(total[j]->input, total[j]->output, total[j]->numInputs, total);
				int holder = 0;
				int powah = pow(2, total[j]->numInputs);
				for(i = 0; i < powah; i++)
				{
					if(strcmp(total[j]->output[i], val) != 0)
					{
						holder = set(total, total[j]->output[i]);
						total[holder]->outputValue = 0;
					}
					else
					{
						holder = set(total, total[j]->output[i]);
						total[holder]->outputValue = 1;
					}
				}
			}
			if(total[j]->identifier[0] <= 90)
				printf("%d ", total[j]->outputValue);
		}
		printf("\n");
	}
	fclose(fp);
	return 0;
}
