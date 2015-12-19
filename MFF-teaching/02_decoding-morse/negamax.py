# a game for 2 players
# there are 5 piles of matches
# players take turns
# in one move a player can pick a pile and take any ammount of matches (>=1)
# player who picks last match looses

# Recursive NegaMax function
def recursiveNegaMax(state, path, alpha, beta):
	if sum(state) == 0: # no matches in any pile (base of the recursion)
		return [1, list(path)] # list(x) creates a copy of path to return as solution

	bestSolution = (-99, []) # leafs only have values -1, 1
	for i in range(len(state)): # for every pile
		for j in range(state[i], 0, -1): # for every ammount of matches
			path.append(list(state)) # add the state to path
			state[i] = state[i]-j # adjust state for recursion

			# recursive call
			value,solution = recursiveNegaMax(state, path, (-1)*beta, (-1)*alpha)
			value *= (-1) # negaMax

			# return the state to original state before recursion
			state[i] = state[i]+j
			path.pop()

			if bestSolution[0] < value: # check for better solution (maximum)
				bestSolution = value,solution

			alpha = max(alpha, value) # alpha-beta pruning
			if alpha >= beta: break

	return bestSolution

# helper function for calling negaMax
def negaMax(state):
	return recursiveNegaMax(state, [], -99, 99)

print(negaMax([7,5,3,1]))
