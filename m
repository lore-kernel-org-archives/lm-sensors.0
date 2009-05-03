From: Robert Grasso <robert.grasso@modulonet.fr>
Date: Sun, 03 May 2009 19:46:44 +0000
Subject: [lm-sensors] cgi page failing to build
Message-Id: <200905032146.45691.robert.grasso@modulonet.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5805233049547469531=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5805233049547469531==
Content-Type: multipart/alternative; boundary="Boundary-00=_lSf/JvMpRqKdWxl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_lSf/JvMpRqKdWxl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

I am using lm-sensors 3.0.2 on Ubuntu 9.04. When I try to generate the cgi page, the generated page is as follows (after my signature)

I am afraid that lines such as 
<IMG SRC=/sensord//var/www/sensord/daily-rpm.png WIDTH=897 HEIGHT=274>

are bugged ?

it seems to be a problem with rrdcgi ? What is your opinion ?

Regards

-- 
Robert Grasso
@home
---
UNIX was not designed to stop you from doing stupid things, because 
  that would also stop you from doing clever things. -- Doug Gwyn



root@power4:/etc# /usr/lib/cgi-bin/sensord.cgi
(offline mode: enter name=value pairs on standard input)
Content-Type: text/html
Content-Length: 966


<HTML>
<HEAD>
<TITLE>sensord</TITLE>
</HEAD>
<BODY>
<H1>sensord</H1>
<H2>Daily Temperature Summary</H2>
<P>
<IMG SRC=/sensord//var/www/sensord/daily-temperature.png WIDTH=897 HEIGHT=274>
</P>
<H2>Daily Fan Speed Summary</H2>
<P>
<IMG SRC=/sensord//var/www/sensord/daily-rpm.png WIDTH=897 HEIGHT=274>
</P>
<H2>Daily Voltage Summary</H2>
<P>
<IMG SRC=/sensord//var/www/sensord/daily-voltage.png WIDTH=897 HEIGHT=274>
</P>
<H2>Weekly Temperature Summary</H2>
<P>
<IMG SRC=/sensord//var/www/sensord/weekly-temperature.png WIDTH=897 HEIGHT=274>
</P>
<H2>Weekly Fan Speed Summary</H2>
<P>
<IMG SRC=/sensord//var/www/sensord/weekly-rpm.png WIDTH=897 HEIGHT=274>
</P>
<H2>Weekly Voltage Summary</H2>
<P>
<IMG SRC=/sensord//var/www/sensord/weekly-voltage.png WIDTH=897 HEIGHT=274>
</P>
<p>
<small><b>sensord</b> by <a href="mailto:merlin@merlin.org">Merlin Hughes</a>, all credit to the <a href="http://www.lm-sensors.org/">lm_sensors</a> crew.</small>
</p>
</BODY>
</HTML>

--Boundary-00=_lSf/JvMpRqKdWxl
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Sans Serif'; font-size:12pt; font-weight:400; font-style:normal;">Hello,<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>I am using lm-sensors 3.0.2 on Ubuntu 9.04. When I try to generate the cgi page, the generated page is as follows (after my signature)<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>I am afraid that lines such as <br>
&lt;IMG SRC=/sensord//var/www/sensord/daily-rpm.png WIDTH=897 HEIGHT=274&gt;<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>are bugged ?<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>it seems to be a problem with rrdcgi ? What is your opinion ?<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Regards<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>-- <br>
Robert Grasso<br>
@home<br>
---<br>
UNIX was not designed to stop you from doing stupid things, because <br>
  that would also stop you from doing clever things. -- Doug Gwyn<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>root@power4:/etc# /usr/lib/cgi-bin/sensord.cgi<br>
(offline mode: enter name=value pairs on standard input)<br>
Content-Type: text/html<br>
Content-Length: 966<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>&lt;HTML&gt;<br>
&lt;HEAD&gt;<br>
&lt;TITLE&gt;sensord&lt;/TITLE&gt;<br>
&lt;/HEAD&gt;<br>
&lt;BODY&gt;<br>
&lt;H1&gt;sensord&lt;/H1&gt;<br>
&lt;H2&gt;Daily Temperature Summary&lt;/H2&gt;<br>
&lt;P&gt;<br>
&lt;IMG SRC=/sensord//var/www/sensord/daily-temperature.png WIDTH=897 HEIGHT=274&gt;<br>
&lt;/P&gt;<br>
&lt;H2&gt;Daily Fan Speed Summary&lt;/H2&gt;<br>
&lt;P&gt;<br>
&lt;IMG SRC=/sensord//var/www/sensord/daily-rpm.png WIDTH=897 HEIGHT=274&gt;<br>
&lt;/P&gt;<br>
&lt;H2&gt;Daily Voltage Summary&lt;/H2&gt;<br>
&lt;P&gt;<br>
&lt;IMG SRC=/sensord//var/www/sensord/daily-voltage.png WIDTH=897 HEIGHT=274&gt;<br>
&lt;/P&gt;<br>
&lt;H2&gt;Weekly Temperature Summary&lt;/H2&gt;<br>
&lt;P&gt;<br>
&lt;IMG SRC=/sensord//var/www/sensord/weekly-temperature.png WIDTH=897 HEIGHT=274&gt;<br>
&lt;/P&gt;<br>
&lt;H2&gt;Weekly Fan Speed Summary&lt;/H2&gt;<br>
&lt;P&gt;<br>
&lt;IMG SRC=/sensord//var/www/sensord/weekly-rpm.png WIDTH=897 HEIGHT=274&gt;<br>
&lt;/P&gt;<br>
&lt;H2&gt;Weekly Voltage Summary&lt;/H2&gt;<br>
&lt;P&gt;<br>
&lt;IMG SRC=/sensord//var/www/sensord/weekly-voltage.png WIDTH=897 HEIGHT=274&gt;<br>
&lt;/P&gt;<br>
&lt;p&gt;<br>
&lt;small&gt;&lt;b&gt;sensord&lt;/b&gt; by &lt;a href="mailto:merlin@merlin.org"&gt;Merlin Hughes&lt;/a&gt;, all credit to the &lt;a href="http://www.lm-sensors.org/"&gt;lm_sensors&lt;/a&gt; crew.&lt;/small&gt;<br>
&lt;/p&gt;<br>
&lt;/BODY&gt;<br>
&lt;/HTML&gt;<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></body></html>
--Boundary-00=_lSf/JvMpRqKdWxl--


--===============5805233049547469531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5805233049547469531==--
