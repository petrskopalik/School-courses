class InvalidDataError(Exception):
    """The `InvalidDataError` class is a custom exception in Python that can be raised for invalid data."""

    pass


class IndexMismatchError(Exception):
    """
    The `IndexMismatchError` class is a custom exception that can be raised when
    there is a mismatch in index positions.
    """

    pass


class DuplicateKeyError(Exception):
    """
    The class `DuplicateKeyError` is designed to handle errors related to duplicate keys in a list.
    """

    def __init__(self, list):
        """This function initializes a class instance with a list and identifies duplicates within the list.
        
        Args:
          list: List of items.
        """

        once = []
        self.duplicates = []

        for item in list:
            if item in once:
                self.duplicates.append(item)
            else:
                once.append(item)