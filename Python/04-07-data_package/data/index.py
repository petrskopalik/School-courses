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
        
        self._labels = labels
        self.name = name
        self._index = 0

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
    
    def __len__(self):
        """
        This function returns the length of the "labels" attribute of the object.
        
        Returns:
          The `__len__` method is returning the length of the `labels` attribute of the object.
        """

        return len(self.labels)
    
    @property
    def labels(self):
        """
        The `labels` function returns the labels stored in the `_labels` attribute of the object.
        
        Returns:
          The `labels` attribute of the object, which is accessed using `self._labels`, is being
        returned.
        """

        return self._labels
    
    def __iter__(self):
        yield from self.labels
    
    def __getitem__(self, key):
      return self.get_loc(key)