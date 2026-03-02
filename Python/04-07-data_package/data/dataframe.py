import pathlib
import csv

from .series import Series
from .indexed_container import IndexedContainer
from .exceptions import InvalidDataError
from .index import Index


class DataFrame(IndexedContainer):
    """This class extends the IndexedContainer class to create a Dataframe object."""

    def __init__(self, values, index=None):
        for item in values:
            if not isinstance(item, Series):
                raise InvalidDataError()
        
        super().__init__(values, index)

    @property
    def shape(self):
        """
        The `shape` function returns the dimensions of a DataFrame.

        Returns:
            A Tuple (Rows, Columns).
        """

        return (len(self.values[0]), len(self))
    
    @classmethod
    def from_csv(cls, filepath:pathlib.Path, separator=","):
        """
        The function `from_csv` reads data from text and creates a DataFrame object.
        
        Args:
          text (str): Text that contains headers, row labels and row data
          separator: Specific character or string that separates values in the text. Defaults to `,`
        
        Returns:
          A DataFrame object.
        """
        if not filepath.exists():
            raise FileNotFoundError
        
        with open(filepath, "r") as file:
            csv_data = csv.reader(file, delimiter=separator)
            rows = [row for row in csv_data]

        headers = rows[0][1:]

        row_labels = [row[0] for row in rows[1:]]
        row_data = [row[1:] for row in rows[1:]]

        series = []
        num_cells = len(row_data)

        for i in range(len(headers)):
            column_data = [row_data[cell][i] for cell in range(num_cells)]
            series.append(Series(column_data, Index(row_labels)))

        return cls(series, Index(headers))
    
    def __repr__(self):
        return f"DataFrame{self.shape}"
    
    def __str__(self):
        return repr(self)
    
    def __iter__(self):
        yield from self.index