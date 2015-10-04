Give the two input MIF files as input with -p1 and -p2 and the output file with -o. With argument -c, you can define in which grid resolution (0=2.0, 1=1.5, 2=1.0 and 3=0.5) you want to find mif similarities. The MIF at this resolution must have been calculated (see argument -z of mif). You can set a distance threshold with -d (in Angstroms) to determine the geometric variability between nodes in the association graph.

The example below will search mif similarities between the two query MIFs in the 1.5 Angstrom resolution grid:

./isoMif -p1 ./hive/mifs/1E8X.mif -p2 ./hive/mifs/1RDQ.mif -o ./hive/match/ -c 1 -d 2.0

You can also superimpose the MIFs using a list of corresponding atoms ids with the argument -c set to -2. To superimpose the MIFs based on the ATP molecules of 1E8X and 1RDQ, use argument -q to provide two lists (seperated by ' ') of corresponding ATP atoms ids (sep. by ','): -q 6833,6834,6836,6830,6828,6822,6826,6819,6824,6811 2964,2965,2967,2961,2959,2953,2957,2950,2955,2942.

./isoMif -p1 ./hive/mifs/1E8X.mif -p2 ./hive/mifs/1RDQ.mif -o ./hive/match/ -c -2 -q 6833,6834,6836,6830,6828,6822,6826,6819,6824,6811 2964,2965,2967,2961,2959,2953,2957,2950,2955,2942

The similarities using -c -2 are represented by the common potential interactions found at -d distance from each other in both MIFs after superimposition.

You can decide to identify all cliques of the association graph by specifying -s 1. By default, only the first clique is identified (-s 0). You can set -s to 1 but stop after a certain number of cliques are found, defined with the -a argument.

All the cliques identified will be printed in the output files with their score (nodes, tanimoto, RMSD of the clique, etc), the common interactions matched and their positions. To ommit printing the common interactions found in common (desired to save disk space in highthroughput) add argument '-e'.

You can also add the similarity in a suffix of the output file name ("_nodes_tanimoto") by adding '-w'.

The RMSD of a residue or bound molecule after the superimposition of the MIF similarities found in each clique can be printed in the filename (with -w) and in the output file name. Add argument '-l 1' and then specify the residue name, number, chain and alternate location (similarily with the MIF program). Don't forget to add a '-' when for example the alternative location wants to be ommited. For example:

./isoMif -p1 ./hive/mifs/1E8X.mif -p2 ./hive/mifs/1RDQ.mif -o ./hive/match/ -c 1 -l 1 -l1 ATP3000A- -l2 ATP600E-
