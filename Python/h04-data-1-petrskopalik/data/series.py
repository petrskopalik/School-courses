from .indexed_container import IndexedContainer


class Series(IndexedContainer):
    """
    The `Series` class represents a series of values with methods for calculating sum, max, min, mean,
    applying a function to each value, and getting the absolute values.
    """

    def __init__(self, values, index=None):
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

        new_vals = []

        for val in self.values:
            new_vals.append(func(val))

        return Series(new_vals, self.index)
    
    def abs(self):
        """
        The `abs` function returns the absolute value of the input by applying the `abs` function to it.
        
        Returns:
          A new Series object with the values modified by the absolute function and the same index as the
        original Series (it uses a `apply` method).
        """

        return self.apply(abs)