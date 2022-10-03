from weasyprint.logger import LOGGER
import logging
from weasyprint import HTML
import os
import uuid

LOGGER.disabled = True

def convert_html_to_pdf(html_file, pdf_file):
    # If pdf_file is a directory, create a new file with a random name
    # in that directory.
    # If pdf_file is a file, use that file.
    # If pdf_file is None, create a new file with a random name in the
    # current directory.
    if pdf_file is None:
        pdf_file = os.path.join(os.getcwd(), str(uuid.uuid4()) + '.pdf')
    elif os.path.isdir(pdf_file):
        pdf_file = os.path.join(pdf_file, str(uuid.uuid4()) + '.pdf')
    HTML(html_file).write_pdf(pdf_file)
    return pdf_file