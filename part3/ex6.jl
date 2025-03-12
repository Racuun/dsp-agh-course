function ci_traingle(t; T=1)
    t<=T/2 && return t/(T/2)
    t<=T && return 2 - t/(T/2)
    return 0
end

for i in 0:0.1:1.5
    display(ci_traingle(i))
end