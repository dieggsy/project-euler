from sympy import Polygon, Point

# Is this cheating? No, this is engineering
def p102():
    with open("../data/p102-triangles.txt") as f:
        num = 0
        for line in f:
            it = map(int,line.split(","))
            if Polygon(*zip(it,it)).encloses_point((0,0)):
                num+=1
        return num
