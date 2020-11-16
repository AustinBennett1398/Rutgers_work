from heapq import *
import pygame
import time
from win32api import GetSystemMetrics

BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)
GOLD = (255,215,0)

MARGIN = 1

class AStar:
	def __init__(self, startState, endState, grid, screen):
		self.gridSize, self.startState, self.endState = grid, startState, endState
		#List of variables 
		self.hValue, self.distance, self.time = None, None, None
		self.gValue, self.c = set(), set()
		self.fValue, self.grid = {}, []
		self.screen = screen
		self.WIDTH = int(GetSystemMetrics(0) / grid - 1)
		self.HEIGHT = int(GetSystemMetrics(1) / grid - 1)

	def manhattanDistance(self, firstValue, secondValue):
		mDistance = abs(firstValue[0] - secondValue[0]) + abs(firstValue[1] - secondValue[1])
		return mDistance

	def initialSetup(self, x):
		surrounding = [(0, 1), (0, -1), (1, 0), (-1, 0)]
		closedSet, lastIter, openSet = set(), {}, []
		if(x == "forward"):
			gScore = {self.startState: 0}
			fScore = {self.startState: self.manhattanDistance(self.startState, self.endState)}
		elif(x == "backward"):
			gScore = {self.endState: 0}
			fScore = {self.endState: self.manhattanDistance(self.endState, self.startState)}
		return surrounding, closedSet, lastIter, openSet, gScore, fScore

	def forwardAStar(self, array, g, for_data="no"):
		surrounding, closedSet, lastIter, openSet, gScore, fScore = AStar.initialSetup(self, x="forward")
		heappush(openSet, (fScore[self.startState], self.startState))

		while openSet:
			curr = heappop(openSet)[1]
			if curr == self.endState:
				path = []
				while curr in lastIter:
					#Display the final path
					if(for_data == "no"):
						pygame.draw.rect(self.screen, GOLD, [(MARGIN + self.WIDTH) * curr[1] + MARGIN, (MARGIN + self.HEIGHT) * curr[0] + MARGIN, self.WIDTH, self.HEIGHT])
						pygame.display.update()
					path.append(curr)
					curr = lastIter[curr]
				if(for_data == "no"):
					self.distance = len(path)
				return path
			closedSet.add(curr)
			self.c.add(curr)

			for c1, c2 in surrounding:	
				new_cell = curr[0] + c1, curr[1] + c2
				provisionalGScore = self.manhattanDistance(curr, new_cell) + gScore[curr]
				self.hValue = self.manhattanDistance(curr, self.endState)

				if new_cell[0] >= 0 and self.gridSize > new_cell[0]:
					if new_cell[1] >= 0 and self.gridSize > new_cell[1]:
						if array[new_cell[0]][new_cell[1]] == 1:
							continue
					else:
						continue
				else:
					continue
				if(g == "low"):	
					if new_cell in closedSet and provisionalGScore >= gScore.get(new_cell, 0):
						continue

					if provisionalGScore < gScore.get(new_cell, 0) or new_cell not in [i[1] for i in openSet]:
						self.gValue.add(provisionalGScore)
						lastIter[new_cell], gScore[new_cell], fScore[new_cell] = curr, provisionalGScore, provisionalGScore + self.manhattanDistance(new_cell, self.endState)
						self.fValue = fScore
						#display explored cells
						if(for_data == "no"):
							#time.sleep(1)
							pygame.draw.rect(self.screen, GREEN, [(MARGIN + self.WIDTH) * new_cell[1] + MARGIN, (MARGIN + self.HEIGHT) * new_cell[0] + MARGIN, self.WIDTH, self.HEIGHT])
							pygame.display.update()
						heappush(openSet, (fScore[new_cell], new_cell))
				if(g == "high"):
					if new_cell in closedSet:
						continue

					if provisionalGScore > gScore.get(new_cell, 0) or new_cell not in [i[1] for i in openSet]:
						self.gValue.add(provisionalGScore)
						lastIter[new_cell], gScore[new_cell], fScore[new_cell] = curr, provisionalGScore, provisionalGScore + self.manhattanDistance(new_cell, self.endState)
						self.fValue = fScore
						#display explored cells
						if(for_data == "no"):
							#time.sleep(1)
							pygame.draw.rect(self.screen, GREEN, [(MARGIN + self.WIDTH) * new_cell[1] + MARGIN, (MARGIN + self.HEIGHT) * new_cell[0] + MARGIN, self.WIDTH, self.HEIGHT])
							pygame.display.update()
						heappush(openSet, (fScore[new_cell], new_cell))
		print("No Path")
		return False

	def backwardAStar(self, array, g, for_data="no"):
		surrounding, closedSet, lastIter, openSet, gScore, fScore = AStar.initialSetup(self, x="backward")
		heappush(openSet, (fScore[self.endState], self.endState))

		while openSet:
			curr = heappop(openSet)[1]
			if curr == self.startState:
				path = []
				while curr in lastIter:
					#Display the final path
					if(for_data == "no"):
						pygame.draw.rect(self.screen, GOLD, [(MARGIN + self.WIDTH) * curr[1] + MARGIN, (MARGIN + self.HEIGHT) * curr[0] + MARGIN, self.WIDTH, self.HEIGHT])
						pygame.display.update()
					path.append(curr)
					curr = lastIter[curr]
				self.distance = len(path)
				return path
			closedSet.add(curr)
			self.c.add(curr)

			for c1, c2 in surrounding:	
				new_cell = curr[0] + c1, curr[1] + c2
				provisionalGScore = self.manhattanDistance(curr, new_cell) + gScore[curr]
				self.hValue = self.manhattanDistance(curr, self.endState)

				if new_cell[0] >= 0 and self.gridSize > new_cell[0]:
					if new_cell[1] >= 0 and self.gridSize > new_cell[1]:
						if array[new_cell[0]][new_cell[1]] == 1:
							continue
					else:
						continue
				else:
					continue



				if(g == "low"):
					if new_cell in closedSet and provisionalGScore >= gScore.get(new_cell, 0):
						continue

					if provisionalGScore < gScore.get(new_cell, 0) or new_cell not in [i[1] for i in openSet]:
						self.gValue.add(provisionalGScore)
						lastIter[new_cell], gScore[new_cell], fScore[new_cell] = curr, provisionalGScore, provisionalGScore + self.manhattanDistance(new_cell, self.startState)
						#display explored cells
						if(for_data == "no"):
							pygame.draw.rect(self.screen, GREEN, [(MARGIN + self.WIDTH) * new_cell[1] + MARGIN, (MARGIN + self.HEIGHT) * new_cell[0] + MARGIN, self.WIDTH, self.HEIGHT])
							pygame.display.update()
						heappush(openSet, (fScore[new_cell], new_cell))

				if(g == "high"):
					if new_cell in closedSet:
						continue
					
					if provisionalGScore > gScore.get(new_cell, 0) or new_cell not in [i[1] for i in openSet]:
						self.gValue.add(provisionalGScore)
						lastIter[new_cell], gScore[new_cell], fScore[new_cell] = curr, provisionalGScore, provisionalGScore + self.manhattanDistance(new_cell, self.startState)
						#display explored cells
						if(for_data == "no"):
							pygame.draw.rect(self.screen, GREEN, [(MARGIN + self.WIDTH) * new_cell[1] + MARGIN, (MARGIN + self.HEIGHT) * new_cell[0] + MARGIN, self.WIDTH, self.HEIGHT])
							pygame.display.update()
						heappush(openSet, (fScore[new_cell], new_cell))

		print("No Path")
		return False

	def adaptiveAStar(self, array, g, for_data="no"):
		surrounding, closedSet, lastIter, openSet, gScore, fScore = AStar.initialSetup(self, x="forward")
		heappush(openSet, (fScore[self.startState], self.startState))

		while openSet:
			curr = heappop(openSet)[1]
			if curr == self.endState:
				path = []
				while curr in lastIter:
					#Display the final path
					if(for_data == "no"):
						pygame.draw.rect(self.screen, GOLD, [(MARGIN + self.WIDTH) * curr[1] + MARGIN, (MARGIN + self.HEIGHT) * curr[0] + MARGIN, self.WIDTH, self.HEIGHT])
						pygame.display.update()
					path.append(curr)
					curr = lastIter[curr]
				if(for_data == "no"):
					self.distance = len(path)
				return path
			closedSet.add(curr)
			self.c.add(curr)

			for c1, c2 in surrounding:	
				new_cell = curr[0] + c1, curr[1] + c2
				provisionalGScore = self.manhattanDistance(curr, new_cell) + gScore[curr]
				self.hValue = self.manhattanDistance(curr, self.endState)

				if new_cell[0] >= 0 and self.gridSize > new_cell[0]:
					if new_cell[1] >= 0 and self.gridSize > new_cell[1]:
						if array[new_cell[0]][new_cell[1]] == 1:
							continue
					else:
						continue
				else:
					continue
				if(g == "low"):	
					if new_cell in closedSet and provisionalGScore >= gScore.get(new_cell, 0):
						continue

					if provisionalGScore < gScore.get(new_cell, 0) or new_cell not in [i[1] for i in openSet]:
						self.gValue.add(provisionalGScore)
						lastIter[new_cell], gScore[new_cell], fScore[new_cell] = curr, provisionalGScore, provisionalGScore + self.manhattanDistance(new_cell, self.endState)
						self.fValue = fScore
						#display explored cells
						if(for_data == "no"):
							#time.sleep(1)
							pygame.draw.rect(self.screen, GREEN, [(MARGIN + self.WIDTH) * new_cell[1] + MARGIN, (MARGIN + self.HEIGHT) * new_cell[0] + MARGIN, self.WIDTH, self.HEIGHT])
							pygame.display.update()
						heappush(openSet, (fScore[new_cell], new_cell))
				if(g == "high"):
					if new_cell in closedSet:
						continue

					if provisionalGScore > gScore.get(new_cell, 0) or new_cell not in [i[1] for i in openSet]:
						self.gValue.add(provisionalGScore)
						lastIter[new_cell], gScore[new_cell], fScore[new_cell] = curr, provisionalGScore, provisionalGScore + self.manhattanDistance(new_cell, self.endState)
						self.fValue = fScore
						#display explored cells
						if(for_data == "no"):
							#time.sleep(1)
							pygame.draw.rect(self.screen, GREEN, [(MARGIN + self.WIDTH) * new_cell[1] + MARGIN, (MARGIN + self.HEIGHT) * new_cell[0] + MARGIN, self.WIDTH, self.HEIGHT])
							pygame.display.update()
						heappush(openSet, (fScore[new_cell], new_cell))

		print("No Path")
		return False