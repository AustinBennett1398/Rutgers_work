import csv
import heapq
import math
import os
import random
import sys
import time
import timeit
import matplotlib.pyplot as plt

import pygame
from win32api import GetSystemMetrics

import astar
from search import *
from gridworld_gen import *

BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)
GOLD = (255,215,0)

if len(sys.argv) > 1:
	mode = sys.argv[1]

def main():
    '''
    maze = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           ,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    start_cell = (0, 0)
    goal_cell = (9, 9)

    maze=   [[0, 0, 0, 0, 0]
            ,[0, 0, 0, 0, 0]
            ,[0, 0, 0, 0, 0]
            ,[0, 0, 0, 0, 0]
            ,[0, 0, 0, 0, 0]]
    start_cell = (0, 0)
    goal_cell = (4, 4)
    '''

    gridworld = input("Select a 101x101 gridworld (0-49) or a 1001x1001 gridworld (50): ")
    start_cell, goal_cell, maze = gridworld_array(gridworld)

    MARGIN = 1
    WIDTH = int((GetSystemMetrics(0)-(102*MARGIN)) / (len(maze[0])))
    HEIGHT = int((GetSystemMetrics(1)-(102*MARGIN)) / (len(maze[0])))
    #WIDTH = 8
    #HEIGHT = 7

    pygame.init()
    size=(GetSystemMetrics(0), GetSystemMetrics(1))
    screen = pygame.display.set_mode(size, pygame.FULLSCREEN)
    done = False

    #initialize maze
    def reset():
        for i in range(len(maze)):
                for j in range(len(maze)):
                    if(start_cell[0] == i and start_cell[1] == j):
                        color = BLUE
                    elif(goal_cell[0] == i and goal_cell[1] == j):
                        color = GOLD
                    elif(maze[i][j] == 0):
                        color = WHITE
                    elif(maze[i][j] == 1):
                        color = BLACK
                    pygame.draw.rect(screen, color, [(MARGIN + WIDTH) * j + MARGIN, (MARGIN + HEIGHT) * i + MARGIN, WIDTH, HEIGHT])
    reset()

    while not done:
        for event in pygame.event.get(): 
            if event.type == pygame.QUIT: 
                done = True  
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    done = True
                if event.key == pygame.K_j:
                    reset()
                    pygame.display.flip()
                    time.sleep(1)
                    algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
                    path = algo.forwardAStar(maze, g="low")
                if event.key == pygame.K_k:
                    reset()
                    pygame.display.flip()
                    time.sleep(1)
                    algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
                    path = algo.forwardAStar(maze, g="high")
                if event.key == pygame.K_n:
                    reset()
                    pygame.display.flip()
                    time.sleep(1)
                    algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
                    path = algo.backwardAStar(maze, g="low")
                if event.key == pygame.K_m:
                    reset()
                    pygame.display.flip()
                    time.sleep(1)
                    algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
                    path = algo.backwardAStar(maze, g="high")
                if event.key == pygame.K_i:
                    reset()
                    pygame.display.flip()
                    time.sleep(1)
                    algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
                    path = algo.adaptiveAStar(maze, g="low")
                if event.key == pygame.K_o:
                    reset()
                    pygame.display.flip()
                    time.sleep(1)
                    algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
                    path = algo.adaptiveAStar(maze, g="high")
    
        pygame.display.flip()
    pygame.quit()

def export_data():
    f_astar_lowg_times = []
    f_astar_highg_times = []

    b_astar_lowg_times = []
    b_astar_highg_times = []

    adap_astar_lowg_times = []
    adap_astar_highg_times = []

    screen = pygame.display.set_mode((0,0), pygame.FULLSCREEN)

    for i in range(50):
        start_cell, goal_cell, maze = gridworld_array(i)
        algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
        start_time = time.time()

        path = algo.forwardAStar(maze, g="low", for_data="yes")
        end_time = time.time()
        f_astar_lowg_times.append(end_time - start_time)

    for i in range(50):
        start_cell, goal_cell, maze = gridworld_array(i)
        algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
        start_time = time.time()

        path = algo.forwardAStar(maze, g="high", for_data="yes")
        end_time = time.time()
        f_astar_highg_times.append(end_time - start_time)

    for i in range(50):
        start_cell, goal_cell, maze = gridworld_array(i)
        algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
        start_time = time.time()
        
        path = algo.backwardAStar(maze, g="low", for_data="yes")
        end_time = time.time()
        b_astar_lowg_times.append(end_time - start_time)

    for i in range(50):
        start_cell, goal_cell, maze = gridworld_array(i)
        algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
        start_time = time.time()
        
        path = algo.backwardAStar(maze, g="high", for_data="yes")
        end_time = time.time()
        b_astar_highg_times.append(end_time - start_time)
    
    for i in range(50):
        start_cell, goal_cell, maze = gridworld_array(i)
        algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
        start_time = time.time()

        path = algo.adaptiveAStar(maze, g="low", for_data="yes")
        end_time = time.time()
        adap_astar_lowg_times.append(end_time - start_time)

    for i in range(50):
        start_cell, goal_cell, maze = gridworld_array(i)
        algo = astar.AStar(start_cell, goal_cell, len(maze), screen)
        start_time = time.time()

        path = algo.adaptiveAStar(maze, g="high", for_data="yes")
        end_time = time.time()
        adap_astar_highg_times.append(end_time - start_time)

    x_axis = []
    for n in range(50):
        x_axis.append(n)

    #Generates graph for Forward A* High G vs Low G runtimes
    #################################################################
    # plt.plot(x_axis, f_astar_lowg_times, label="Low G")
    # plt.plot(x_axis, f_astar_highg_times, label ="High G")
    # plt.xlabel('Gridworld #')
    # plt.ylabel('Time in seconds')
    # plt.title('Forward A* Low G and High G run times')
    # plt.legend()
    # plt.show()
    # plt.savefig('forward_low_vs_high.png')
    #################################################################

    #Generates graph for Forward and Backward* High/Low G run times
    #################################################################
    # plt.clf()
    # plt.plot(x_axis, f_astar_lowg_times, label="Forward A* Low G")
    # plt.plot(x_axis, f_astar_highg_times, label ="Forward A* High G")
    # plt.plot(x_axis, b_astar_lowg_times, label="Backward A* Low G")
    # plt.plot(x_axis, b_astar_highg_times, label ="Backward A* High G")
    # plt.xlabel('Gridworld #')
    # plt.ylabel('Time in seconds')
    # plt.title('Forward A* vs Backward A* run times')
    # plt.legend()
    # plt.show()
    # plt.savefig('forward_vs_backward.png')
    #################################################################

    #Generates graph for Forward and Backward* High/Low G run times
    #################################################################
    # plt.clf()
    # plt.plot(x_axis, f_astar_lowg_times, label="Forward A* Low G")
    # plt.plot(x_axis, f_astar_highg_times, label ="Forward A* High G")
    # plt.plot(x_axis, adap_astar_lowg_times, label="Adaptive A* Low G")
    # plt.plot(x_axis, adap_astar_highg_times, label ="Adaptive A* High G")
    # plt.xlabel('Gridworld #')
    # plt.ylabel('Time in seconds')
    # plt.title('Forward A* vs Adaptive A* run times')
    # plt.legend()
    # plt.show()
    # plt.savefig('forward_vs_adaptive.png')
    #################################################################


    return

if __name__ == "__main__":
    main()
    #export_data()
            
    
