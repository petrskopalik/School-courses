from .index import Index
from .exceptions import InvalidDataError, IndexMismatchError


class IndexedContainer:
    """
    The `IndexedContainer` class allows for storing values with corresponding indices and provides a
    method to retrieve values based on a specified key.
    """

    def __init__(self, values, index=None):
        """
        The `__init__` function initializes an object with a list of values and an optional index, raising errors
        for invalid data or index mismatches.
        
        Args:
          values: The `values` parameter is a list of data values that you want to store or work with in this class.
          index: The `index` parameter is used to specify the index for the
        data structure being initialized. It is an optional parameter that allows you to provide a
        custom index for the values in the data structure. Default value is `None`.

        Raises:
            InvalidDataError: `InvalidDataError` is a custom exception that can be raised for invalid data
            IndexMismatchError: `DuplicateKeyError` is designed to handle errors related to duplicate keys in a list
        """

        if not values:
            raise InvalidDataError()
        
        self.values = values

        if index is None:
            self.index = Index(labels=list(range(len(values))))
        else:
            self.index = index
            if len(self.index.labels) != len(values):
                raise IndexMismatchError
    
    def get(self, key):
        """
        The `get` method retrieves the value associated with a given key from a list of keys and
        values.
        
        Args:
          key: The `key` parameter is the value that you want to search for in the
        `index` list of the object. If there is no match, None is returned.
        
        Returns:
          If the key is found in the index list, the corresponding value will be returned. Otherwise
        None will be returned.
        """
        if key in self.index.labels:
            return self.values[self.index.get_loc(key=key)]

        return None