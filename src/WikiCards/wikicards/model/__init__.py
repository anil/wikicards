from google.appengine.ext import db

class WikiableContent(db.Model):
    def __init__(self, *args, **kw):
        if self.__class__.__name__ == "WikiableContent":
            raise 'Not implemented'
        super(WikiableContent, self).__init__(*args, **kw)
    
    id_base30 = db.StringProperty()
    
    #time of creation and last edit
    last_edited = db.DateTimeProperty(auto_now=True, auto_now_add=True)
    created = db.DateTimeProperty(auto_now=False, auto_now_add=True)
    
    #user who created and last edited
    created_by = db.UserProperty(required=True)
    last_edited_by = db.UserProperty(required=True)
    
    @classmethod
    def get_by_id_base30(cls, id_base30):
        return cls.all().filter('id_base30 = ', id_base30).get()

class Card(WikiableContent):
    term = db.TextProperty(required=True)
    definition = db.TextProperty(required=True)
    

class Deck(WikiableContent):
    name = db.StringProperty(required=True)
    cards = db.ListProperty(db.Key, default=None)
    
  

    
