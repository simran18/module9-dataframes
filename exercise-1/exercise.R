# Exercise 1: Creating data frames

# Create a vector of the number of points the Seahawks scored in each game this
# season (google "Seahawks" for the info!)
points <- c(12, 3, 37, 27, 26, 6, 20, 31, 26, 5, 40, 10, 24, 31, 25, 26, 20)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each game this season
points.allowed <- c(10, 9, 18, 17, 24, 6, 25, 25, 24, 15, 14, 7, 38, 3, 34, 23, 36)

# Combine your two vectors into a dataframe
games <- data.frame(points, points.allowed)

# Create a new column "diff" that is the difference in points.
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
games$diff <- games$points - games$points.allowed

# Create a new column "won" which is TRUE if the Seahawks won
games$won <- games$diff > 0

# Create a vector of the opponent names corresponding to the games played
opponents <- c('Dolphins', 'Rams', '49ers', 'Jets', 'Falcons', 'Cardinals', 'Saints', 'Bills', 'Patriots', 'Eagles', 'Buccaneers', 'Panthers', 'Rams', 'Cardinals', '49ers', 'Lions', 'Falcons')

# Assign your dataframe rownames of their opponents
rownames(games) <- opponents

# View your data frame to see how it has changed!
View(games)