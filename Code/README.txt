###############################################################################################################################################
################ Installing CPLEX on Julia
################ source https://github.com/JuliaOpt/CPLEX.jl
###############################################################################################################################################

If you're on Linux

The most common problem is not setting CPLEX_STUDIO_BINARIES correctly. Open a Julia prompt and check that the output of

julia> ENV["CPLEX_STUDIO_BINARIES"]

is the path to the CPLEX installation. If you get a key "CPLEX_STUDIO_BINARIES" not found error, make sure the environment variable is set correctly, or just set it from within the Julia prompt

julia> ENV["CPLEX_STUDIO_BINARIES"] = "path/to/cplex/installation"
julia> Pkg.build("CPLEX")

###############################################################################################################################################
################ CREATING A VIRTUAL ENV. FOR RUNNING A DOWNGRADED VERSION OF JuMP (0.18.5)
################ WHICH SUPPORTS CPLEX CALLBACKS
###############################################################################################################################################


walton@walton-ufcg:~/Desktop/testeJulia$ julia --project
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.1.1 (2019-05-16)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> using Pkg

julia> Pkg.installed()
Dict{String,Union{Nothing, VersionNumber}} with 6 entries:
  "Graphs" => v"0.10.3"
  "GLPK"   => v"0.10.0"
  "Clp"    => v"0.6.2"
  "Gurobi" => v"0.6.0"
  "CPLEX"  => v"0.5.0"
  "JuMP"   => v"0.19.2"

###############################################################################################################################################
################ Type "]" for entering Pkg's REPL (prompt)
################ Type "backspace" for leaving it
###############################################################################################################################################

(v1.1) pkg> activate .

(testeJulia) pkg> add CPLEX@0.5.0
  Updating registry at `~/.julia/registries/General`
  Updating git-repo `https://github.com/JuliaRegistries/General.git`
 Resolving package versions...
  Updating `~/Desktop/testeJulia/Project.toml`
  [a076750e] + CPLEX v0.5.0
  Updating `~/Desktop/testeJulia/Manifest.toml`
  [a076750e] + CPLEX v0.5.0
  [34da2185] + Compat v2.2.0
  [f8899e07] + LinQuadOptInterface v0.6.0
  [b8f27783] + MathOptInterface v0.8.4
  [fdba3010] + MathProgBase v0.7.7
  [2a0f44e3] + Base64 
  [ade2ca70] + Dates 
  [8bb1440f] + DelimitedFiles 
  [8ba89e20] + Distributed 
  [b77e0a4c] + InteractiveUtils 
  [76f85450] + LibGit2 
  [8f399da3] + Libdl 
  [37e2e46d] + LinearAlgebra 
  [56ddb016] + Logging 
  [d6f4376e] + Markdown 
  [a63ad114] + Mmap 
  [44cfe95a] + Pkg 
  [de0858da] + Printf 
  [3fa0cd96] + REPL 
  [9a3f8284] + Random 
  [ea8e919c] + SHA 
  [9e88b42a] + Serialization 
  [1a1011a3] + SharedArrays 
  [6462fe0b] + Sockets 
  [2f01184e] + SparseArrays 
  [10745b16] + Statistics 
  [8dfed614] + Test 
  [cf7118a7] + UUIDs 
  [4ec0a83e] + Unicode 

julia> Pkg.installed()
Dict{String,Union{Nothing, VersionNumber}} with 1 entry:
  "CPLEX" => v"0.5.0"

(testeJulia) pkg> add JuMP@0.18.5
 Resolving package versions...
 Installed StaticArrays ─ v0.11.1
  Updating `~/Desktop/testeJulia/Project.toml`
  [4076af6c] + JuMP v0.18.5
  Updating `~/Desktop/testeJulia/Manifest.toml`
  [9e28174c] + BinDeps v0.8.10
  [b99e7846] + BinaryProvider v0.5.6
  [49dc2e85] + Calculus v0.5.0
  [bbf7d656] + CommonSubexpressions v0.2.0
  [864edb3b] + DataStructures v0.17.2
  [163ba53b] + DiffResults v0.0.4
  [b552c78f] + DiffRules v0.0.10
  [f6369f11] + ForwardDiff v0.10.3
  [4076af6c] + JuMP v0.18.5
  [77ba4419] + NaNMath v0.3.2
  [bac558e1] + OrderedCollections v1.1.0
  [89212889] + ReverseDiffSparse v0.8.6
  [276daf66] + SpecialFunctions v0.8.0
  [90137ffa] + StaticArrays v0.11.1
  [30578b45] + URIParser v0.4.0

julia> Pkg.installed()
Dict{String,Union{Nothing, VersionNumber}} with 2 entries:
  "CPLEX" => v"0.5.0"
  "JuMP"  => v"0.18.5"

###############################################################################################################################################
################ EXEMPLO DO CPLEX.JL USANDO JuMP 0.18.5
###############################################################################################################################################


julia> include("tsp.jl")
CPXPARAM_Preprocessing_Reduce                    1
CPXPARAM_Preprocessing_Linear                    0
CPXPARAM_MIP_Display                             1
CPXPARAM_MIP_Strategy_CallbackReducedLP          0
CPXPARAM_MIP_Interval                            1
Warning: Control callbacks may disable some MIP features.
Tried aggregator 2 times.
MIP Presolve eliminated 12 rows and 6 columns.
Aggregator did 15 substitutions.
Reduced MIP has 6 rows, 15 columns, and 30 nonzeros.
Reduced MIP has 15 binaries, 0 generals, 0 SOSs, and 0 indicators.
Presolve time = 0.00 sec. (0.04 ticks)
Probing time = 0.00 sec. (0.00 ticks)
MIP emphasis: balance optimality and feasibility.
MIP search method: traditional branch-and-cut.
Parallel mode: none, using 1 thread.
In subtour
Done exploring
x[1,4] + x[1,5] + x[1,6] + x[2,4] + x[2,5] + x[2,6] + x[3,4] + x[3,5] + x[3,6]

In subtour
Done exploring
found tour!

Node log . . .
Best integer =   1.247214e+03  Node =       0  Best node =   8.472136e+02

User cuts applied:  1
[0.0 1.0 1.0 -0.0 0.0 -0.0; 1.0 0.0 -0.0 1.0 -0.0 -0.0; 1.0 -0.0 0.0 -0.0 1.0 -0.0; -0.0 1.0 -0.0 0.0 0.0 1.0; 0.0 -0.0 1.0 0.0 0.0 1.0; -0.0 -0.0 -0.0 1.0 1.0 0.0]
Optimal
1247.2135954999578



###############################################################################################################################################
################ CODIGO USANDO JuMP 0.19.2
###############################################################################################################################################

julia> include("tsp11102019.jl")
[ Info: Recompiling stale cache file /home/walton/.julia/compiled/v1.1/JuMP/DmXqY.ji for JuMP [4076af6c-e467-56ae-b986-b466b2749572]
ERROR: LoadError: UndefVarError: MathOptInterface not defined
Stacktrace:
 [1] getproperty(::Module, ::Symbol) at ./sysimg.jl:13
 [2] top-level scope at none:0
 [3] include at ./boot.jl:326 [inlined]
 [4] include_relative(::Module, ::String) at ./loading.jl:1038
 [5] include(::Module, ::String) at ./sysimg.jl:29
 [6] include(::String) at ./client.jl:403
 [7] top-level scope at none:0
in expression starting at /home/walton/Desktop/testeJulia/tsp11102019.jl:4

julia> 






