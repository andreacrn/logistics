#MODEL 1.1

#nType types of parking lots
#nSide sides of street
param nType;
param nSide;

set Type:= 1.. nType;
set Side:= 1.. nSide;

#Length{Type} is a vector that contains the space (length) of each parking lot
#Quantity{Type} is a vector that contains the required number of parking lots for each type
param Length{Type};
param Quantity{Type};

#QtyLocated is a matrix that contains the quantity per side of parking lots for each type
#w is an upper bound to the sum of parking lots length per side
var QtyLocated{Type, Side} integer >=0;
var w>=0;

#objective function: minimize w
minimize SideDifference: w;

#QuantityConstr specifies the quantity of parking lots required for each type
#LengthConstr sets w as an upper bound to the sum of length per side
#in order to balance our parking lots positions
subject to QuantityConstr {i in Type}: sum {j in Side} QtyLocated[i,j]== Quantity[i];
subject to LengthConstr {j in Side}: sum {i in Type} QtyLocated[i,j]*Length[i]<=w;
