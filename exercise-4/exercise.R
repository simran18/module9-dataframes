# Exercise 4: Working with Data Frames

# Read the data from the `data/gates_money.csv` file into a variable called
# `grants` using the `read.csv()` function
# Be sure to set your working directory, and do NOT treat strings as factors!
grants <- read.csv('data/gates_money.csv', stringsAsFactors = FALSE)

# Use the View function to look at the loaded data
View(grants)

# Create a variable `organization` as the `organizationtotal.amount` column of the dataset
organization <- grants$organization

# Confirm that the "organization" column is a vector using the `is.vector()`
# This is a useful debugging tip if you hit errors later!
is.vector(organization)

# What was the mean grant value?
mean.spending <- mean(grants$total_amount)

# What was the dollar amount of the largest grant?
highest.amount <- max(grants$total_amount)

# What was the dollar amount of the smallest grant?
lowest.amount <- min(grants$total_amount)

# Which organization received the largest grant?
largest.recipent <- organization[grants$total_amount == highest.amount]

# Which organization received the smallest grant?
smallest.recipent <- organization[grants$total_amount == lowest.amount]

# How many grants were awarded in 2010?s
length(grants$total_amount[grants$start_year == 2010])