from google.appengine.ext import db

class Card(db.Model):
    term = db.TextProperty(required=True)
    definition = db.TextProperty(required=True)
    id_base30 = db.StringProperty()
    
    #time of creation and last edit
    last_edited = db.DateTimeProperty(auto_now=True, auto_now_add=True)
    created = db.DateTimeProperty(auto_now=False, auto_now_add=True)
    
    #user who created and last edited
    created_by = db.UserProperty(required=True)
    last_edited_by = db.UserProperty(required=True)
    
    @classmethod
    def get_by_id_base30(cls, id_base30):
        return Card.all().filter('id_base30 = ', id_base30).get()

class Deck(db.Model):
    name = db.StringProperty(required=True)
    cards = db.ListProperty(db.Key, default=None)
    id_base30 = db.StringProperty()
    
    #time of creation and last edit
    last_edited = db.DateTimeProperty(auto_now=True, auto_now_add=True)
    created = db.DateTimeProperty(auto_now=False, auto_now_add=True)
    
    #user who created and last edited
    created_by = db.UserProperty(required=True)
    last_edited_by = db.UserProperty(required=True)
        
    @classmethod
    def get_by_id_base30(cls, id_base30):
        return Deck.all().filter('id_base30 = ', id_base30).get()
    
