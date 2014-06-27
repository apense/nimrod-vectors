import math


type
  Vector* = object
    deltas:seq[float]
    dim:int


proc initVector*(dim : int, coords : seq[float]): Vector =
  system.doAssert(dim==coords.len)
  result.dim = dim
  result.deltas = coords


proc initZeroVector*(dim : int): Vector =
  result.deltas = @[]
  result.dim = dim
  for i in 1..dim:
    result.deltas.add(0.0)

proc `+`*(A,B : Vector) : Vector =
  system.doAssert(A.dim == B.dim)
  result = initZeroVector(A.dim)
  for i in 0..(A.deltas.len-1):
    result.deltas[i] = A.deltas[i] + B.deltas[i]

proc `*`*(A: Vector, s : float): Vector = 
  result = initZeroVector(A.dim)
  for i in 0..(A.deltas.len-1):
    result.deltas[i] = A.deltas[i]*s

proc `-`*(A,B : Vector) : Vector =
  result = A + (B * -1.0)

proc `*`*(A,B : Vector) : float =
  #dot product
  for i in 0..(A.deltas.len-1):
    result = result + A.deltas[i] * B.deltas[i]

proc `norm`*(A : Vector) : float =
  for i in 0..(A.deltas.len-1):
    result = result + (A.deltas[i] * A.deltas[i])
  result = pow(result, 0.5)


var A : Vector = initVector(3,@[0.5,2.0,1.0])
var B : Vector = initVector(3,@[5.0,3.0,0.0])
echo( norm (A+B) )

