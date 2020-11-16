import sys

def mat_mult(mat_1, mat_2):
    result = [[0 for n in range(len(mat_2[0]))] for n2 in range(len(mat_1))]
    for i in range(len(mat_2)):
        for j in range(len(mat_1)):
            for k in range(len(mat_2[0])):
                result[j][k] += mat_1[j][i] * mat_2[i][k]
    for i in range(len(result)):
        for j in range(len(result[0])):
            print(result[i][j], end=" ")
        print()
    

mat_1 = []
mat_2 = []

mat_1_size = input()
row_1, col_1 = mat_1_size.split()
for x in range(int(row_1)):
    mat_1.append(([input()]))

mat_1 = [n.split() for row in mat_1 for n in row]
mat_1 = [[float(n) for n in row] for row in mat_1]

mat_2_size = input()
row_2, col_2 = mat_2_size.split()
for x in range(int(row_2)):
    mat_2.append(([input()]))

mat_2 = [n.split() for row in mat_2 for n in row]
mat_2 = [[float(n) for n in row] for row in mat_2]

if col_1 != row_2:
    print("invalid input")
else:
    mat_mult(mat_1, mat_2)
