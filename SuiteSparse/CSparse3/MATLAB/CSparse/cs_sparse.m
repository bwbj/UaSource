function A = cs_sparse (i,j,x)                                              %#ok
%CS_SPARSE convert a triplet form into a sparse matrix.
%   A = cs_sparse(i,j,x) is identical to A = sparse(i,j,x), except that x must
%   be real, and the length of i, j, and x must be the same.
%
%   Example:
%       Prob = UFget ('HB/arc130') ; S = Prob.A ;
%       [i j x] = find (S) ;
%       A = cs_sparse (i,j,x) ;
%       S-A
%
%   See also FIND, SPARSE, SPCONVERT.

%   Copyright 2006-2007, Timothy A. Davis.
%   http://www.cise.ufl.edu/research/sparse

error ('cs_sparse mexFunction not found') ;
