import time
import functools


def delay(seconds=1):
    """Delay decorator

    Args:
        seconds (int, optional): Time delay. Defaults to 1.
    """
    def decor(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            time.sleep(seconds)
            return func(*args, **kwargs)
        return wrapper
    return decor

def call_info(func):
    """Call info decorator"""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        ar = []
        for a in args:
            ar.append(repr(a))
        kw = []
        for k in kwargs:
            kw.append(f"{k}={repr(kwargs[k])}")
        all = ", ".join(ar + kw)
        print(f"Calling: {func.__name__}({all})")
        res = func(*args, **kwargs)
        print(f"Result: {repr(res)}")
        return res
    return wrapper

def catch(*exceptions, error_value=None):
    """Catch decorator

    Args:
        error_value (optional): Value for return. Defaults to None.
    """
    if not exceptions:
        exceptions = (Exception,)
    def decor(func):
        error_count = 0
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            nonlocal error_count
            try:
                return func(*args, **kwargs)
            except exceptions:
                error_count += 1
                print(f"Number of errors that occured in {func.__name__}: {error_count}")
                return error_value
        return wrapper
    return decor