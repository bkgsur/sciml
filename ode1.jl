using Flux, Statistics,Plots

NN = Chain(x ->[x],
            Dense(1=>32, tanh),
            Dense(32=>1),
            first)

g(t) = t*NN(t) + 1f0

epi = sqrt(eps(Float32))
loss() = mean(abs2(((g(t+epi)-g(t))/epi) - cos(2*pi*t)) for t in 0:1f-2:1f0) 
opt = Flux.Descent(0.01)
data = Iterators.repeated((),5000)
iter =0
cb = function()
    global iter +=1
    if iter%500 ==0
        display(loss())
    end
end
display(loss())

Flux.train!(loss,Flux.params(NN),data,opt; cb=cb)

t = 0:0.001:1.0
plot(t,g.(t), label ="NN")
plot!(t,(1.0 .+ sin.(2*pi*t)/(2*pi)), label ="True Solution")
