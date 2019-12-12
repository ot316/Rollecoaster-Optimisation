# Group 9 Readme 

## Root Directory
The code is organised into system and subsystems in the root directory. The file requirements.txt 
lists the python libraries required to run the system level script. They can all be installed by opening a shell in the 
repository and using the command 'pip install requirements.txt'.

## System Folder
The subsystems have no interdependencies or trade-offs and as such the system level optimisation
consists of minimising the functions of each subsystem. For this reason it was unnecessary to
write code for the system level optimisation. Inside this folder is Python code that was used
to scrape an internet database of rollercoasters and conduct an explanatory analysis on the data for research purposes.
It also runs a logistic regression model to determine which physical properties of the roller-coaster
result in it being successful or defunct, with the ability to take user input values and apply them 
to the logistic regression model. The code conducts analysis on how accurate the logistic regression model is
and returns various relevant plots saved in the folder. The time the code takes to execute depends on wether a new database is being built,
or if more data points are being appended to an existing database and how many data points are being retrieved/added. It is recommended to run the code with the pre-built dataset rather than building a new one. This is explained in terminal when the code is run.

## Subsystem 1
## Subsystem 2
The code for subsystem 2 is combined into a single matlab script dor simplicity.
## Subsystem 3
## Subsystem 4
