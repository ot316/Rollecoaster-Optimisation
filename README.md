# Group 9 Readme 

## Root Directory
The code is organised into system and subsystems in the root directory. The file requirements.txt 
lists the required python libraries and they can all be installed by opening a shell in the 
repository and using the command 'pip install requirements.txt'.

## System Folder
The subsystems have no interdependencies or trade-offs and as such the system level optimisation
consists of minimising the functions of each subsystem. For this reason it was unnecessary to
write code for the system level optimisation. Inside this folder is Python code that was used
to scrape an internet database of rollercoasters and conduct an explanatory analysis on the data.
It also runs a logistic regression model to determine which physical properties of the roller-coaster
result in it being successful or defunct, with the ability to take user input values and apply them 
to the logistic regression mode.
