using ModelingToolkit, DifferentialEquations, Plots
@variables x(t) 
@parameters t p = 0.005
D = Differential(t)
eqn = [D(x) ~ p*x
       ] 
@named sys = ODESystem(eqn,t)
sol = solve(ODEProblem(structural_simplify(sys),[x=>1.00, r=>1.00],(0.0,10.0)))

p1 = plot(sol, title = "Total amount")
plot(p1,layout = (1, 1))