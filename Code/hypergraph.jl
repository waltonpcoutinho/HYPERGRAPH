#!/usr/bin/env julia
###
# doc
# http://opensourc.es/blog/mip-tsp
###
print("julia version ", VERSION, "\n\n")

#Include libraries
using JuMP
using CPLEX

#Include user defined libraries
include("Data.jl")

#check input
if size(ARGS) != (1,)
   println("Calling sequence: julia hypergraph.jl [path_to_instance]");
   println("Exiting...");
   exit(0);
end
println("Path to instance: ", ARGS[1])
path = ARGS[1]

#parse data
V1, V2, TRUE, MATCH = parseData(path)

#sizes of each set
n1 = length(V1)
n2 = length(V2)

#compute score matrices
B, lookUp = buildMatrices(V1,V2)

#create model with CPLEX solver
model = Model(solver=CplexSolver())

#declare variables
@variable(model, x[1:n1,1:n2], Bin)
@variable(model, 0 <= z[1:length(B)] <= 1)

#objective: maximize score
@objective(model, Max, dot(1000000*B, z)) ### BODGE ALERT!!! ###

#assignment constraints
for i = 1:n1
   @constraint(model, sum(x[i,j] for j=1:n2) == 1)
end

#linking constraints
for i = 1:length(B)
   @constraint(model, z[i] <=  x[lookUp[i][2],lookUp[i][5]])
   @constraint(model, z[i] <=  x[lookUp[i][3],lookUp[i][6]])
   @constraint(model, z[i] <=  x[lookUp[i][4],lookUp[i][7]])
end

#display model for debugging
print(model)

#solve problem
status = solve(model)

#print final log
println("Matching score: ", getobjectivevalue(model), "\n")
println("Solution is: ")
for i = 1: n1
  for j = 1: n2
    print("x[$i,$j] = ", getvalue(x[i,j]), "\n")
  end
end

#print endline
print("\n")




