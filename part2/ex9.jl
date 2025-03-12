function Kconvergance(p)
    z = 0 + im * 0.0
    k = 1
    while k < 200 ## stop infinite loop
        z = z*z + p
        abs(z) < 2 || break
        k += 1
    end

    return k
end


using GLMakie
GLMakie.activate!()

fig = Figure(;size = (800, 600))
res = LinRange(-1, 2, 2000)
ims = LinRange(-1, 1, 1000)

Mk = [Kconvergance(r + im * i) for r in res, i in ims]

axs = Axis3(fig[1,1], xlabel="Realis", ylabel="Imaginaris", zlabel="K");
surface!(axs, res, ims, Mk, colormap=:viridis)
display(fig)
wait(fig.scene) ## stop graph from closing