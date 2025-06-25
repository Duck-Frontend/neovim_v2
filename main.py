from random import randint


def print_random_number() -> int:
    return randint(1, 10000)


if __name__ == "__main__":
    print(print_random_number())
