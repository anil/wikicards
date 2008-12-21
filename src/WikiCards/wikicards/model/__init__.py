from google.appengine.ext import db

class Card(db.Model):
    term = db.StringProperty(required=True)
    definition = db.StringProperty(required=True)
    
    #time of creation and last edit
    last_edited_datetime = db.DateTimeProperty(auto_now=True, auto_now_add=True)
    created_datetime = db.DateTimeProperty(auto_now=False, auto_now_add=True)
    
    #user who created and last edited
    create_user = db.UserProperty(required=True)
    last_edit_user = db.UserProperty(required=True)

    id_base30 = db.StringProperty()
    
    @classmethod
    def get_by_id_base30(cls, id_base30):
        return Card.all().filter('id_base30 = ', id_base30).get()

class Deck(db.Model):
    name = db.StringProperty(required=True)
    cards = db.ListProperty(db.Key, default=None)
    id_base30 = db.StringProperty()
    
    #time of creation and last edit
    last_edited_datetime = db.DateTimeProperty(auto_now=True, auto_now_add=True)
    created_datetime = db.DateTimeProperty(auto_now=False, auto_now_add=True)
    
    #user who created and last edited
    create_user = db.UserProperty(required=True)
    last_edit_user = db.UserProperty(required=True)
    
    
    @classmethod
    def get_by_id_base30(cls, id_base30):
        return Deck.all().filter('id_base30 = ', id_base30).get()
    
