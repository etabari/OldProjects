# Generating Trees with N internal nodes and K leaves.

This is a Delphi implementation of my Master's Thesis. 

The main concern of this thesis is trees with `n` internal nodes and `k` external nodes (leaves) denoted as `T(n,k)`.
New algorithms for generation, ranking and unranking of these trees in A-order are introduced; So, a new integer sequence codeword, called E-sequence, is presented and shown that A-order over the set of `T(n,k)` matches 
lexicographic order over the set of corresponding E-sequences.

One important application of trees with `n` nodes and `k` leaves is in generating secondary structures of RNAs with `2n+k-2` nucleotides and `n-1` basepairs.

Time complexity of generation algorithm is `O(n+k)` while the only  generation algorithm existed before is of `O(nk)`. No other rank nor unrank algorithms were known in the literature.


To use this code, please cite the following:

A new algorithm for generation of different types of RNA
E. Seyedi-Tabari, H. Ahrabian, and A. Nowzari-Dalini
International Journal Of Computer Mathematics Vol. 87 , Iss. 6,2010
http://www.tandfonline.com/doi/full/10.1080/00207160802140049
