# Group 9 Readme 

### Root Directory
The code is organised into system and subsystems in the root directory. The file requirements.txt 
lists the python libraries required to run the system level script. They can all be installed by opening a shell in the 
repository and using the command 'pip install requirements.txt'.

### System Folder
The subsystems have no interdependencies or trade-offs and as such the system level optimisation
consists of minimising the functions of each subsystem. For this reason it was unnecessary to
write code for the system level optimisation. Inside this folder is Python code that was used
to scrape an internet database of rollercoasters and conduct an explanatory analysis on the data for research purposes.
It also runs a logistic regression model to determine which physical properties of the roller-coaster
result in it being successful or defunct, with the ability to take user input values and apply them 
to the logistic regression model. The code conducts analysis on how accurate the logistic regression model is
and returns various relevant plots saved in the folder. The time the code takes to execute depends on wether a new database is being built,
or if more data points are being appended to an existing database and how many data points are being retrieved/added. It is recommended to run the code with the pre-built dataset rather than building a new one. <br /> This is explained in terminal when the code is run.

### Subsystem 1 - Sophie Owen
### Subsystem 2 - Oli Thompson
The code for subsystem 2 is combined into a single matlab script for simplicity. The code calls a function to generate the database which is saved both inside the main script and as a separate matlab function file.  <br />
The main code runs through the following processes:
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

The size of the database can be altered by changing the value of the variable points on line 4. Building the database has a polynomial time compexity therefore it is recommended to not exceed the value of 20. The code takes roughly 1 minute to run.


### Subsystem 3 - Matthew Last
### Subsystem 4 - Federico Tiersen
