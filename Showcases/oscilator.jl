function oscilationStep(x, v, k; mass=1, damp=1.0, dt=0.01)
    a = (-damp*v-k*x)/mass
    x += v*dt + a*dt*dt/2
    v = v + a*dt
    return x, v, a
end

time = 20
step = 0.05
t = 0:step:time

len = Int(time / step)

xs = [1.0]
vs = [0.0]

for i in 1:len
    x, v, a = oscilationStep(xs[i], vs[i], 1; damp=0.3, dt=step)
    append!(xs, x);
    append!(vs, v);
end

using CairoMakie
CairoMakie.activate!()
fig = Figure(size=(1200,600))

axs = Axis(fig[1,1], xlabel="Time", ylabel="X");
scatter!(axs, t, xs);
axs2 = Axis(fig[1,2], xlabel="Time", ylabel="Velocity");
scatter!(axs2, t, vs);

display(fig)