<%page expression_filter="h" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">    
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head profile="http://gmpg.org/xfn/11">
  <title>Clever Camel Flash Cards ${self.title()}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="en-us" />
    <link rel="stylesheet" type="text/css" href="${h.url_for('/style.css')}">
    ${self.extra_head()}
 </head>
 <body>
    <div id="container" class="selfclear">
        <div id="header">
            <h1 id="logo">Flash Cards</h1>
            <h3 id="tag-line"> Learn some. Teach some.</h3>
        </div><!-- /#header -->
        <div id = "login">
          % if c.logged_in:
              <a href="${c.auth_url}">Logout</a>
          % else:
              <a href="${c.auth_url}">Login</a>
          % endif
        </div><!-- /#login -->
        <div id="main">
            <div id="content">
                 ${next.body()}
            </div><!-- /#content -->
        </div><!-- /#main -->
        <div id="footer">
                    <p class = "discreet">Created and produced by <a href="http://anilmakhijani.com">http://anilmakhijani.com</a> </p>
        </div><!-- /#footer -->
    </div><!-- /#container -->
 </body>
</html>

<%def name="title()">
${c.title}
</%def>

<%def name="extra_head()">
</%def>

