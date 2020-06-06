
module Transducers

import Base: map, filter

function map(f::Function)
    function (rf::Function)
        rf′() = rf()
        rf′(ret) = rf(ret)
        rf′(ret, input) = rf(ret, f(input))
        return rf′
    end
end

function filter(pred::Function)
    function (rf::Function)
        rf′() = rf()
        rf′(ret) = rf(ret)
        rf′(ret, input) = pred(input) ? rf(ret, input) : ret
        return rf′
    end
end

function transduce(xform::Function, rf::Function, init, xs)
    rf = xform(rf)
    return reduce(rf, xs; init=init)
end


transduce(xform::Function, rf::Function, xs) = transduce(xform, rf, rf(), xs)

end
