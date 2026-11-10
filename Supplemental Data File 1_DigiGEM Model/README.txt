DigiGEM v1
==========

DigiGEM is a genome-scale metabolic model of Digitalis lanata developed to study the metabolic cost of cardenolide biosynthesis and growth-defense tradeoffs.

FILES
-----
DigiGEM_v1.xml
    SBML version of the DigiGEM model.

DigiGEM_v1.mat
    MATLAB/COBRA Toolbox version of the DigiGEM model.

DigiGEM_v1_demo.m
    Short demonstration script showing how to:
      1. Load DigiGEM
      2. Set the weighted biomass/cardenolide objective
      3. Run flux balance analysis (FBA)
      4. Run flux variability analysis (FVA)
      5. Perform a simple in silico reaction knockout

REQUIREMENTS
------------
- MATLAB
- COBRA Toolbox v3.0 or compatible version
- A solver configured for use with COBRA Toolbox

OBJECTIVE FUNCTION
------------------
The primary DigiGEM objective jointly optimizes biomass production and terminal cardenolide pathway flux.

Objective reactions and weights:

    BIO_L           693
    Add_Card13_c    100
    Add_Card14_c    100
    Add_Card15_c    100

These weights correspond to a normalized relative cardenolide weight of approximately 0.144 when the biomass coefficient is set to 1.

RUNNING THE DEMO
----------------
1. Place DigiGEM_v1.mat and DigiGEM_v1_demo.m in the same folder.
2. Start MATLAB.
3. Initialize the COBRA Toolbox if it is not already initialized.
4. Change the MATLAB working directory to the folder containing the DigiGEM files.
5. Run:

       DigiGEM_v1_demo

The script reports the optimized biomass and cardenolide pathway fluxes, displays FVA ranges for the objective reactions, and performs a simple knockout of the P450scc cardenolide reaction (Add_Card20_c).

MODEL NOTES
-----------
DigiGEM is a compartmentalized genome-scale model of Digitalis lanata that extends a plant primary-metabolism reconstruction with Digitalis-specific cardenolide biosynthesis and associated steroid, brassinosteroid, and terpenoid pathway updates.

The demo script is intended as a minimal reproducibility example. More extensive simulations can be performed using standard COBRA Toolbox functions.

CITATION
--------
Please cite the DigiGEM manuscript/publication when using this model.

Manuscript title:
The Foxglove Genome-Scale Metabolic Model Reveals the Cost of Herbivory Defense

Authors:
Rachael Hageman Blair, Emily Carroll, Tiange Shi, and Zhen Q. Wang

VERSION
-------
DigiGEM v1
