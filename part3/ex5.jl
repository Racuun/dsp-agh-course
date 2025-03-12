function ci_rectangular(t; T=1)::Float64
    t<=T && return 1
    return 0
end

for i in 0:0.1:2
    display(ci_rectangular(i; T=1))
end