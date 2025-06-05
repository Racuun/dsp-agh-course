
global radix3
const sq3 = sqrt(3);
const om_3_1 = ComplexF64(-0.5, -sq3/2)  # Preobliczone stałe zespolone
const om_3_2 = ComplexF64(-0.5, sq3/2)
@inline function radix3(x::Vector{ComplexF64}, N::Int64)::Vector{ComplexF64}

    result = copy(x);

    digit_reverse_radix3!(result, N);

    # iterate for every step
    step = 3;
    while step <= N
        S_3 = div(step, 3);

        inv_S = 1.0 / step;
        two_pi_inv_S = -2*pi * inv_S;
        #iterate every selection
        for i in 1:step:N
            @inbounds for k::Int64 in 0:(S_3-1)
                k0 = k+i;
                k1 = k0+S_3;
                k2 = k1+S_3;

                angle_k = two_pi_inv_S *k;
                angle_2k = two_pi_inv_S *2k

                om_S_k = ComplexF64(cos(angle_k), sin(angle_k));
                om_S_2k = ComplexF64(cos(angle_2k), sin(angle_2k));

                t1 = result[k1] * om_S_k;
                t2 = result[k2] * om_S_2k;

                X0_val = result[k0];

                t1_om3_1 = t1 * om_3_1;
                t2_om3_2 = t2 * om_3_2;
                t1_om3_2 = t1 * om_3_2;
                t2_om3_1 = t2 * om_3_1;

                result[k0] = X0_val + t1 + t2;
                result[k1] = X0_val + t1_om3_1 + t2_om3_2;
                result[k2] = X0_val + t1_om3_2 + t2_om3_1;
            end
        end
        step *= 3;
    end
    return result;
end

@inline function digit_reverse_radix3!(x::Vector{ComplexF64}, N::Int)
    # Find number of stages (log₃(N))
    stages = 0
    temp_n = N
    while temp_n > 1
        temp_n ÷= 3
        stages += 1
    end
    
    @inbounds for i in 0:(N-1)
        j = reverse_digits_base3(i, stages)
        if i < j
            # Swap elements
            x[i+1], x[j+1] = x[j+1], x[i+1]
        end
    end
end

# Helper function to reverse digits in base 3
@inline function reverse_digits_base3(num::Int, digits::Int)
    result = 0
    for _ in 1:digits
        result = result * 3 + (num % 3)
        num ÷= 3
    end
    return result
end 



######### TESTBENCH ########

using FFTW
function testbench()
    
    println("=== \e[1m\e[96mComprehensive Radix-3 FFT Testing\e[0m ===")
    
    test_cases = [
        ("Random complex", N -> randn(ComplexF64, N)),
        ("Real data", N -> ComplexF64.(randn(N))),
        ("Impulse", N -> [i == 1 ? 1.0+0im : 0.0+0im for i in 1:N]),
        ("Sine wave", N -> ComplexF64.([sin(2π*k/N) for k in 0:N-1]))
    ]
    
    sizes = [27, 81, 243]
    
    for N in sizes
        println("\n\e[1mTesting size N = $N\e[0m")
        println("\e[90m=\e[0m" ^ 40)
        
        for (test_name, data_gen) in test_cases
            println("\n$test_name:")
            
            x = data_gen(N)
            result = radix3(x, N)
            reference = fft(x)
            
            max_error = maximum(abs.(result - reference))
            is_correct = isapprox(result, reference, rtol=1e-10)
            
            println("  Max error: \e[90m$(max_error)\e[0m")
            println("  Status:    $(is_correct ? "\e[1m\e[92m✓ PASS\e[0m" : "\e[1m\e[91m✗ FAIL\e[0m")")
        end
        
        println("\nPerformance test (random data):")
        x_perf = randn(ComplexF64, N)
        print("  Test: \e[90m")
        @time for _ in 1:100; radix3(x_perf, N); end
        print("\e[0m  FFTW: \e[90m")
        @time for _ in 1:100; fft(x_perf); end
        
        println("\e[0m")
    end
end

testbench();