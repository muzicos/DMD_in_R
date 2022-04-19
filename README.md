# DMD package in R
Below are a number of functions for performing DMD in an R based environment.

# dmd.R
Basic DMD algorithm <br />
dmd(X, Xprime, modes = 0) <br />
X -> state data minus the final state <br />
Xprime (X') -> State data shifted by a single time step <br />
modes -> default:0, desired eigen modes for decomposition <br />

# dmdc.R
Group of functions meant for DMD for control system analysis and system ID <br />
dmdA(X, Xprime, B = matrix(), Ups = 0) <br />
Used the identify plant matrix A when control matrix B is known. B default to empty matrix. May solve A incorrectly if data given without knowledge of B. <br />
X -> state data minus the final state <br />
Xprime (X') -> State data shifted by a single time step <br />
B -> default:(), contorl matrix for system <br />
Ups ->default:0, controller state <br />

dmdc(X, Xprime, Ups, thresh = 1e-10)  <br />
Used to approximate A and B in the case that B is unknown. Form G matrix as concatenated version of A and B with state data.  <br />
X -> state data minus the final state <br />
Xprime (X') -> State data shifted by a single time step <br />
Ups -> controller state <br />
thresh -> default:1e-10, threshold to determine minimum number of modes to utilize in approximation <br />
