def dot_product(vector_1: list[int], vector_2: list[int]) -> int:
    """Function for calculating the scalar product

    Args:
        vector_1 (list[int]): scalar
        vector_2 (list[int]): scalar

    Returns:
        int: result
    """
    result = 0
    for u, v in zip(vector_1, vector_2):
        result += u*v

    return result