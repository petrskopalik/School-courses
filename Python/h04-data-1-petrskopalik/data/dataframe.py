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