import random
import sys
import math

directory = "gridworlds/"
file_head = "gridworld"

def index_stats(blocked=30, unblocked=70):
    random_num = random.randint(0, blocked+unblocked)
    if(random_num < 30):
        return 1
    else:
        return 0


def create_gridworld(gridworld_num, x=101, y=101):
    try:
        filename = directory + file_head + str(gridworld_num) + ".txt"
        file = open(filename, 'w')
    except FileNotFoundError:
        print ("Could not find the directory or file: " + filename)
        return
    
    start_cell = random.randint(0,x-1),random.randint(0,y-1)
    goal_cell = random.randint(0,x-1),random.randint(0,y-1)
    while(goal_cell[0] == start_cell[0] and goal_cell[1] == start_cell[1]):
        goal_cell = random.randint(0,x-1),random.randint(0,y-1)
    file.write(str(start_cell[0]) + ' ' + str(start_cell[1]) + '\n')
    file.write(str(goal_cell[0]) + ' ' + str(goal_cell[1]) +'\n')

    for i in range(x):
        for j in range(y):
            if(i == start_cell[0] and j == start_cell[1]):
                file.write('0' + ' ')
            elif(i == goal_cell[0] and j == goal_cell[1]):
                file.write('0' + ' ')
            else:
                file.write(str(index_stats()) + ' ')
        file.write('\n')
    return

def gridworld_array(gridworld_num):
    try:
        filename = directory + file_head + str(gridworld_num) + ".txt"
        file = open(filename)
    except FileNotFoundError:
        print ("Could not find the directory or file: " + filename)
        return

    maze = []
    n = 0

    for line in file:
        if(n == 0):
            temp = line.split(' ')
            temp = temp[0:2]
            start_cell = (int(temp[0]), int(temp[1]))
            n += 1
        elif(n == 1):
            temp = line.split(' ')
            temp = temp[0:2]
            goal_cell = (int(temp[0]), int(temp[1]))
            n += 1
        else:
            temp = line.split(' ')
            temp = temp[:len(temp)-1]
            temp = [int(i) for i in temp]
            maze.append(temp)

    return start_cell, goal_cell, maze

#def main():
    #for i in range(50):
    #    create_gridworld(i)
    #create_gridworld(50, x=1001, y=1001)
    #return
    
#if __name__ == "__main__":
	#main()
    #create_gridworld(50, x=1001, y=1001)