#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>

struct listnode
{
	 int counter;
	 size_t tagVal;
};

int errorChecker(char**, int, char*, char*, int);
void directCache(FILE*, int, char*, char*, int, int);
void assocCache(FILE*, int, char*, char*, int, int);
void assocnCache(FILE*, int, char*, char*, int , int, int);

void assocnCache(FILE* fp, int cacheSize, char* associativity, char* cachePolicy, int blockSize, int prefetch, int n)
{
	int i, j;
	int min, max, lruMax;
	int hit = 0;
	int location = 0;
	int lru = strcmp(cachePolicy, "lru");
	
	size_t trash;
	size_t address;
	char RW;
	
	int readCount = 0;
	int writeCount = 0;
	int cacheHit = 0;
	int cacheMiss = 0;
	
	size_t numSets = cacheSize/(blockSize*n);
	size_t setBits = log2(numSets);
	size_t blockOffsetBits = log2(blockSize);
	size_t index = pow(2, setBits);
	size_t blockAndSet = blockOffsetBits + setBits;
	
	size_t tag;
	size_t set;
	size_t prefetchAddress;
	size_t prefetchTag;	
	size_t prefetchSet;
	
	struct listnode** cache = (struct listnode **) malloc(sizeof(struct listnode*) * (numSets));
	for(i = 0; i < numSets; i++)
	{
		cache[i] = (struct listnode*) malloc(sizeof(struct listnode) * n);
	}
	
	for(i = 0; i < numSets; i++)
	{
		for(j = 0; j < n; j++)
		{
			struct listnode* temp = (struct listnode*) malloc(sizeof(struct listnode));
			temp->counter = -1;
			cache[i][j] = *temp;
		}
	}
	
	
	while(fscanf(fp, "%zx: %c %zx", &trash, &RW, &address) == 3)
	{
		set = (address>>blockOffsetBits) % index;
		tag = address>>blockAndSet;
		
		if(RW == 'W')
			writeCount++;
		
		min = cache[set][0].counter;
		max = cache[set][0].counter;
		if(lru == 0)
			lruMax = cache[set][0].counter;
		for(i = 0; i < n; i++)
		{
			if(cache[set][i].tagVal == tag)
			{
				cacheHit++;
				hit = 1;
				if(lru == 0)
				{
					for(j = 0; j < n; j++)
					{
						if(cache[set][j].counter > lruMax)
							lruMax = cache[set][j].counter;
					}
					cache[set][i].counter = lruMax+1;
				}
				break;
			}
			else if(cache[set][i].counter < min)
			{
				location = i;
				min = cache[set][i].counter;
			}
			else if(cache[set][i].counter > max)
			{
				max = cache[set][i].counter;
			}
		}
		if(hit == 0)
		{
			readCount++;
			cacheMiss++;
			cache[set][location].tagVal = tag;
			cache[set][location].counter = max+1;
			
			if(prefetch == 1)
			{
				location = 0;
				prefetchAddress = address+blockSize;
				prefetchSet = (prefetchAddress>>blockOffsetBits) % index;
				prefetchTag = prefetchAddress>>blockAndSet;
				min = cache[prefetchSet][0].counter;
				max = cache[prefetchSet][0].counter;
				
				for(i = 0; i < n; i++)
				{
					if(cache[prefetchSet][i].tagVal == prefetchTag)
					{
						hit = 1;
						break;
					}
					else if(cache[prefetchSet][i].counter < min)
					{
						location = i;
						min = cache[prefetchSet][i].counter;
					}
					else if(cache[prefetchSet][i].counter > max)
					{
						max = cache[prefetchSet][i].counter;
					}
				}
				if(hit == 0)
				{
					readCount++;
					cache[prefetchSet][location].tagVal = prefetchTag;
					cache[prefetchSet][location].counter = max+1;
				}
				else
					hit = 0;
				location = 0;
			}
		}
		else
			hit = 0;
		location = 0;
		
	}
	
	if(prefetch == 0)
		printf("no-prefetch\nMemory reads: %d\nMemory writes: %d\nCache hits: %d\nCache misses: %d\n", readCount, writeCount, cacheHit, cacheMiss);
	else
		printf("with-prefetch\nMemory reads: %d\nMemory writes: %d\nCache hits: %d\nCache misses: %d\n", readCount, writeCount, cacheHit, cacheMiss);

	
	for(i = 0; i < numSets; i++)
			free(cache[i]);
	free(cache);	
	return;
}

