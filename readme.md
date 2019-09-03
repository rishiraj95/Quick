# Description

Quick is an algorithm used to mine gamma-quasi cliques from a connected graph with given parameters gamma and minsize.

# Requirements
> MATLAB 2016b and later

# Running Quick

### Host server

> mmstastn@boogaloo.math.uwaterloo.ca

### File Path

> RAID2/aguos_particles/Quick

Quick is called by `Doublejet_Quick.m`. To execute current version in MATLAB:

> `run Doublejet_Quick.m`

Doublejet_Quick uses the output files for a double jet flow. It also uses the adjacency matrix to create a connected graph. Subsequently it sets the paramaters \gamma and minsize before calling Quick. In order to call Quick on a different problem `Doublejet_Quick.m` needs to be modified. 

In `Quick.m`, the variable knear needs to be m0dified based on the values of gamma and minsize. An intuitive guide to it's selection is knear should be low for a densely connected graph. For more details on the selection of knear, visit:

> Liu, G. and Wong, L., 2008, September. Effective pruning techniques for mining quasi-cliques. In Joint European conference on machine learning and knowledge discovery in databases (pp. 33-49). Springer, Berlin, Heidelberg.
The pdf file is attached as "Quasi_Clique.pdf"
> Pei, J., Jiang, D. and Zhang, A., 2005, August. On mining cross-graph quasi-cliques. In Proceedings of the eleventh ACM SIGKDD international conference on Knowledge discovery in data mining (pp. 228-238). ACM.


