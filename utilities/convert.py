from weasyprint.logger import LOGGER
import logging
from weasyprint import HTML
import os
import uuid

LOGGER.disabled = True

def convert_html_to_pdf(html_file, output_folder):    
    # Generate random uuid for pdf file
    pdf_file = os.path.join(output_folder, str(uuid.uuid4()) + ".pdf")
    HTML(filename=html_file, media_type="screen").write_pdf(pdf_file)
    # Get full path of the pdf file
    pdf_file = os.path.abspath(pdf_file)
    return pdf_file