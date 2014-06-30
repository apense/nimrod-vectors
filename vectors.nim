import math


type
  Vector* = object
    deltas:seq[float]
    dim:int


proc initVector*(dim : int, coords : seq[float]): Vector =
  system.doAssert(dim==coords.len)
  system.doAssert(dim>=2)
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


proc `[]`*(A:Vector, i:int):float=
  result = A.deltas[i]

iterator items*(A:Vector): float=
  for i in A.deltas:
    yield i

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

proc angle*(A,B : Vector) : float =
  result = arccos((A*B)/(norm(A)*norm(B)))
  #returns inter-Vector angle in radians

proc cross*(A,B : Vector) : Vector = 
  system.doAssert(A.dim == 3 AND B.dim == 3)
  result = initZeroVector(3)
  result.deltas[0] = A.deltas[1]*B.deltas[2] - A.deltas[2]*B.deltas[1]
  result.deltas[1] = A.deltas[2]*B.deltas[0] - A.deltas[0]*B.deltas[2]
  result.deltas[2] = A.deltas[0]*B.deltas[1] - A.deltas[1]*B.deltas[0]

proc `$`*(A,Vector):string =
  result = $A.digits

var test: Vector = initZeroVector(10)
for i in test:
  echo(i)