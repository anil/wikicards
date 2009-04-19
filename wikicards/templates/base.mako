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
<script type="text/javascript"><!--
google_ad_client = "pub-0243156371147212";
/* 468x60, created 4/15/09 */
google_ad_slot = "5126384616";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
<div id="contact" style="padding-top: 2em;">
  Please send feedback here: <a href="http://anilmakhijani.com/about/">http://anilmakhijani.com/about/</a>
</div>
<script type="text/javascript">
  var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
  document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
  try {
    var pageTracker = _gat._getTracker("UA-8429317-1");
    pageTracker._trackPageview();
   } catch(err) {
   }
</script>
        </div><!-- /#footer -->
    </div><!-- /#container -->
 </body>
</html>

<%def name="title()">
${c.title}
</%def>

<%def name="extra_head()">
</%def>

