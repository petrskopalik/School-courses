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
        
        self._values = values

        if index is None:
            self._index = Index(labels=list(range(len(values))))
        else:
            self._index = index
            if len(index) != len(values):
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
            return self[key]
        
        return None
    
    def __len__(self):
        """
        This function returns the length of the values stored in the object.
        
        Returns:
          The `__len__` method is returning the length of the `values` attribute of the object to which
        it belongs.
        """

        return len(self.values)
    
    @property
    def values(self):
        """
        The function `values` returns the `_values` attribute of the object.
        
        Returns:
          The `values` method is returning the `_values` attribute of the object `self`.
        """

        return self._values
    
    @property
    def index(self):
        """
        The function `index` returns the value of the `_index` attribute of the object.
        
        Returns:
          The `index` attribute of the object `self` is being returned.
        """

        return self._index
    
    @index.setter
    def index(self, index):
        """
        The function `index` sets the index attribute of an object and raises an error if the length of
        the index does not match the number of values in the object.
        
        Args:
          index: The `index` parameter is class Index
        """
        
        if len(index) != len(self.values):
            raise IndexMismatchError
        
        self._index = index

    def items(self):
        """
        The function `items` returns a zip object containing the index labels and values of a given
        object.
        
        Returns:
          Iterator.
        """

        return zip(self.index, self.values)
    
    def __getitem__(self, key):
        if key not in self.index.labels:
          raise KeyError
        
        return self.values[self.index.get_loc(key=key)]