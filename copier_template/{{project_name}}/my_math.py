"""Basic math operations."""


def add(x, y) -> float:
    """Add two numbers.

    Args:
        x (int): first number.
        y (int): second number.

    Returns:
        float: sum of x and y.

    Example:
        >>> add(1, 2)
        4
    """
    result = x + y
    return result


def subtract(x, y) -> float:
    """Subtract two numbers.

    Args:
        x: first number.

    Returns:
        float: difference of x and y.

    Example:
        >>> subtract(1, 2)
        -1
    """
    result = x - y
    return result


def print_numbers(x: int):
    """Prints the number x"""
    print(f"I am a double quoted number: {x=}")
    return None


def print_numbers2(x: int):
    """Prints the number x"""
    print(f"I am a double quoted number: {x=}")
    return None
