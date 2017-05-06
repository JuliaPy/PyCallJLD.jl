# See https://github.com/JuliaIO/JLD.jl/blob/master/doc/jld.md#custom-serialization
module PyCallJLD

using PyCall, JLD

const dumps = PyNULL()
const loads = PyNULL()

function __init__()
    copy!(dumps, pyimport("cPickle")[:dumps])
    copy!(loads, pyimport("cPickle")[:loads])
end

immutable PyObjectSerialization
    repr::Vector{UInt8}
end

function JLD.writeas(pyo::PyObject)
    b = PyCall.PyBuffer(pycall(dumps, PyObject, pyo))
    # I think we need a `copy` here because the PyBuffer might be GC'ed after we've
    # left this scope.
    PyObjectSerialization(copy(unsafe_wrap(Array, Ptr{UInt8}(pointer(b)), sizeof(b))))
end
function JLD.readas(pyo_ser::PyObjectSerialization)
    pycall(loads, PyObject,
           PyObject(PyCall.@pycheckn ccall(@pysym(PyCall.PyString_FromStringAndSize),
                                           PyPtr, (Ptr{UInt8}, Int),
                                           pyo_ser.repr, sizeof(pyo_ser.repr))))
end


end # module
