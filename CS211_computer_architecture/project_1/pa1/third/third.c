#include <stdio.h>
#include <stdlib.h>

int bucketSize = 10000;

struct listnode
{
	 int value;
	 struct listnode* next;
};

void insert(struct listnode**, int);
void search (struct listnode**, int);

void insert (struct listnode** hashList, int key)
{
	int hashKey = abs(key % bucketSize);
	struct listnode* newNode = (struct listnode*) malloc(sizeof(struct listnode));
	newNode->value = key;
	newNode->next = NULL;
	struct listnode* currentNode = hashList[hashKey];
	//If there is no value in the listnode
	if(hashList[hashKey] == NULL)
	{
		hashList[hashKey] = newNode;
		printf("inserted\n");
	}
	//If there is a value in the listnode(collisions)
	else
	{
		if(currentNode->next == NULL)
		{
			if(currentNode->value != key)
			{
				currentNode->next = newNode;
				printf("inserted\n");
			}
			else
			{
				printf("duplicate\n");
			}		
		}
		else
		{
			while(currentNode->next != NULL)
			{
				if(currentNode->value == key)
				{
					printf("duplicate\n");
					return;
				}
				else
				{
					currentNode = currentNode->next;
				}	
			}
			currentNode->next = newNode;
			printf("inserted\n");
		}
	}
}

void search (struct listnode** hashList, int key)
{
	int hashKey = abs(key % bucketSize);
	struct listnode* currentNode = hashList[hashKey];
	//Check value of node
	if(currentNode->value == key)
		printf("present\n");
	else if(currentNode->value != key)
	{
		while(currentNode->next != NULL)
		{
			if(currentNode->value != key)
			{
				currentNode = currentNode->next;
			}
			else
			{
				printf("present\n");
				return;
			}
		}
		if(currentNode->value == key)
			printf("present\n");
		else
			printf("absent\n");
	}
}

int main (int argc, char** argv)
{
	struct listnode** hashList = (struct listnode**) malloc(sizeof(struct listnode*) * bucketSize);
	char c;
	int num;
			
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
 	while(fscanf(fp, "%c %d\n", &c, &num) == 2)
 	{
		if(c == 'i')
		{
			insert(hashList, num);
		}
		else
			search(hashList, num);
 	}

	fclose(fp);
 	return 0;
}
