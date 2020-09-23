# Set macht Probleme

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

class MyQueue:
    def __init__(self):
        self.__myQueue = []

    def show(self):
        return self.__myQueue

    def isEmpty(self):
        return self.__myQueue == []

    def enqueue(self, x):
        self.__myQueue = self.__myQueue + [x]

    def dequeue(self):
        self.__myQueue = self.__myQueue[1:]

    def head(self):
        return self.__myQueue[0]

class MySet:
    def __init__(self):
        self.__mySet = []

    def show(self):
        return self.__mySet

    def isEmpty(self):
        return self.__mySet == []

    def isEl(self, x):
        return x in self.__mySet

    def insert(self, x):
        if not(self.isEl(x)):
            self.__mySet = self.__mySet.append(x)
        # return self

    def remove(self, x):
        self.__mySet = self.__mySet.pop(x)
        # return self

stack = MyStack()
queue = MyQueue()
cool_set = MySet()