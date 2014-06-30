# Vectors

This is a minimal library for basic vector math.
Because static[int] does not work in generics yet, dimension matching is checked at run-time.

Vectors can be declared with any number of dimensions : dim >= 2

Vectors are initialized using a number of dimensions and seq[float] describing it's value:

        var myVec : Vector = Vector(2,@[1.0,2.0])

Alternatively, constructors for zero vectors and 2d and 3d vectors are provided

        var myVec : Vector = initVector(2,@[1.0,2.0])
        #Object initialization with sanity checking

        var myVecZeros : Vector = initVector(2)
        #returns a 2d vector with zeros as values

        var myVec2d : Vector = init2dVector(@[1.0,2.0])
        #does not need dimemsion to be provided

        var myVec32 : Vector = init3dVector(@[1.0,2.0,3.0])

The attributes of a Vector can be read and written using `[]` and iterated over naturally
        var A : Vector = initZeroVector(2)
        A[0] = 5.0

        for i in A:
                echo(i)

All basic operations are defined for vector:

        var A,B,C : Vector
        C = A+B #Vector addition

        C = A-B #Vector subtraction

        C = A*0.5 #Vector scaling

        var dotResult: float = A*B #Vector dot product

        var magnitiude : float = norm(A) #Vector magnitude

        C = unit(A) #magnitude 1 unit vector of A

        var theta : float = angle(A,B) #inter-vector angle in radians

        C = cross(A,B) #Cross Product, for 3D ONLY