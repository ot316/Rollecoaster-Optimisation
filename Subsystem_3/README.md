## Subsystem 3
2 code files are included in this subsystem. ‘CoasterLoop’ takes in an array of parameters [G-force parameter C, Maximum height, maximum curvature] and outputs a score based on the difference between the generated plot of G-forces and a given plot of safe G-force levels. The code also generates 3 graphs 
*	A model of the profile of the loop.
*	The 2 G-force plots over time
*	The difference between the 2 plots  

  
‘CoasterLoopOptimisation’ demonstrates the optimization algorithm used to find the optimum parameters referred to in the report. It uses the fmincon function to do this, with the ‘SPQ’ algorithm. Constraints on the lower and upper boundaries of the parameters and initial start parameters are included, as are tic and toc functions to give the operating time of the optimiser.
To see both in action, run the ‘CoasterLoopOptimisation’ code.
This code requires no libraries to run