void assocCache(FILE* fp, int cacheSize, char* associativity, char* cachePolicy, int blockSize, int prefetch)
{
	int i, j;
	int min, max;
	int lruMax;
	int hit = 0;
	int location = 0;
	int lru = strcmp(cachePolicy, "lru");
	
	size_t trash;
	size_t address;
	char RW;
	
	int readCount = 0;
	int writeCount = 0;
	int cacheHit = 0;
	int cacheMiss = 0;
	
	size_t blockOffsetBits = log2(blockSize);
	size_t numSets = cacheSize/blockSize;
	size_t blockAndSet = blockOffsetBits;
	
	size_t tag;
	size_t prefetchAddress;
	size_t prefetchTag;	
	
	struct listnode** cache = (struct listnode **) malloc(sizeof(struct listnode*) * (numSets));
	for(i = 0; i < numSets; i++)
	{
		cache[i] = (struct listnode*) malloc(sizeof(struct listnode));
		cache[i]->counter = -1;
	}
	
	while(fscanf(fp, "%zx: %c %zx", &trash, &RW, &address) == 3)
	{
		tag = address>>blockAndSet;
		
		if(RW == 'W')
			writeCount++;
		
		min = cache[0]->counter;
		max = cache[0]->counter;
		if(lru == 0)
			lruMax = cache[0]->counter;
		for(i = 0; i < numSets; i++)
		{
			if(cache[i]->tagVal == tag)
			{
				cacheHit++;
				hit = 1;
				if(lru == 0)
				{
					for(j = 0; j < numSets; j++)
					{
						if(cache[j]->counter > lruMax)
							lruMax = cache[j]->counter;
					}
					cache[i]->counter = lruMax+1;
				}
				break;
			}
			else if(cache[i]->counter < min)
			{
				location = i;
				min = cache[i]->counter;
			}
			else if(cache[i]->counter > max)
			{
				max = cache[i]->counter;
			}
		}
		if(hit == 0)
		{
			readCount++;
			cacheMiss++;
			cache[location]->tagVal = tag;
			cache[location]->counter = max+1;
			
			if(prefetch == 1)
			{
				location = 0;
				prefetchAddress = address+blockSize;
				prefetchTag = prefetchAddress>>blockAndSet;
				min = cache[0]->counter;
				max = cache[0]->counter;
				
				for(i = 0; i < numSets; i++)
				{
					if(cache[i]->tagVal == prefetchTag)
					{
						hit = 1;
						break;
					}
					else if(cache[i]->counter < min)
					{
						location = i;
						min = cache[i]->counter;
					}
					else if(cache[i]->counter > max)
					{
						max = cache[i]->counter;
					}
				}
				if(hit == 0)
				{
					readCount++;
					cache[location]->tagVal = prefetchTag;
					cache[location]->counter = max+1;
				}
				else
					hit = 0;
				location = 0;
			}
		}
		else
			hit = 0;
		location = 0;
		
	}
	
	if(prefetch == 0)
		printf("no-prefetch\nMemory reads: %d\nMemory writes: %d\nCache hits: %d\nCache misses: %d\n", readCount, writeCount, cacheHit, cacheMiss);
	else
		printf("with-prefetch\nMemory reads: %d\nMemory writes: %d\nCache hits: %d\nCache misses: %d\n", readCount, writeCount, cacheHit, cacheMiss);

	
	for(i = 0; i < numSets; i++)
			free(cache[i]);
	free(cache);	
	return;
}

void directCache(FILE* fp, int cacheSize, char* associativity, char* cachePolicy, int blockSize, int prefetch)
{
	int i;
	
	struct listnode** cache = (struct listnode **) malloc(sizeof(struct listnode*) * (cacheSize/(blockSize)));
	for(i = 0; i < (cacheSize/blockSize); i++)
	{
		cache[i] = NULL;
	}

	size_t trash;
	size_t address;
	char RW;
	
	int readCount = 0;
	int writeCount = 0;
	int cacheHit = 0;
	int cacheMiss = 0;
	
	size_t setBits = log2(cacheSize/blockSize);
	size_t blockOffsetBits = log2(blockSize);
	size_t index = pow(2, setBits);
	size_t blockAndSet = blockOffsetBits + setBits;
	
	size_t set;
	size_t tag;
	
	size_t prefetchAddress;
	size_t prefetchSet;
	size_t prefetchTag;
	
	while(fscanf(fp, "%zx: %c %zx", &trash, &RW, &address) == 3)
	{	
		set = (address>>blockOffsetBits) % index;
		tag = (address>>(blockAndSet));
		if(RW == 'W')
			writeCount++;
		
		if(cache[set] == NULL)
		{	
			cacheMiss++;
			readCount++;
			struct listnode* temp = (struct listnode*) malloc(sizeof(struct listnode));
			temp->tagVal = tag;
			cache[set] = temp;
			
			if(prefetch == 1)
			{
				prefetchAddress = address+blockSize;
				prefetchSet = (prefetchAddress>>blockOffsetBits) % index;
				prefetchTag = prefetchAddress>>blockAndSet;
				if(cache[prefetchSet] == NULL)
				{
					readCount++;
					struct listnode* temp2 = (struct listnode*) malloc(sizeof(struct listnode));
					temp2->tagVal = prefetchTag;
					cache[prefetchSet] = temp2;
				}
				else if(cache[prefetchSet]->tagVal != prefetchTag)
				{
					readCount++;
					cache[prefetchSet]->tagVal = prefetchTag;
				}
			}
		}
		else
		{
			if(cache[set]->tagVal != tag)
			{
				cacheMiss++;
				readCount++;
				cache[set]->tagVal = tag;
				if(prefetch == 1)
				{
					prefetchAddress = address+blockSize;
					prefetchSet = (prefetchAddress>>blockOffsetBits) % index;
					prefetchTag = prefetchAddress>>blockAndSet;
					if(cache[prefetchSet] == NULL)
					{
						readCount++;
						struct listnode* temp3 = (struct listnode*) malloc(sizeof(struct listnode));
						//temp3->tagVal = tag;
						temp3->tagVal = prefetchTag;
						cache[prefetchSet] = temp3;
					}
					else
					{
						if(cache[prefetchSet]->tagVal != prefetchTag)
						{
							readCount++;
							cache[prefetchSet]->tagVal = prefetchTag;
						}
					}
				}
			}
			else
			{
				cacheHit++;
			}
		}
	}
	
	if(prefetch == 0)
		printf("no-prefetch\nMemory reads: %d\nMemory writes: %d\nCache hits: %d\nCache misses: %d\n", readCount, writeCount, cacheHit, cacheMiss);
	else
		printf("with-prefetch\nMemory reads: %d\nMemory writes: %d\nCache hits: %d\nCache misses: %d\n", readCount, writeCount, cacheHit, cacheMiss);
	
	for(i = 0; i < (cacheSize/blockSize); i++)
	{
		free(cache[i]);
	}
	free(cache);
	return;
}

