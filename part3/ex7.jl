function ci_literka_M(t; T=1)
    t<=T/2 && return 1 - 2*t/T
    t<=T && return 2*t/T - 1
    return 0
end

for x in 0:0.01:1.5
    display(ci_literka_M(x))
end