function ramp_wave(t; T=1)

    return 2*(t%(T/2))/T

end

for x in 0:0.01:1
    display(ramp_wave(x))
end