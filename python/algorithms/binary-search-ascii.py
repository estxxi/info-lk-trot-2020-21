# Funktioniert meistens, good enough

arr = list(range(12))
x = 7

def bisei (value, array, low, high): 
    if low == 0 and high == len(array):
        print("Hi, hast du zufällig " + str(x) + " in " + str(array) + " gesehen? Ich suche ihn.\n")
  
    if high >= low: 

        mid = low + (high - low) // 2

        if arr[mid] == x: 
            print(ascii_list_indicator(array, low, mid, high, 1))
            print("I DONT KNOW HOW BUT THEY FOUND ME")
            return "Index: " + str(mid) 
          
        elif arr[mid] > x: 
            print(ascii_list_indicator(array, low, mid, high))
            return bisei(value, array, low, mid - 1) 
  
        else: 
            print(ascii_list_indicator(array, low, mid, high))
            return bisei(value, array, mid + 1, high) 
  
    else: 

        print("Haha, hast mich nicht gefunden. ")
        return None

# 0 = normal, 1 = found, 2 = breakcase
def ascii_list_indicator(array, low, mid, high, status=0): 
    list_output_string = ""
    for i in array[:(len(array)-1)]:
        list_output_string += str(i) + ",\t"
    list_output_string += str(array[len(array)-1]) + '\n'

    indicator_string = ""
    if low != mid and mid != high and status == 0:
        for i in range(high-1):
            if i == low:
                indicator_string += '|'
            elif i == mid:
                indicator_string += '^'
            indicator_string += '\t'
        indicator_string = indicator_string + '|'
    elif status == 1:
        for i in range(mid):
            indicator_string += '\t'
        indicator_string += '^'
    else:
        for i in array:
            indicator_string += "--\t"
    # else:
    #     print("Unknown case")
    #     return None
    indicator_string += '\n'

    return list_output_string + indicator_string


print (bisei(x, arr, 0, len(arr)))
