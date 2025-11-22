from random import randint
def main(*args, **kwargs):
    print(args[randint(0, len(args))])
    print(kwargs[randint(0, len(kwargs))])
