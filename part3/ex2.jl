Z(t)::Complex = 0.25 * exp(im * 2*pi*(pi/2)*t + pi)

samplesPerSecond = 2048
sampling = 1/samplesPerSecond

start = 5.0
stop = 10.0

values::Vector{Complex} = zeros(0)

for t in start:sampling:stop
    append!(values, Z(t))
end

display(values)