import sys

class tree_node:
    def __init__(self, key):
        self.left = None
        self.right = None
        self.value = key

def insert(root, node):
    if(root is None):
        root = node
    else:
        if root.value < node.value:
            if root.right is None:
                root.right = node
            else:
                insert(root.right, node)
        else:
            if root.left is None:
                root.left = node
            else:
                insert(root.left, node)

def query(root, key, orig_root, route):
    if(root is None):
        route.append("not found")
        return "terminate"
    elif(orig_root.value == key):
        route.append("found: root")
    elif(root.value == key):
        route.append("found:")
    else:
        if root.value < key:
            if query(root.right, key, orig_root, route) != "terminate":
                route.append("r")
            else:
                return "terminate"
        else:
            if query(root.left, key, orig_root, route) != "terminate":
                route.append("l")
            else:
                return "terminate"
    #for x in route:
     #   print(x)
route = []
done = False
root = tree_node(0)
while(done == False):
    try:
        line = input()
        symbol, num = line.split()
        if(symbol == 'q'):
            query(root, int(num), root, route)
            route.reverse()
            route.insert(0, route.pop(-1))
            for x in route:
                print(x, end=" ")
            print()
            route = []
        elif(symbol == 'i'):
            if(root.value == 0):
                root.value = int(num)
            else:
                insert(root, tree_node(int(num)))
    except EOFError:
        done = True
