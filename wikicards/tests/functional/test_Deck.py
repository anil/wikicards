from wikicards.tests import *

class TestDeckController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='Deck', action='index'))
        # Test response...
