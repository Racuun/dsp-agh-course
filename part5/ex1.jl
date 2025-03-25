function quantize(L)
    return function fl(x::Real)::Real
    
        min_index=1;
        l_distance=Inf;

        for i in eachindex(L)
            d = (x-L[i])^2;
            if d < l_distance
                l_distance = d;
                min_index = i;
            end
        end
        
        return L[min_index];
    end
end



function signal(s)
    sig(t) = 2*sin(2*pi*t + pi/4)

    samplesPerSecond=1000
    dt=1/samplesPerSecond

    samples = zeros(s)

    for i in eachindex(samples)
        samples[i] = sig(0.25 + dt*(i-1))
    end
    return samples
end


sign = signal(1000);
L = LinRange(-2, 2, 256);

fl = quantize(L)

qsin = fl.(sign)

using GLMakie
GLMakie.activate!()
fig = Figure(size=(1200,600))

axs = Axis(fig[1,1], xlabel="Sample", ylabel="Y");
lines!(axs,  qsin);
lines!(axs,  sign)

fig