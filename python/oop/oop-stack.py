"""
Funktioniert noch nicht vollständig, stackimplementierung bis top() ist direkt von Trot,
geht also.
"""

class MyStack:
    def __init__(self):
        self.__myStack = []

    def show(self):
        return self.__myStack

    def isEmpty(self):
        return self.__myStack == []

    def push(self, x):
        self.__myStack = [x] + self.__myStack 

    def pop(self):
        self.__myStack = self.__myStack[1:]

    def top(self):
        return self.__myStack[0]

    # nicht so schön, gibt es eine Möglichkeit, temp direkt als MyStack festzusetzen?
    def stackReverse(self, temp): 
        if self.isEmpty():
            return temp
        else:
            return self.stackReverse(self.pop(), (temp.push(self.top())))

    def stackLen(self, counter=0):
        if self.isEmpty():
            return counter
        else:
            return self.stackLen(self.pop(), counter + 1)

stack = MyStack() # stack ist eine Instanz der Klasse MyStack

# Demonstration der Klasse:
stack.push(42)
stack.push(21)
print("stapel: ", stack.show())
print("top: ", stack.top())
stack.pop()
print("stapel: ", stack.show())
print("leer?: ", stack.isEmpty())
stack.pop()
print("leer?: ", stack.isEmpty())

# Implementiereungsdetails s. haskell > stacksort.hs
def stackSort(xs, fin):
    local_temp = MyStack()
    fin.stackReverse(local_temp)
    out = MyStack()
    temp = MyStack()
    steps = 0

    while fin.len() > 0:
        if xs == []:
            xs = temp
            steps += 1
        elif xs.top() == fin.top():
            out.push(xs.top)
            xs.pop()
            fin.pop()
            steps += 3
        elif xs.top() != fin.top():
            temp.push(xs.top)
            xs.pop()
            steps += 2
    
    return (out, steps)

# Beispiel stacksort
sortMe = MyStack()
getMe = MyStack()

for i in range(20, 0, -1):
    sortMe.push(i)

for i in range(5):
    getMe.push(i)

print("getMe:", getMe.show(), "sortMe:", sortMe.show())

result = stackSort(sortMe, getMe)
print("resulting list:", result[0].show(), "resulting steps:", result[1])



