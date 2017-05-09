using PyCallJLD
using Base.Test
using PyCall, JLD

const deque = pyimport("collections")["deque"]

obj = [deque([1,2,3]), deque([4,5,6])]
save("temp.jld", "x", obj)
@test load("temp.jld", "x") == obj

save("temp.jld", "x", PyObject("fé"))
@test load("temp.jld", "x") == PyObject("fé")

obj = PyObject(rand(UInt8, 1000))
save("temp.jld", "x", obj)
@test load("temp.jld", "x") == obj
