# Subsystem 2

## Main Script
The code for subsystem 2 is combined into a single matlab script for simplicity called SubSystem2Main.m. The code calls a function to generate the database which is saved both inside the main script and as a separate matlab function file.
The main code runs through the following processes:

## Explanation
1. Define each variable as arrays between constraint values
2. Define latin hypercube sampling arrays for each variable
3. Build a database with the sampled data
4. Shuffle Data
5. Normalise Data
6. Split data into labels and features
7. Split data into testing and training dataset
8. Train linear regression model
9. Find R squared value
10. Use fmincon on the linear regression function
11. Use genetic algorithm on the linear regression function
12. Remove normalisation
13. Conduct parametric analysis
14. Reformulate problem as multiobjective function
15. Find pareto set
16. Use fgoalattain on the multi objective formulas

## Execution time
The size of the database can be altered by changing the value of the variable points on line 4. Building the database has a polynomial time compexity therefore it is recommended to not exceed the value of 20. The code takes roughly 1 minute to run.

## Dependencies
Matlab 2019b
