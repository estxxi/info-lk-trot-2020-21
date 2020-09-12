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
