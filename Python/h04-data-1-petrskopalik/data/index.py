from .exceptions import InvalidDataError, DuplicateKeyError


class Index():
    """
    The `Index` class in creates an index object with unique labels and
    provides a method to retrieve the location of a key.
    """
    
    def __init__(self, labels, name=""):
        """
        The function initializes an object with a list of unique labels and an optional name parameter.
        
        Args:
          labels: The `labels` parameter is expected to be a list of unique labels.
        If the `labels` list is empty, an `InvalidDataError` is raised. If there are duplicate labels in the
        list, a `DuplicateKeyError` is raised
          name: The `name` parameter is a string that represents the name of an
        object or entity. Default value is ""

        Raises:
            InvalidDataError: `InvalidDataError` is a custom exception that can be raised for invalid data
            DuplicateKeyError: `DuplicateKeyError` is designed to handle errors related to duplicate labels in a list
        """

        if not labels:
            raise InvalidDataError()
        
        if len(labels) != len(set(labels)):
            raise DuplicateKeyError(labels)
        
        self.labels = labels
        self.name = name

    def get_loc(self, key):
        """
        The function `get_loc` returns the index of a given key in the `labels` list of the object.
        
        Args:
          key: The `key` parameter is the value that you want to find the
        location of within the `self.labels` list. The method checks if the `key` is present in the
        `self.labels` list and returns the index of the `key`
        
        Raises:
            KeyError: KeyError exeption

        Returns:
          The index of the key in the `self.labels` list is being returned.
        """

        if key not in self.labels:
            raise KeyError()
        
        return self.labels.index(key)