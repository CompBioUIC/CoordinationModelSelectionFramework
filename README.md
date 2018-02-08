# CoordinationModelSelectionFramework
Devloper, Chainarong Amornbunchornvej, February 2018
Email: camorn2@uic.edu

Welcome to Coordination Model selection framework Version 1.1 Support Page
This framework is designed to predict the model that generated time series of coordination events.

INSTRUCTION:
- The main file of framework is 'FrameworkMain.m' Please run this file to use our framework. The inputs and outputs descriptions are in the comments in this file.
- We use the simulated data to conduct the analysis in our KDD papers from the folders below
1. DM_F1.00PR1.00 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from HM strategy function where everyone follows ID1 with probability PR1. The file 'mainDM1.m' has been used to report the result of this set of data in our paper.

2. DM_F1.00PR0.75 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from HM strategy function where everyone follows ID1 with probability PR0.75. The file 'mainDM2.m' has been used to report the result of this set of data in our paper.

3. DM_F1.00PR0.50 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from HM strategy function where everyone follows ID1 with probability PR0.50. The file 'mainDM3.m' has been used to report the result of this set of data in our paper.

4. DM_F1.00PR0.25 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from HM strategy function where everyone follows ID1 with probability PR0.25. The file 'mainDM4.m' has been used to report the result of this set of data in our paper.

5. LRA_F1.00 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from LRA strategy function. The file 'mainLRA.m' has been used to report the result of this set of data in our paper. 

6. HMLRARatio0.50 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from HM&LRA strategy functions where half of individuals use HM but the rest of them use LRA. The file 'mainHMLRA.m' has been used to report the result of this set of data in our paper.

7. MixedStrPr0.50 contains 100 datasets, each TrajectoryXY#.mat contains a set of time series of a coordination event generated from the mixing of HM & LRA strategy function where each individual use either HM or LRA with probability at 0.5 for any time step t. The file 'mainMixedStr.m' has been used to report the result of this set of data in our paper.

8. RAND contains 100 datasets of time series that generated from 20 agents moving toward uniformly and randomly direction.

9. The data and code for baboon analysis is at 'anotherBaboon' folder.

10. The data for fish analysis is at 'Fish' folder where the code is at 'FishLocalMain.m'.
