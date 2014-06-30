import math


type
  Vector* = object
    deltas:seq[float]
    len*:int


proc initVector*(len : int, coords : seq[float]): Vector =
  system.doAssert(len==coords.len)
  system.doAssert(len>=2)
  result.len = len
  result.deltas = coords


proc initZeroVector*(len : int): Vector =
  result.deltas = @[]
  result.len = len
  for i in 1..len:
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
  system.doAssert(A.len == B.len)
  result = initZeroVector(A.len)
  for i in 0..(A.deltas.len-1):
    result.deltas[i] = A.deltas[i] + B.deltas[i]

proc `*`*(A: Vector, s : float): Vector = 
  result = initZeroVector(A.len)
  for i in 0..(A.deltas.len-1):
    result.deltas[i] = A.deltas[i]*s

proc `-`*(A,B : Vector) : Vector =
  system.doAssert(A.len == B.len)
  result = A + (B * -1.0)

proc `*`*(A,B : Vector) : float =
  #dot product
  system.doAssert(A.len == B.len)
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
  system.doAssert(A.len == 3 AND B.len == 3)
  result = initZeroVector(3)
  result.deltas[0] = A.deltas[1]*B.deltas[2] - A.deltas[2]*B.deltas[1]
  result.deltas[1] = A.deltas[2]*B.deltas[0] - A.deltas[0]*B.deltas[2]
  result.deltas[2] = A.deltas[0]*B.deltas[1] - A.deltas[1]*B.deltas[0]

proc `$`*(A,Vector):string =
  result = $A.digits

