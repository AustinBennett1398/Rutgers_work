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
void delete(struct treeNode**, int);
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
	
	if(*treeList == NULL)
	{
		inserted = 1;
		printf("inserted %d\n", height);
		*treeList = newNode;
	}
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
	if(*treeList == NULL)
	{
		printf("absent\n");
		present = 1;
	}
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

void delete (struct treeNode** treeList, int num)
{
	int present = 0;
	struct treeNode* currentNode = *treeList;
	struct treeNode* previousNode = NULL;
	if(currentNode == NULL)
		return;
	if(num < currentNode->value && currentNode->left != NULL)
	{
		previousNode = currentNode;
		currentNode = currentNode->left;
	}
	else if(num > currentNode->value && currentNode->right != NULL)
	{
		previousNode = currentNode;
		currentNode = currentNode->right;
	}
	else
	{
		previousNode = currentNode;
	}
	
	while(present == 0)
	{
		if(num == currentNode->value)
		{
			//If node to delete has no children
			if(currentNode->left == NULL && currentNode->right == NULL)
			{
				if(num == previousNode->value)
				{
					*treeList = NULL;
				}
				if(num < previousNode->value)
				{
					previousNode->left = NULL;
					free(currentNode);
				}
				else
				{
					previousNode->right = NULL;
					free(currentNode);
				}
			}
			//If node to delete has 1 child and its the left child
			else if(currentNode->left != NULL && currentNode->right == NULL)
			{
				struct treeNode* temp = currentNode->left;
				currentNode->value = currentNode->left->value;
				if(currentNode->left->left != NULL)
					currentNode->left = currentNode->left->left;
				else
					currentNode->left = NULL;
				free(temp);
			}
			//If node to delete has 1 child and its the right child
			else if(currentNode->left == NULL && currentNode->right != NULL)
			{
				struct treeNode* temp = currentNode->right;
				currentNode->value = currentNode->right->value;
				if(currentNode->right->right != NULL)
					currentNode->right = currentNode->right->right;
				else
					currentNode->right = NULL;
				free(temp);
			}
			//If node to delete has 2 children
			else if(currentNode->left != NULL && currentNode->right != NULL)
			{
				struct treeNode* currentNodeTwo = currentNode;
				struct treeNode* previousNodeTwo = previousNode;
				//Step to right subtree of node to delete and then traverse the entire left subtree to find minimum value
				previousNodeTwo = currentNodeTwo;
				currentNodeTwo = currentNodeTwo->right;
				while(currentNodeTwo->left != NULL)
				{
					previousNodeTwo = currentNodeTwo;
					currentNodeTwo = currentNodeTwo->left;
				}
				currentNode->value = currentNodeTwo->value;
				if(currentNode->right->left == NULL && currentNode->right->right != NULL)
					currentNode->right = currentNode->right->right;
				else if(currentNode->right->left == NULL && currentNode->right->right == NULL)
					currentNode->right = NULL;
				if(currentNodeTwo->right != NULL && previousNodeTwo->value != currentNodeTwo->value)
					previousNodeTwo->left = currentNodeTwo->right;
				else if(currentNodeTwo->right == NULL)
					previousNodeTwo->left = NULL;
				free(currentNodeTwo);
			}
			
			present = 1;
			printf("success\n");
			break;
		}
		else if(num < currentNode->value && currentNode->left != NULL)
		{
			previousNode = currentNode;
			currentNode = currentNode->left;
		}
		else if(num > currentNode->value && currentNode->right != NULL)
		{
			previousNode = currentNode;
			currentNode = currentNode->right;
		}
		else
		{
			printf("fail\n");
			present = 1;
		}
	}	
}

int main (int argc, char** argv)
{
	char c;
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
	if(c == 'i')
	{
		treeList->value = num;
		treeList->left = NULL;
		treeList->right = NULL;
		printf("inserted 1\n");
	}
	else if(c == 's')
		printf("absent\n");
	else
		printf("fail\n");
	
 	while(fscanf(fp, "%c %d\n", &c, &num) == 2)
 	{
		if(c == 'i')
			insert(&treeList, num);
		else if( c == 's')
			search(&treeList, num);
		else
			delete(&treeList, num);
 	}
	cleanse(treeList);
	fclose(fp);
 	return 0;
}
