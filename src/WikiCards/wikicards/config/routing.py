"""Routes configuration

The more specific and detailed routes should be defined first so they
may take precedent over the more generic routes. For more information
refer to the routes manual at http://routes.groovie.org/docs/
"""
from pylons import config
from routes import Mapper

def make_map():
    """Create, configure and return the routes Mapper"""
    map = Mapper(directory=config['pylons.paths']['controllers'],
                 always_scan=config['debug'])
    map.minimization = False
    
    # The ErrorController route (handles 404/500 error pages); it should
    # likely stay at the top, ensuring it can always be resolved
    map.connect('/error/{action}', controller='error')
    map.connect('/error/{action}/{id}', controller='error')

    # CUSTOM ROUTES HERE
    
    #Deck routes
    map.connect('home_page','/', controller='Deck', action='index')
    map.connect('create_deck','/deck/create', controller='Deck', action='create')
    map.connect('view_deck','/deck/:deck_id', controller='Deck', action='view')
    
    #Card routes
    map.connect('create_card','/card/create', controller='Card', action='create')
    map.connect('update_card','/card/:card_id/update', controller='Card', action='update')
    map.connect('view_card','/card/:card_id/view', controller='Card', action='view')
    
    
    return map
