from wikicards.tests import *

class TestCardController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='Card', action='index'))
        # Test response...
