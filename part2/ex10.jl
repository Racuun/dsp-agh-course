function checkSum(sum, digits::Vector)
    str = string(sum);

    for i in eachindex(str)
        if Int(str[i]) != digits[i]
            return false;
        end
    end
    return true;
end

function sumPower5Digits(digits::Vector)
    sum = 0
    for i in eachindex(digits)
        sum += digits[i]^5
    end
    return sum
end

function incrementDigits(digits::Vector)
    for i in reverse(eachindex(digits))
        if digits[i] < 9 
            digits[i] += 1
            return digits
        end

        digits[i] = 0
    end
    return digits
end

function checkTreshold(digits::Vector)
    for d in digits
        d != 9 && return true
    end
    return false
end

for n in 2:7
    digits = zeros(n)
    digits[1] = 1
    while checkTreshold(digits)
        sum = sumPower5Digits(digits)
        is = checkSum(sum, digits)
        if is display(digits, sum); end

        digits = incrementDigits(digits)
    end
    n += 1
end