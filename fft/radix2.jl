@inline function radix2(x::Vector{ComplexF64}, N::Int64)::Vector{ComplexF64}
    
    result = copy(x);

    digit_reverse_radix2!(result, N);

    step = 2;
    while step <= N
        S_2 = div(step, 2);

        inv_S = 1.0 / step;
        two_pi_inv_S = -2*pi * inv_S;
        #iterate every selection
        for i in 1:step:N
            @inbounds for k::Int64 in 0:(S_2-1)
                k0 = k+i;
                k1 = k0+S_2;

                p = result[k0]
                q = exp(two_pi_inv_S*im*k) * result[k1]
                result[k0] = p + q;
                result[k1] = p - q;
            end
        end
        step *= 2;
    end

    return result;
    
end

@inline function digit_reverse_radix2!(x::Vector{ComplexF64}, N::Int)
    # Find number of stages (log₃(N))
    stages = 0
    temp_n = N
    while temp_n > 1
        temp_n ÷= 2
        stages += 1
    end
    
    @inbounds for i in 0:(N-1)
        j = reverse_digits_base2(i, stages)
        if i < j
            # Swap elements
            x[i+1], x[j+1] = x[j+1], x[i+1]
        end
    end
end

# Helper function to reverse digits in base 3
@inline function reverse_digits_base2(num::Int, digits::Int)
    result = 0
    for _ in 1:digits
        result = result * 2 + (num % 2)
        num ÷= 2
    end
    return result
end 



######### TESTBENCH ########

using FFTW
function testbench()
    
    println("=== \e[1m\e[96mComprehensive Radix-2 FFT Testing\e[0m ===")
    
    test_cases = [
        ("Random complex", N -> randn(ComplexF64, N)),
        ("Real data", N -> ComplexF64.(randn(N))),
        ("Impulse", N -> [i == 1 ? 1.0+0im : 0.0+0im for i in 1:N]),
        ("Sine wave", N -> ComplexF64.([sin(2π*k/N) for k in 0:N-1]))
    ]
    
    sizes = [64, 128, 256]
    
    for N in sizes
        println("\n\e[1mTesting size N = $N\e[0m")
        println("\e[90m=\e[0m" ^ 40)
        
        for (test_name, data_gen) in test_cases
            println("\n$test_name:")
            
            x = data_gen(N)
            result = radix2(x, N)
            reference = fft(x)
            
            max_error = maximum(abs.(result - reference))
            is_correct = isapprox(result, reference, rtol=1e-10)
            
            println("  Max error: \e[90m$(max_error)\e[0m")
            println("  Status:    $(is_correct ? "\e[1m\e[92m✓ PASS\e[0m" : "\e[1m\e[91m✗ FAIL\e[0m")")
        end
        
        println("\nPerformance test (random data):")
        x_perf = randn(ComplexF64, N)
        print("  Test: \e[90m")
        @time for _ in 1:100; radix2(x_perf, N); end
        print("\e[0m  FFTW: \e[90m")
        @time for _ in 1:100; fft(x_perf); end
        
        println("\e[0m")
    end
end

testbench();