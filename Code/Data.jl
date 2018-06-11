#!/usr/bin/env julia
###
# doc
# http://opensourc.es/blog/mip-tsp
###

function parseData(path)

   #open instance file
   file = open(path)

   #read instance size
   instSize = parse(Int64,split(readline(file),"=")[2])
   print("Inst size: ", instSize, "\n")

   #declare sets of vertices
   V1 = [Vector{Float64}(2) for i in 1:instSize]
   V2 = [Vector{Float64}(2) for i in 1:instSize]
   TRUE = [Vector{Float64}(2) for i in 1:instSize]
   MATCH = [Vector{Float64}(2) for i in 1:instSize]

   #read V1 coordinates
   for i = 1:instSize
      idx, x, y = split(readline(file))
      V1[i] = [parse(Float64,x), parse(Float64,y)]
   end

   #read V2 coordinates
   readline(file) #skip one line
   for i = 1:instSize
      idx, x, y = split(readline(file))
      V2[i] = [parse(Float64,x), parse(Float64,y)]
   end

   #read True coordinates
   readline(file) #skip one line
   for i = 1:instSize
      idx, x, y = split(readline(file))
      TRUE[i] = [parse(Float64,x), parse(Float64,y)]
   end

   #read solution
   readline(file) #skip one line
   for i = 1:instSize
      v1, v2 = split(readline(file))
      MATCH[i] = [parse(Int64,v1), parse(Int64,v2)]
   end

   #close file
   close(file)

   #return data
   return V1, V2, TRUE, MATCH
end

function buildMatrices(V1,V2)

   #number of vertices in each vertex set
   n1 = length(V1)
   n2 = length(V2)
   B = []
   lookUp = []

   total = 0
   counter = 0

   numElements = ((n1*(n1 - 1)*(n1 - 2))/6)*((n2*(n2 - 1)*(n2 - 2))/6)

   #for n1=n2=n the innermost loop is 
   #executed ((n(n-1)(n-2))/6)^2 times
   for i1 = 1:n1
      for j1 = i1+1:n1
         for k1 = j1+1:n1
            for i2 = 1:n2
               for j2 = i2+1:n2
                  for k2 = j2+1:n2
                     dist1 = norm2_2D(V1[i1],V2[i2])
                     dist2 = norm2_2D(V1[j1],V2[j2])
                     dist3 = norm2_2D(V1[k1],V2[k2])
                     f = dist1 + dist2 + dist3
                     push!(B,f)
                     total = total + f 
                     counter = counter + 1
                     push!(lookUp,[counter,i1,j1,k1,i2,j2,k2])
                  end
               end
            end
         end
      end
   end

   gamma = total/numElements

   #compute B_i1i2j1j2k1k2 as B = exp(-gamma*||fi1j1k1 - fi2j2k2||)
   B = exp.(-gamma*B)

   #return score matrix and look up table of indices
   return B, lookUp
end

function norm2_2D(v1,v2)
   return sqrt((v1[1]-v2[1])*(v1[1]-v2[1]) + (v1[2]-v2[2])*(v1[2]-v2[2]))
end















