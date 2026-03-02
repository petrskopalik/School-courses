from .vector import dot_product

def matrix(shape: tuple, fill = None) -> list[list]:
    """Creates a matrix

    Args:
        shape (tuple): (row, column) X (height, wide)
        fill (_type_, optional): Choose a fill element. Defaults to None (empty matrix).

    Returns:
        list[list]: new matrix
    """
    matrix = []

    for row in range(shape[0]):
        matrix.append([])
        for column in range(shape[1]):
            if fill is not None:
                matrix[row].append(fill)

    return matrix


def matrix_multiplication(matrix_1: list[list[int]], matrix_2: list[list[int]]) -> list[list[int]]:
    """Creates a new matrix as a result of matrix multiplications operation

    Args:
        matrix_1 (list[list[int]]): first matrix
        matrix_2 (list[list[int]]): second matrix

    Returns:
        list[list[int]]: new matrix
    """
    if len(matrix_1[0]) >= (len(matrix_2[0])):
        wide_matrix = matrix_2
        tall_matrix = matrix_1
        wide = len(wide_matrix[0])
    else:
        wide_matrix = matrix_1
        tall_matrix = matrix_2
        wide = len(wide_matrix[0])

    new_matrix = matrix((len(tall_matrix), wide))

    for index, row_m1 in enumerate(tall_matrix):
        for i in range(wide):
            col_m2 = []
            for row_m2 in wide_matrix:
                col_m2.append(row_m2[i])
            new_matrix[index].append(dot_product(row_m1, col_m2))

    return new_matrix


def submatrix(matrix: list[list[int]], drop_rows: list[int] = [], drop_columns: list[int] = []) -> list[list[int]]:
    """Create a submatrix, excluding drop_rows and drop_columns from matrix.
    If rows and columns to drop are not provided, then a copy of matrix is returned.

    Args:
        matrix (list[list[int]]): matrix
        drop_rows (list[int]): list of indexes to drop
        drop_columns (list[int]): list of indexes to drop

    Returns:
        list[list[int]]: new matrix
    """
    new_matrix = []

    if len(matrix) == 0:
        return new_matrix

    if drop_rows == [] and drop_columns == []:
        for index, row in enumerate(matrix):
            new_matrix.append([])
            for num in row:
                new_matrix[index].append(num)
        return new_matrix

    if len(matrix[0]) == len(drop_columns):
        return new_matrix

    row_index = 0

    for index_row, row in enumerate(matrix):
        if index_row in drop_rows:
            continue
        new_matrix.append([])
        for column_index, number in enumerate(row):
            if column_index in drop_columns:
                continue
            new_matrix[row_index].append(number)
        row_index += 1

    return new_matrix