int errorChecker(char** argv, int cacheSize, char* associativity, char* cachePolicy, int blockSize)
{
	double intPart;
	double fracPart;
	double n = 1.0;
	char* direct = "direct";
	char* assoc = "assoc";
	char* assocn = "assoc:";
	char* fifo = "fifo";
	char* lru = "lru";
	
	//Check cache size validity
	fracPart = modf(log2(cacheSize), &intPart);
	if(fracPart != 0 || cacheSize < 2)
		return 0;
	//Check block size validity
	fracPart = modf(log2(blockSize), &intPart);
	if(fracPart != 0)
		return 0;
	//Check validity of cache policy
	if(strcmp(cachePolicy, fifo) != 0 && strcmp(cachePolicy, lru) != 0)
		return 0;
	//Check validity of the associative policy
	if(strcmp(associativity, direct) != 0 && strcmp(associativity, assoc) && strncmp(associativity, assocn, 6) != 0)
		return 0;
	//If associative policy is of type assocn, get value of n and check for validity
	if(strncmp(associativity, assocn, 6) == 0)
		n = atoi((&associativity[6]));
		
	fracPart = modf(log2(n), &intPart);
	if(fracPart != 0)
		return 0;
	
	return n;
}

int main (int argc, char** argv)
{
	int cacheSize = atoi(argv[1]);
	char* associativity = argv[2];
	char* cachePolicy = argv[3];
	int blockSize = atoi(argv[4]);
	
	char* direct = "direct";
	char* assoc = "assoc";
	
	FILE *fp;
	fp = fopen(argv[5], "r");
	if(fp == NULL)
	{	
		printf("error\n");
		return 0;
	}
	
	//Check for validity of all entered command line arguments
	int error = errorChecker(argv, cacheSize, associativity, cachePolicy, blockSize);
	if(error == 0)
	{
		printf("error\n");
		return 0;
	}
	//Error free!

	//Do assocn stuff
	if(error >= 1 && strcmp(associativity,assoc) != 0 && strcmp(associativity,direct) != 0)
	{
		//no-prefetch
		assocnCache(fp, cacheSize, associativity, cachePolicy, blockSize, 0, error);
		//with-prefetch
		fp = fopen(argv[5], "r");
		assocnCache(fp, cacheSize, associativity, cachePolicy, blockSize, 1, error);
	}
	
	//Do assoc stuff
	if(strcmp(associativity, assoc) == 0)
	{
		//no-prefetch
		assocCache(fp, cacheSize, associativity, cachePolicy, blockSize, 0);
		//with-prefetch
		fp = fopen(argv[5], "r");
		assocCache(fp, cacheSize, associativity, cachePolicy, blockSize, 1);
	}
	
	//Do direct stuff
	if(strcmp(associativity, direct) == 0)
	{
		//no-prefetch
		directCache(fp, cacheSize, associativity, cachePolicy, blockSize, 0);
		//with-prefetch
		fp = fopen(argv[5], "r");
		directCache(fp, cacheSize, associativity, cachePolicy, blockSize, 1);
	}

	fclose(fp);
	return 0;
}
