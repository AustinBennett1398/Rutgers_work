#include <stdio.h>
#include <stdlib.h>

struct listnode
{
 int value;
 struct listnode* next;
};

void traverse(struct listnode**);
void cleanup(struct listnode*);
void insert(struct listnode**, int);
void delete(struct listnode**, int);

void insert(struct listnode** head, int num)
{
	struct listnode* newNode = (struct listnode*) malloc(sizeof(struct listnode));
	newNode->value = num;
	newNode->next = NULL;
	struct listnode* currentNode = *head;
	
	if(currentNode == NULL || currentNode->value > newNode->value)
	{
		newNode->next = *head;
		*head = newNode;
		
	}
	else if(currentNode->value == newNode->value)
	{
		return;
	}
	else
	{
		while(currentNode->next != NULL)
		{
			if(currentNode->next->value < newNode->value)
			{
				currentNode = currentNode->next;
			}
			else if(currentNode->next->value > newNode->value)
			{
				break;
			}
			else
			{
				return;
			}
		}
		newNode->next = currentNode->next;
		currentNode->next = newNode;
	}
}

void delete(struct listnode** head, int num)
{
	/*if(!(*head))
	{
		return;
	}*/
	if(*head == NULL)
	{
		return;
	}
		
	struct listnode* currentNode = *head;
	
	if(currentNode->value == num)
	{
		if((*head)->next != NULL)
			*head = (*head)->next;
		else
			*head = NULL;
		free(currentNode);
		return;
	}
	
	while(currentNode->next != NULL)
	{
		if(currentNode->next->value == num)
		{
			struct listnode* nodeToDelete = currentNode->next;
			if(currentNode->next->next != NULL)
			{
				currentNode->next = currentNode->next->next;
				nodeToDelete = NULL;
			}
			else
			{
				currentNode->next = NULL;
				nodeToDelete = NULL;
			}
			free(nodeToDelete);
			return;
		}
		else
			currentNode = currentNode->next;
	}
	//printf("%d\n\n\n", num);	
}

void cleanup(struct listnode* mylist)
{

 struct listnode* t1 = mylist;
 struct listnode* t2 = NULL;

 while(t1 != NULL)
 {

  t2 = t1;
  t1 = t1->next;
  free(t2);

 }

}

void traverse(struct listnode** mylist)
{
	struct listnode* t1 = *mylist;
	struct listnode* t2 = *mylist;
	int count = 0;
	while(t1 != NULL)
 	{
  		t1 = t1->next;
  		count++;
 	}
 	printf("%d\n", count);
 	
	while(t2 != NULL)
 	{
  		printf("%d\t", t2->value);
  		t2 = t2->next;
 	}
 	return;

}

int main( int argc, char** argv)
{
 int num;
 char c;
 struct listnode* head = NULL;
 
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
 	//printf("%c %d\n", c, num);
	if(c == 'i')
	{
		insert(&head, num);
	}
	else
	{
		delete(&head, num);
	}
 }

	fclose(fp);
	traverse(&head);
 	cleanup(head);
 	return 0;
}

