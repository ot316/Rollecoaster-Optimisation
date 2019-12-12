# Subsystem 2

## Main Script
The code for subsystem 2 is combined into a single matlab script for simplicity called SubSystem2Main.m. The code calls a function to generate the database which is saved both inside the main script and as a separate matlab function file.
The main code runs through the following processes:

## Explanation
Define each variable as arrays between constraint values
Define latin hypercube sampling arrays for each variable
Build a database with the sampled data
Shuffle Data
Normalise Data
Split data into labels and features
Split data into testing and training dataset
Train linear regression model
Find R squared value
Use fmincon on the linear regression function
Use genetic algorithm on the linear regression function
Remove normalisation
Conduct parametric analysis
Reformulate problem as multiobjective function
Find pareto set
Use fgoalattain on the multi objective formulas

# Execution time
The size of the database can be altered by changing the value of the variable points on line 4. Building the database has a polynomial time compexity therefore it is recommended to not exceed the value of 20. The code takes roughly 1 minute to run.

# Dependencies
Matlab 2019b
