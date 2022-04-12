#MODEL 1.2

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

#SideLocatedType3{Side} is a vector that contains 1 if at least one parking lot of type 3 is allocated
# in that side, 0 otherwise
var SideLocatedType3{Side} binary;

#objective function: minimize w
minimize SideDifference: w;

#QuantityConstr specifies the quantity of parking lots required for each type
#LengthConstr sets w as an upper bound to the sum of length per side
#in order to balance our parking lots positions
subject to QuantityConstr {i in Type}: sum {j in Side} QtyLocated[i,j]== Quantity[i];
subject to LengthConstr {j in Side}: sum {i in Type} QtyLocated[i,j]*Length[i]<=w;

#LeftSideConstr sets the total maximum length of parking lots in left side
#SideType3Constr specifies that parking lots of type 3 can be located in one side only
#SideType3LinkingConstr specifies that all type 3 parking lots must be located in only one side of the road
subject to LeftSideConstr: sum {i in Type} QtyLocated[i,1]*Length[i]<=30;
subject to SideType3Constr: sum {j in Side} SideLocatedType3[j]= 1;
subject to SideType3LinkingConstr {j in Side}: QtyLocated[3,j]<= Quantity[3]*SideLocatedType3[j];