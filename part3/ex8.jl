function ci_literka_U(t;T=1)
    t <= T && return (t-T/2)^4
    return 0
end

for x in 0:0.01:1.1
    display(ci_literka_U(x))
end