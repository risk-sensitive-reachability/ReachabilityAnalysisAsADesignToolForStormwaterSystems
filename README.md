## Overview
This repository contains the code necessary to calculate and visualize the safe sets presented in:
```
Chapman, et al., “Reachability Analysis as a Design Tool for Stormwater Systems,” 
  in 6th IEEE Conference on Technologies for Sustainability, November 2018.
```

This code demonstrates a proof-of-concept for applying reachability analysis to the design of stormwater systems. 

This repository is not a package or tool that is ready for broader application, though the work here may be used a starting point for such development in the future.  

## Dependencies
### Computational Environment
Running the code in this repository requires a recent version of Matlab __or__ GNU Octave. Both environments are supported by several modern operating systems. We have tested this repository under Windows 10 and Red Hat Enterprise Linux Server release 6.9 (Santiago). 

#### Matlab
Generating the exact artifacts used in the paper requires [__Matlab 2018a__](https://www.mathworks.com/products/matlab.html). Many academic institutions have site licenses that make Matlab available to students and faculty for free. 

#### GNU Octave
[__GNU Octave__](https://www.gnu.org/software/octave/) is an open source computational environment that is available for free and is largely compatible with routines written for the Matlab environment. While we cannot guarantee the exactness of the results between environments, the differences in this particular application were found to be negligible. The only notable difference is in the shading and transparency of some of the 3-d plots. In our tests the simulations run in the Octave environment (version 5.1.0) ran considerably slower than in Matlab, but no attempts were made to optimize for execution in the Octave environment. 

### Packages
We are grateful to the authors of the following packages which made this project possible. 

#### ToolboxLS
[ToolboxLS](https://bitbucket.org/ian_mitchell/toolboxls) is a Matlab toolbox for Level Set analysis written by [Ian Mitchell](https://www.cs.ubc.ca/~mitchell/). The verison packaged with this repository has been ported from [Mercurial](https://www.mercurial-scm.org/) to [git](https://git-scm.com/) as the source control mechanism, but otherwise remains unchanged. 

#### helperOC
[helperOC](https://github.com/HJReachability/helperOC) is a Matlab toolbox for Hamilton-Jacobi reachability analysis maintained by the HJ Reachability Group at UC Berkeley (https://github.com/HJReachability/). The version packaged with this repository has slight modifications to add Octave compatibility to the portions of helperOC used in our analysis. 

## Setup Instructions
### Install Matlab or Octave
We used [Matlab](https://www.mathworks.com/products/matlab.html) 2018a and [Octave](https://www.gnu.org/software/octave/download.html) 5.1.0. 

### Download a Copy of this Repository (with ToolboxLS and helperOC included)
Using [git](https://git-scm.com/) is the easiest way to download a copy of all the files you need to get up and running in Matlab or Octave. We tested these instructions against git v2.8.2.396. 

The files will be downloaded to a folder named __ReachabilityAnalysisAsADesignToolForStormwaterSystems__. 

From a command line interface, navigate to the directory where you would like to download __ReachabilityAnalysisAsADesignToolForStormwaterSystems__. 

Then execute the following command: 
```
git clone --recurse-submodules https://github.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems
```

![git-clone](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/GitClone.gif)

### Running in Matlab
#### Setup Matlab Workspace
To setup your Matlab workspace: 
 - navigate to the parent directory containing __ReachabilityAnalysisAsADesignToolForStormwaterSystems__
 - from the left-hand file tree, right click on __ReachabilityAnalysisAsADesignToolForStormwaterSystems__ and select __Add To Path > Selected Folders and Subfolders__.
 - double-click on the __ReachabilityAnalysisAsADesignToolForStormwaterSystems__ folder in the left-hand file tree to set the it as the active working directory

![setup-matlab-workspace](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/SetupWorkspaceMatlab.gif)

#### Run Scenario
To run a scenario, call the Run_Scenario command from the command window. The first argument is a character identifying the scenario to run and the second argument is an integer identifying the simulator configuration to use. See the scenarios and configurations section below for more details. 

![run-scenario-matlab](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/RunScenarioInMatlab.gif)

### Running in Octave
#### Setup Octave Workspace
To setup your Octave workspace: 
 - navigate to the parent directory containing __ReachabilityAnalysisAsADesignToolForStormwaterSystems__
 - double-click on the __ReachabilityAnalysisAsADesignToolForStormwaterSystems__ folder in the left-hand file tree to set the it as the active working directory

![setup-octave-workspace](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/SetupWorkspaceOctave.gif)

#### Run Scenario
To run a scenario, call the Run_Scenario command from the command window. The first argument is a character identifying the scenario to run and the second argument is an integer identifying the simulator configuration to use. See the scenarios and configurations section below for more details. 

![run-scenario-octave](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/RunScenarioInOctave.gif)

### Simulation Artifacts
Figures and a copy of the final state of the simulation environment will be saved to the outputs directory. The subdirectory pattern is /configID/scenarioID/date-time-simulation-completed/.

### Running on an High-Performance Computing Cluster
The reachability computations in this repository are CPU intensive but only require about 500Mb of memory per scenario when run in Matlab using a command line interface. 

The following is an example command that can be used to run a scenario from a command line environment: 
```
matlab -r "Run_Scenario_And_Exit('A',1)"
```
Many clusters will have a mechanism for running an 'array' of tasks in parallel. An example script for executing all scenarios in parallel on clusters using the [Slurm](https://slurm.schedmd.com/) scheduler is provided in `/misc/runAll.sh`. Each scenario will run in its own Matlab instance. Try running a single simulation to get a sense of how running all the simulations will impact your compute budget. 

## System Schematics
The paper demonstrates reachability analysis for both a 'two state' and a 'three state' system. General schematics for each are shown below. 

### Two State System
The 'two state' system is a simplified representation that behaves as if Pond 2 does not exist. Safe sets for the two state system are presented as two dimensional figures in the paper and have numerical scenario identifiers. These two dimensional figures are mostly to aid in building intuition about safe sets before approaching the three state system. 

![two-state-system](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/TwoStateSystem.png)

### Three State System
The three state system augments the two state system with Pond 2. Safe sets for the three state system are presented as three dimensional figures in the paper and have alphabetical scenario identifiers. The three dimensional figures allow us to visualize the surface of the safe set, which highlights the interdependencies of the system. 

![three-state-system](https://raw.githubusercontent.com/risk-sensitive-reachability/ReachabilityAnalysisAsADesignToolForStormwaterSystems/master/misc/ThreeStateSystem.png)

## Scenarios and Configurations
### Scenarios
Each 'scenario' is a particular combination of a description of the system under study and the disturbances it is subjected to. Each scenario is discussed in more detail in the paper. 

### Configurations
Each 'configuration' provides a unique set of instructions to the underlying simulation infrastructure, such as the length of the simulation, the grid size, and the numerical accuracy. In the paper, we ran all simulations of the three state system using configuration 1 and all simulations of the two state system using configuration 2. Compared with configuration 1, configuration 2 uses a denser grid, updates the plot less frequently, and progressively adds the level set contours to the plot throughout the simulation. 

### Mappings
This table provides a mapping between the safe sets presented in the paper's figures and the command that can be used generate them (sans some annotations that were added manually). 

| Figure | Plot Title   | Scenario | Configuration | Command to Generate  |
|--------|--------------|----------|---------------|----------------------|
| 3      | Scenario I   | 1        | 2             | Run_Scenario('1', 2) |
| 3      | Scenario II  | 2        | 2             | Run_Scenario('2', 2) |
| 3      | Scenario III | 3        | 2             | Run_Scenario('3', 2) |
| 3      | Scenario IV  | 4        | 2             | Run_Scenario('4', 2) |
| 3      | Scenario V   | 5        | 2             | Run_Scenario('5', 2) |
| 3      | Scenario VI  | 6        | 2             | Run_Scenario('6', 2) |
| 7      | Scenario A   | A        | 1             | Run_Scenario('A', 1) |
| 7      | Scenario B   | B        | 1             | Run_Scenario('B', 1) |
| 7      | Scenario C   | C        | 1             | Run_Scenario('C', 1) |
| 7      | Scenario D   | D        | 1             | Run_Scenario('D', 1) |
| 7      | Scenario E   | E        | 1             | Run_Scenario('E', 1) |
| 7      | Scenario F   | F        | 1             | Run_Scenario('F', 1) |
| 7      | Scenario G   | G        | 1             | Run_Scenario('G', 1) |
| 7      | Scenario H   | H        | 1             | Run_Scenario('H', 1) |
| 7      | Scenario I   | I        | 1             | Run_Scenario('I', 1) |
| 7      | Scenario J   | J        | 1             | Run_Scenario('J', 1) |
| 7      | Scenario K   | K        | 1             | Run_Scenario('K', 1) |
| 7      | Scenario L   | L        | 1             | Run_Scenario('L', 1) |
| 8      | Scenario M   | M        | 1             | Run_Scenario('M', 1) |
| 8      | Scenario N   | N        | 1             | Run_Scenario('N', 1) |
| 8      | Scenario O   | O        | 1             | Run_Scenario('O', 1) |
| 8      | Scenario P   | P        | 1             | Run_Scenario('P', 1) |


## Important Files
#### Run_Scenario.m
Call this function to run a particular scenario with a particular configuration. 

#### Run_Scenario_And_Exit.m
This is a wrapper around Run_Scenario.m that exits the computational environment with success (status 0) upon completion. This is useful when running on a high-performance computing cluster. 

#### /@Watershed/dynamics.m
This file describes the dynamics of how each state in the system evolves. 

#### /@Watershed/optCtrl.m
This file describes the optimal control of binary bang-bang controller on the pond outlet.  

#### /helper_functions/Setup_Reachability.m
This method pulls the scenario and configuration settings, sets up the computational grid, and bootstraps the plotting variables. 

#### /helper_functions/Watershed_Reachability.m
This method sets up the structures required by the `HJIPDE_solve` method in helperOC and then executes it. The call to `HJIPDE_solve` is the entry point for all reachability calculations. 

#### /helper_functions/Generate_Outputs.m
This method generates plots in the output directory. 
