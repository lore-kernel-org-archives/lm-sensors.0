From: Justin Chudgar <justin@justinzane.com>
Date: Tue, 24 Feb 2009 19:18:10 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <200902241118.11911.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3217326751577444466=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200902221052.31780.justin@justinzane.com>
In-Reply-To: <200902221052.31780.justin@justinzane.com>
To: lm-sensors@vger.kernel.org

--===============3217326751577444466==
Content-Type: multipart/alternative; boundary="Boundary-00=_zfEpJGPlbx3U19M"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_zfEpJGPlbx3U19M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Rudolf:

Juerg is the one who has been helping me out; so everything I say is likely a 
less accurate repetition of his words. My understanding is that there is at 
least one, and probably more, system configurations from VIA with C7 CPUs that 
do not work with the current c7temp module.

In my case it is a HP 2133 Mini-Note KX869AT. Michael has a different system, 
but the same issue. I used the version of CPUID that Juerg recommended and 
provided the output to him and the list several months ago. At that time he 
mentioned that he needed documentation from VIA to determine which registers 
meant what.


If you, Rudolf, are able to find out any technical info about these CPUs, or if 
you need more accurate technical info about the problems with c7temp, I would 
suggest contacting Juerg. I will be happy to provide any data from my system 
and try any patches that may help; but, I am sadly not a developer.

Thank you all for your interest and effort. 
-- 

Justin Chudgar
Information Technology Consultant
5040 Saddlehorn Rd, Weed, CA 96084
530-938-9692 (Home Office)



--Boundary-00=_zfEpJGPlbx3U19M
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Myriad Pro'; font-size:8pt; font-weight:400; font-style:normal;">Rudolf:<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Juerg is the one who has been helping me out; so everything I say is likely a less accurate repetition of his words. My understanding is that there is at least one, and probably more, system configurations from VIA with C7 CPUs that do not work with the current c7temp module.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>In my case it is a HP 2133 Mini-Note KX869AT. Michael has a different system, but the same issue. I used the version of CPUID that Juerg recommended and provided the output to him and the list several months ago. At that time he mentioned that he needed documentation from VIA to determine which registers meant what.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>If you, Rudolf, are able to find out any technical info about these CPUs, or if you need more accurate technical info about the problems with c7temp, I would suggest contacting Juerg. I will be happy to provide any data from my system and try any patches that may help; but, I am sadly not a developer.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Thank you all for your interest and effort. <br />-- <br /><br>
<span style=" font-family:'betecknalowercasebold';">Justin Chudgar</span><br>
Information Technology Consultant<br>
5040 Saddlehorn Rd, Weed, CA 96084<br>
530-938-9692 (Home Office)<br>
<br /></p></body></html>
--Boundary-00=_zfEpJGPlbx3U19M--


--===============3217326751577444466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3217326751577444466==--
