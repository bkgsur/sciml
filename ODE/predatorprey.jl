using ModelingToolkit, DifferentialEquations, Plots,Latexify
@variables  x(t)  y(t) z(t)
@parameters t α=1.5 β=1.0 γ=3.0 δ=1.0
D = Differential(t)
eqs =[D(x) ~ α * x - β * x * y
        D(y) ~ -γ * y + δ * x * y
        z ~ x + y]
 
@named  sys = ODESystem(eqs,t) 
#print(equations(structural_simplify(sys)))
sol = solve(ODEProblem(structural_simplify(sys),[x=> 1, y=>1,z=>2],(0.0, 10.0)))
# Plot the solution
p1 = plot(sol, title = "Rabbits vs Wolves")
p2 = plot(sol, idxs = z, title = "Total Animals")

plot(p1, p2, layout = (2, 1))