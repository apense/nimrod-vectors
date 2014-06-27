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

proc init2dVector(coords : seq[float]): Vector =
  result = initVector(2,coords)

proc init3dVector(coords : seq[float]): Vector =
  result = initVector(3,coords)


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
  system.doAssert(A.dim == B.dim)
  result = A + (B * -1.0)

proc `*`*(A,B : Vector) : float =
  #dot product
  system.doAssert(A.dim == B.dim)
  for i in 0..(A.deltas.len-1):
    result = result + A.deltas[i] * B.deltas[i]

proc norm*(A : Vector) : float =
  for i in 0..(A.deltas.len-1):
    result = result + (A.deltas[i] * A.deltas[i])
  result = pow(result, 0.5)

proc unit*(A : Vector) : Vector =
  result = A * norm(A)

proc angle(A,B : Vector) : float =
  result = arccos((A*B)/(norm(A)*norm(B)))
  #returns inter-Vector angle in radians

#todo
#cross product for 3d
# optional : genralized cross product
# unit-vector from angles


