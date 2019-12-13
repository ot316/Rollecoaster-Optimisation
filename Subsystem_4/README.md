Run the main.m file, which calls functions as follows:

1. smoothLaunchSampling computes feasible launch track geometries for a range of track lengths and curvature derivatives. Execution of this function might take over a minute.

2. objectiveVisualisation computes the design space, filtering out unfeasible designs.

3. geneticAlgorithm solves the problem.

4. patternSearch attempts to solve the problem, but returns an indexing error before converging to the global minimum as the mesh attempts to poll non-integer values.
