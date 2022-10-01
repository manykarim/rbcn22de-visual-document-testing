from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets
from PyQt5.QtCore import Qt, QModelIndex

class TableModel(QtCore.QAbstractTableModel):
    def __init__(self, data):
        super(TableModel, self).__init__()
        self._data = data

    def reload_data(self, data):
        self._data = data
        self.layoutChanged.emit()

    def data(self, index, role):
        if role == Qt.DisplayRole:
            # See below for the nested-list data structure.
            # .row() indexes into the outer list,
            # .column() indexes into the sub-list
            value = self._data[index.row()][index.column()]
            if isinstance(value, bool):
                if value:
#                    return QtGui.QIcon("tick.png")
                    return QtWidgets.QCheckBox("True")
                return QtWidgets.QCheckBox("False")
            return value
    
    def removeRows(self, position, rows, QModelIndex):
        self.beginRemoveRows(QModelIndex, position, position+rows-1)
        for i in range(rows):
            del(self._data[position])
        self.endRemoveRows()
        
        return True


    def headerData(self, section, orientation, role):
        if role != Qt.DisplayRole:
            return None
        if orientation == Qt.Horizontal:
    	            return ["Test Suite", "Test Case", "Error Message", "Reference", "Candidate", "Accept", "Screenshots"][section]
        else:
            return "{}".format(section)

    def rowCount(self, index):
        # The length of the outer list.
        return len(self._data)
    
    def columnCount(self, index):
        # The following takes the first sub-list, and returns
        # the length (only works if all rows are an equal length)
        return len(self._data[0])
    
    def flags(self, index):
        if index.column() == 5:
            return Qt.ItemIsEditable | Qt.ItemIsEnabled | \
               Qt.ItemIsSelectable
        else:
            return Qt.ItemIsEnabled | Qt.ItemIsSelectable

    def acceptChanges(self , row):
        self._data[row][5] = 1

    def declineChanges(self , row):
        self._data[row][5] = 0

    def setData(self, index, value, role=QtCore.Qt.DisplayRole):
        if index.column() == 5:
            self._data[index.row()][index.column()]=value
            return value
        return value