print("** RPN session started **")
results = {}
operators = ["+", "-", "*", "/", "//"]

while True:
    expr = input("Write RPN expression: ")
    if expr in results:
        print(f"Cached: {results[expr]}")
        continue

    expresions = expr.split(" ")
    if expresions == ['']:
        break
    numbers = []

    for item in expresions:
        if item in operators:
            num2 = numbers.pop()
            num1 = numbers.pop()
            if item == "+":
                res = num1 + num2
            elif item == "-":
                res = num1 - num2
            elif item == "*":
                res = num1 * num2
            elif item == "/":
                res = num1 / num2
            else:
                res = num1 // num2
            numbers.append(res)
        else:
            if item.find(".") != -1:
                numbers.append(float(item))
            else:
                numbers.append(int(item))

    result = numbers.pop()
    print(f"Result: {result}")
    results[expr] = result

print("** RPN session ended **")