#include <stdio.h>
#include <stdlib.h>

struct treeNode
{
	int value;
	struct treeNode* left;
	struct treeNode* right;
};

void insert(struct treeNode**, int);
void search (struct treeNode**, int);
void cleanse(struct treeNode*);

void cleanse(struct treeNode* treeList)
{
	if(treeList == NULL)
		return;
	cleanse(treeList->left);
	cleanse(treeList->right);
	free(treeList);
		
}

void insert (struct treeNode** treeList, int num)
{
	int height = 1;
	int inserted = 0;
	struct treeNode* currentNode = *treeList;
	struct treeNode* newNode = (struct treeNode*) malloc(sizeof(struct treeNode));
	newNode->value = num; 
	newNode->left = NULL; 
	newNode->right = NULL;
	
	while(inserted == 0)
	{
		if(num == currentNode->value)
		{
			printf("duplicate\n");
			inserted = 1;
		}
		else if(num < currentNode->value && currentNode->left != NULL)
		{
			currentNode = currentNode->left;
			height++;
		}
		else if(num > currentNode->value && currentNode->right != NULL)
		{
			currentNode = currentNode->right;
			height++;
		}
		else if(num < currentNode->value && currentNode->left == NULL)
		{
			currentNode->left = newNode;
			printf("inserted %d\n", ++height);
			inserted = 1;
		}
		else if(num > currentNode->value && currentNode->right == NULL)
		{
			currentNode->right = newNode;
			printf("inserted %d\n", ++height);
			inserted = 1;
		}
	}	
}

void search (struct treeNode** treeList, int num)
{
	struct treeNode* currentNode = *treeList;
	int present = 0; int height = 1;
	while(present == 0)
	{
		if(num == currentNode->value)
		{
			printf("present %d\n", height);
			present = 1;
		}
		else if(num < currentNode->value && currentNode->left != NULL)
		{
			currentNode = currentNode->left;
			height++;
		}
		else if(num > currentNode->value && currentNode->right != NULL)
		{
			currentNode = currentNode->right;
			height++;
		}
		else
		{
			printf("absent\n");
			present = 1;
		}
	}	
}

int main (int argc, char** argv)
{
	char c = '\0';
	int num;
	struct treeNode* treeList = (struct treeNode*) malloc(sizeof(struct treeNode));
		
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

	fscanf(fp, "%c %d\n", &c, &num);
	if(c != '\0')
	{	
		treeList->value = num;
		treeList->left = NULL;
		treeList->right = NULL;
		printf("inserted 1\n");
	}
	
 	while(fscanf(fp, "%c %d\n", &c, &num) == 2)
 	{
		if(c == 'i')
			insert(&treeList, num);
		else
			search(&treeList, num);
 	}
	cleanse(treeList);
	fclose(fp);
 	return 0;
}
