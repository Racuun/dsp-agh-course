function ci_rectangular(t; T=1)::Float64
    t>0 && return (t÷T)%2
    return 0
end

for i in 0:0.1:2
    display(ci_rectangular(i; T=2))
end