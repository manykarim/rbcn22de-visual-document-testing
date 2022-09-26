from robot.api import ExecutionResult, SuiteVisitor, ResultVisitor
import os
import xml.etree.ElementTree as ET


class TestResultParser(ResultVisitor):

    def __init__(self, output_file):
        self.testresults=[]
        self.testcase = None
        self.testsuite = None
        self.error = None
        self.reference = None
        self.candidate = None
        self.screenshots = []
        self.testfile_path = None 
        self.dir_path = os.path.dirname(os.path.realpath(output_file))

    def reset_data(self):
        self.testcase = None
        self.testsuite = None
        self.error = None
        self.reference = None
        self.candidate = None
        self.screenshots = []
        self.testfile_path = None 

    def visit_test(self, test):
        self.reset_data()
        if test.status == 'FAIL':
            self.testsuite = test.parent.name
            self.testcase = test.name
            self.error = test.message
            self.testfile_path = os.path.join(self.dir_path, 'Failed', self.testcase)
            test.body.visit(self)
            self.get_candidate()
            self.get_reference()
            self.testresults.append({'suite':self.testsuite, 'testcase':self.testcase, 'error':self.error, 'reference':self.reference, 'candidate':self.candidate, 'screenshots':self.screenshots})

    def visit_message(self, msg):  
        if hasattr(msg.parent, 'kwname') and msg.parent.kwname == 'Compare Images':
            try:
                #print(msg)
                root = ET.fromstring(str(msg.message).splitlines()[0])
                screenshot_path = os.path.join(self.dir_path, root.attrib['href'])
                self.screenshots.append(os.path.abspath(screenshot_path))
            except:
                pass

    def get_candidate(self):
        try:
            for i in os.listdir(self.testfile_path):
                if os.path.isfile(os.path.join(self.testfile_path,i)) and 'candidate_' in i:
                    self.candidate = os.path.join(self.testfile_path,i)
        except:
            self.candidate = None

    def get_reference(self):
        try:
            for i in os.listdir(self.testfile_path):
                if os.path.isfile(os.path.join(self.testfile_path,i)) and 'reference_' in i:
                    self.reference = os.path.join(self.testfile_path,i)
        except:
            self.reference = None