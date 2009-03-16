"""The base Controller API

Provides the BaseController class for subclassing.
"""
from pylons import c
from pylons.controllers import WSGIController
from pylons.templating import render_mako as render

from google.appengine.api import users


class BaseController(WSGIController):

    def __call__(self, environ, start_response):
        """Invoke the Controller"""
        # WSGIController.__call__ dispatches to the Controller method
        # the request is routed to. This routing information is
        # available in environ['pylons.routes_dict']
        user = users.get_current_user()
        if user:
            c.logged_in = True
            c.auth_url = users.create_logout_url("/")
        else:
            c.logged_in = False
            c.auth_url = users.create_login_url("/")

        return WSGIController.__call__(self, environ, start_response)
