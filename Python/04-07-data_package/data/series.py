import operator
import itertools
import pathlib
import csv

from .indexed_container import IndexedContainer
from .index import Index


class Series(IndexedContainer):
    """
    The `Series` class represents a series of values with methods for calculating sum, max, min, mean,
    applying a function to each value, and getting the absolute values.
    """

    def __init__(self, values, index=None):
        self._i = 0
        super().__init__(values, index)

    def sum(self):
        """
        The function calculates the sum of the values in a list.
        
        Returns:
          The sum of the values stored in the `self.values` list.
        """

        return sum(self.values)
    
    def max(self):
        """
        The function returns the maximum value from a collection of values.
        
        Returns:
          The maximum value from the list of values stored in the
        `self.values` attribute.
        """

        return max(self.values)
    
    def min(self):
        """
        The function returns the minimum value from a collection of values.
        
        Returns:
          The minimum value from the list of values stored in the
        `self.values` attribute.
        """

        return min(self.values)
    
    def mean(self):
        """
        The `mean` function calculates the average value of a list of numbers.
        
        Returns:
          The average value of the elements in the `values` list of the
        object.
        """

        return sum(self.values)/len(self.values)
    
    def apply(self, func):
        """
        The function `apply` takes a function as input and applies it to each value in a Series object,
        returning a new Series with the modified values.
        
        Args:
          func: The `func` parameter is a function that will be applied to each
        value in the `Series` object. 
        
        Returns:
          A new Series object with the values modified by the provided function and the same index as the
        original Series.
        """

        return Series([func(val) for val in self.values], self.index)
    
    def abs(self):
        """
        The `abs` function returns the absolute value of the input by applying the `abs` function to it.
        
        Returns:
          A new Series object with the values modified by the absolute function and the same index as the
        original Series (it uses a `apply` method).
        """

        return self.apply(abs)
    
    @property
    def shape(self):
        """
        The function `shape` returns a tuple containing the lengths of the `values` and `index`
        attributes of the object it is called on.
        
        Returns:
          The `shape` method is returning a tuple containing the length of the `values` attribute and
        the length of the `index` attribute of the object.
        """

        return (len(self.values), )
    
    @classmethod
    def from_csv(cls, filepath:pathlib.Path, separator=","):
        """
        The function `from_cvs` parses a text input containing data and returns a Series object.
        
        Args:
          text (str): The `text` parameter is a string containing the CSV data
        that you want to parse.
          separator: The `separator` parameter is used to specify the character
        or characters that separate the values in the text. Default separator is ",".
        
        Returns:
          New Series object filled with data from `text`.
        """
        if not filepath.exists():
            raise FileNotFoundError

        with open(filepath, "r") as file:
          csv_data = csv.reader(file, delimiter=separator)
          lines = [row for row in csv_data]

        index = Index(lines[0])
        values = lines[1]
        
        return cls(values, index)
    
    def __repr__(self):
        return "\n".join([f"{label}\t{value}" for label, value in zip(self.index.labels, self.values)])
    
    def __str__(self):
        return repr(self)
    
    def _apply_operator(self, other, operator):
        """
        The function `_apply_operator` performs element-wise operations between two Series objects.
        
        Args:
          other: The `other` parameter is expected to be an instance of the `Series` class.
        If it is not an instance of the `Series` class, the method will return `NotImplemented`.
          operator: The `operator` parameter is a function that will be
        applied element-wise to the values of two Series objects.
        
        Returns:
          A new `Series` object with values resulting from applying
        the operator to corresponding elements of the two `Series` objects.
        If the operation is not supported or if the lengths of the two `Series` objects are not equal the `NotImplemented`
        is returned.
        """

        if not isinstance(other, Series):
            return NotImplemented
        
        if len(self.values) != len(other.values):
            raise ValueError

        values = [operator(x, y) for x, y in zip(self.values, other.values)]
        
        return Series(values, self.index)
    
    def __add__(self, other):
        return self._apply_operator(other, operator.add)
    
    def __sub__(self, other):
        return self._apply_operator(other, operator.sub)
    
    def __mul__(self, other):
        return self._apply_operator(other, operator.mul)
    
    def __truediv__(self, other):
        return self._apply_operator(other, operator.truediv)
    
    def __floordiv__(self, other):
        return self._apply_operator(other, operator.floordiv)
            
    def __mod__(self, other):
        return self._apply_operator(other, operator.mod)
    
    def __pow__(self, other):
        return self._apply_operator(other, operator.pow)
    
    def __round__(self, precision=0):
        return Series(self.values, self.index).apply(lambda x: round(x, precision))
    
    def __iter__(self):
        yield from self.values
    
    def iterate_over(self):
        """
        The function `iterate_over` returns an iterator of values in Series.
        
        Returns:
          Iterator.
        """

        return itertools.cycle(self.values)