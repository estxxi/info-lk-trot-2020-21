import random

class Maze:
    def __init__(self, num_of_rooms, doors, mouse_num, food_num):
        # as a graph, rooms are vertices, doors are edges
        self.num_of_rooms = num_of_rooms # number, 0 through n
        self.doors = doors # list of tuples
        self.mouse_num = mouse_num # room number
        self.food_num = food_num # room_number
        self.movements = 0
        self.food_found = False

    def get_info(self):
        return self.num_of_rooms, self.doors, self.mouse_num, self.food_num

    def doors_of_room(self, room_num):
        out = []
        for door in self.doors:
            if room_num in door:
                out.append(door)
        return out

    def adj_rooms(self, room_num):
        adj_doors = self.doors_of_room(room_num)
        out = []

        for door in adj_doors:
            if door[0] == room_num:
                out.append(door[1])
            elif door[1] == room_num:
                out.append(door[0])
        return out

    def add_room(self, new_doors):
        self.num_of_rooms += 1
        self.doors += new_doors

    def move_mouse(self):
        goal_room = random.choice(self.adj_rooms(self.mouse_num))
        print("Mouse movement:", self.mouse_num, "->", goal_room)

        self.mouse_num = goal_room
        self.movements += 1

        if self.mouse_food_check():
            print("The mouse reached the food after", self.movements, "moves. ")

    def mouse_food_check(self):
        if self.mouse_num == self.food_num:
            self.food_found = True
        return self.mouse_num == self.food_num

maze = Maze(5, [(0,1), (0,2), (1,3), (2,3), (3,4)], 0, 4)

while not(maze.food_found):
    maze.move_mouse()
