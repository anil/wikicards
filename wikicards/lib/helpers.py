"""Helper functions

Consists of functions to typically be used within templates, but also
available to Controllers. This module is available to both as 'h'.
"""
# Import helpers as desired, or define your own, ie:
# from webhelpers.html.tags import checkbox, password

from routes import url_for, redirect_to
from webhelpers.html import escape, HTML, literal, url_escape
from webhelpers.html.tags import *

good_characters = "23456789abcdefghjkmnpqrtuvwxyz"

base = len(good_characters)

def make_identifier(number):
    """
    Encodes a number as an identifier.
    """
    if not isinstance(number, (int, long)):
        raise ValueError(
            "You can only make identifiers out of integers (not %r)"
            % number)
    if number < 0:
        raise ValueError(
            "You cannot make identifiers out of negative numbers: %r"
            % number)
    result = []
    while number:
        next = number % base
        result.append(good_characters[next])
        # Note, this depends on integer rounding of results:
        number = number / base
    return ''.join(result)
    
