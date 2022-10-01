"""
create 100 copies of the file "invoice.pdf" in current directpry with a suffix of 1 to 100
Example:
invoice_001.pdf
invoice_002.pdf
invoice_003.pdf
"""
import os
for i in range(100):
    os.system("copy invoice.pdf invoice_%03d.pdf" % (i+1))