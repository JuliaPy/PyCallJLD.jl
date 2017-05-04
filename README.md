# PyCallJLD

[![Build Status](https://travis-ci.org/cstjean/PyCallJLD.jl.svg?branch=master)](https://travis-ci.org/cstjean/PyCallJLD.jl)

[![Coverage Status](https://coveralls.io/repos/cstjean/PyCallJLD.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/cstjean/PyCallJLD.jl?branch=master)

[![codecov.io](http://codecov.io/github/cstjean/PyCallJLD.jl/coverage.svg?branch=master)](http://codecov.io/github/cstjean/PyCallJLD.jl?branch=master)

PyCallJLD enables saving and loading [PyCall's `PyObject`s](https://github.com/JuliaPy/PyCall.jl) using [JLD.jl](https://github.com/JuliaIO/JLD.jl/). Example:

```julia
using PyCall, JLD, PyCallJLD

@pyimport sklearn.linear_model as lm

m1 = lm.LinearRegression()
m2 = lm.ARDRegression()
models = [m1, m2];

# Save Python objects
JLD.save("models.jld", "mods", [m1, m2])

# Load Python objects
JLD.load("models.jld", "mods")
```

See [PyCall](https://github.com/JuliaPy/PyCall.jl)'s and
[JLD](https://github.com/JuliaIO/JLD.jl/)'s documentation for details.