sig(t) = 2*sin(2*pi*t + pi/4)

samplesPerSecond=1000
dt=1/samplesPerSecond

samples = zeros(256)

for i in eachindex(samples)
    samples[i] = sig(0.25 + dt*(i-1))
end

display(samples)