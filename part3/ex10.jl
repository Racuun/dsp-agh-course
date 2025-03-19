function sawtooth_wave(t; T=1)
    return 2*((T/2)-t%(T/2))/T
end

for x in 0:0.01:1
    display(sawtooth_wave(x))
end