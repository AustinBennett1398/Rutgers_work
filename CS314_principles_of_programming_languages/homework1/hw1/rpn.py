import sys

ops = {'+': (lambda x,y: x+y), '-': (lambda x,y: x-y), '*': (lambda x,y: x*y), '/': (lambda x,y: x/y), '~': (lambda x: x-2*x)}
opslist = ['+', '-', '*', '/']
stack = []
done = False
while(done == False):
    try:
        stack.append(input())
        if(stack[-1] in opslist and len(stack) > 2):
            try:
                new = ops[stack[-1]](float(stack[-3]),float(stack[-2]))
                stack.pop(-1); stack.pop(-1); stack.pop(-1)
                stack.append(float(new))
                print(stack[-1])
            except ZeroDivisionError:
                print("error: division by zero")
                stack.pop(-1)
        #do +, -, *, /
        elif(stack[-1] == '~' and len(stack) > 1):
            new = ops[stack[-1]](float(stack[-2]))
            stack.pop(-1); stack.pop(-1)
            stack.append(new)
            print(stack[-1])
        else:
            if(stack[-1] in opslist):
                print("invalid operation")
                stack.pop(-1)
                print(stack[-1])
            if(len(stack) > 0):
                print(stack[-1])
    except EOFError:
        done = True
