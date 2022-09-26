from weasyprint.logger import LOGGER
import logging
from weasyprint import HTML
import os

LOGGER.disabled = True

def convert_html_to_pdf(html_file, pdf_file):    
    HTML(filename=html_file, media_type="screen").write_pdf(pdf_file)
    # Get full path of the pdf file
    pdf_file = os.path.abspath(pdf_file)
    return pdf_file

def generate_document(html_file, pdf_file):
    HTML(filename=html_file).write_pdf(pdf_file)
    pdf_file = os.path.abspath(pdf_file)
    return pdf_file