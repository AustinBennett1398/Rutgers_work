import sys
states = []; symbols = []; rules = []; anonymous_rules = []; final = []

data = input()
states = data.split()
states.pop(0)
data = input()
symbols = data.split()
symbols.pop(0)

while(data != 'end_rules'):
    data = input()
    if(data != 'begin_rules' and data != 'end_rules'):
        rules.append(data.split())
data = input()
initial_state = (data.split())[1]
data = input()
final = data.split()
final.pop(0)
done = False
while(done == False):
    state = initial_state
    try:
        something = input()
        something = list(something)
        rejected = False
        count = 0
        for i in range(len(something)):
            for x in rules:
                count += 1
                if((state == x[0]) and (something[i] == x[4])):
                    state = x[2]
                    count = 0
                    rejected = False
                    break
                if(count == len(rules)-1):
                    rejected = True
            count = 0
        if((state in final) and (rejected == False)):
            print("accepted")
        else:
            print("rejected")
    except EOFError: 
        done = True
