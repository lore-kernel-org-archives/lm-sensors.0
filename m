From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Thu, 28 Jun 2007 07:32:10 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <110871.10863.qm@web25104.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3749004484495360302=="
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============3749004484495360302==
Content-Type: multipart/alternative; boundary="0-2045995512-1183015930=:10863"
Content-Transfer-Encoding: 8bit

--0-2045995512-1183015930=:10863
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello
=20
 >>> This means that the driver isn't reporting the values in RPM as it
 >>> should. Usually no compute statement is needed for fans.
 >> That's correct, the value is not in RPM, in the document
 >> '2005111153128.pdf' you can download on the fintek page
 >> ( http://www.fintek.com.tw/eng/products.asp?BID=3D4&SID=3D5 )its writte=
n on
 >> page 8:
 >> "Determine the fan counter according to:
 >> Count =3D (1.5=D710^6) / RPM "
 >> That means that the driver is reporting the count value, not the rpm.
 >> So i have to compute in sensors.conf:
 >> RPM =3D (1.5=D710^6)/ Count
 >
 >Thus this algorithm actually return sane RPM values for you? Now I
 >remember why I did not use this - Here the "Count" rises linear, which
 >makes "RPM =3D(1.5=D710^6)/ Count" *lower* when fan speed increases. OTOH=
 it
 >might be the fan is just too small and thus rotates too fast to be
 >reliably measured..
=20
 During implementation i tested  different values for pwm here are my resul=
ts:
 pwm1  fan1      fanspeed ( using: fanspeed =3D(1.5=D710^6)/ fan1-value )
 value value
  13   2600      ~570 rpm
  14   1900       :
  15   1900       :
  23   1100       :
  34    770     ~1950 rpm
   :     :        :
  90    385     ~3900 rpm
  95    375     ~4000 rpm
 100    365     ~4180 rpm
 105    360     ~4230 rpm
 110    345     ~4360 rpm
 115    345     ~4360 rpm
 120    335     ~4500 rpm
 125    330     ~4630 rpm
=20
=20
 So if i start my pc the pwm is at ~32 and the fan is turning at ~1800rpm. =
If i increase
 the pwm value the value of the counter decreased! So if the pwm value is ~=
110 the van turns at >4000rpm
 and the fan1 value is ~365.
 The pc i use is a barebone by AOpen with an special mainboard and fan, bot=
h comes with the barebone.
=20
 best regards
 christian.
      =20
---------------------------------
 Die etwas anderen Infos rund um das Thema Reisen. BE A BETTER WELTENBUMMLE=
R!
--0-2045995512-1183015930=:10863
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: courier;">Hello</span><br style=3D"font-family:=
 courier;"> <br style=3D"font-family: courier;"> <span style=3D"font-family=
: courier;">&gt;&gt;&gt; This means that the driver isn't reporting the val=
ues in RPM as it</span><br style=3D"font-family: courier;"> <span style=3D"=
font-family: courier;">&gt;&gt;&gt; should. Usually no compute statement is=
 needed for fans.</span><br style=3D"font-family: courier;"> <span style=3D=
"font-family: courier;">&gt;&gt; That's correct, the value is not in RPM, i=
n the document</span><br style=3D"font-family: courier;"> <span style=3D"fo=
nt-family: courier;">&gt;&gt; '2005111153128.pdf' you can download on the f=
intek page</span><br style=3D"font-family: courier;"> <span style=3D"font-f=
amily: courier;">&gt;&gt; ( http://www.fintek.com.tw/eng/products.asp?BID=
=3D4&amp;SID=3D5 )its written on</span><br style=3D"font-family: courier;">=
 <span style=3D"font-family: courier;">&gt;&gt; page 8:</span><br style=3D"=
font-family: courier;"> <span style=3D"font-family:
 courier;">&gt;&gt; "Determine the fan counter according to:</span><br styl=
e=3D"font-family: courier;"> <span style=3D"font-family: courier;">&gt;&gt;=
 Count =3D (1.5=D710^6) / RPM "</span><br style=3D"font-family: courier;"> =
<span style=3D"font-family: courier;">&gt;&gt; That means that the driver i=
s reporting the count value, not the rpm.</span><br style=3D"font-family: c=
ourier;"> <span style=3D"font-family: courier;">&gt;&gt; So i have to compu=
te in sensors.conf:</span><br style=3D"font-family: courier;"> <span style=
=3D"font-family: courier;">&gt;&gt; RPM =3D (1.5=D710^6)/ Count</span><br s=
tyle=3D"font-family: courier;"> <span style=3D"font-family: courier;">&gt;<=
/span><br style=3D"font-family: courier;"> <span style=3D"font-family: cour=
ier;">&gt;Thus this algorithm actually return sane RPM values for you? Now =
I</span><br style=3D"font-family: courier;"> <span style=3D"font-family: co=
urier;">&gt;remember why I did not use this - Here the "Count" rises linear=
, which</span><br style=3D"font-family: courier;">
 <span style=3D"font-family: courier;">&gt;makes "RPM =3D(1.5=D710^6)/ Coun=
t" *lower* when fan speed increases. OTOH it</span><br style=3D"font-family=
: courier;"> <span style=3D"font-family: courier;">&gt;might be the fan is =
just too small and thus rotates too fast to be</span><br style=3D"font-fami=
ly: courier;"> <span style=3D"font-family: courier;">&gt;reliably measured.=
.</span><br style=3D"font-family: courier;"> <br style=3D"font-family: cour=
ier;"> <span style=3D"font-family: courier;">During implementation i tested=
&nbsp; different values for pwm here are my results:</span><br style=3D"fon=
t-family: courier;"> <span style=3D"font-family: courier;">pwm1&nbsp; fan1&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fanspeed ( using: fanspeed =3D(1.5=D710^6)/ f=
an1-value )</span><br style=3D"font-family: courier;"> <span style=3D"font-=
family: courier;">value value</span><br style=3D"font-family: courier;"> <s=
pan style=3D"font-family: courier;">&nbsp;13&nbsp;&nbsp; 2600&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ~570 rpm</span><br
 style=3D"font-family: courier;"> <span style=3D"font-family: courier;">&nb=
sp;14&nbsp;&nbsp; 1900&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</span><br styl=
e=3D"font-family: courier;"> <span style=3D"font-family: courier;">&nbsp;15=
&nbsp;&nbsp; 1900&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</span><br style=3D"=
font-family: courier;"> <span style=3D"font-family: courier;">&nbsp;23&nbsp=
;&nbsp; 1100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</span><br style=3D"font-=
family: courier;"> <span style=3D"font-family: courier;">&nbsp;34&nbsp;&nbs=
p;&nbsp; 770&nbsp;&nbsp;&nbsp;&nbsp; ~1950 rpm</span><br style=3D"font-fami=
ly: courier;"> <span style=3D"font-family: courier;">&nbsp; :&nbsp;&nbsp;&n=
bsp;&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</span><br style=3D=
"font-family: courier;"> <span style=3D"font-family: courier;">&nbsp;90&nbs=
p;&nbsp;&nbsp; 385&nbsp;&nbsp;&nbsp;&nbsp; ~3900 rpm</span><br style=3D"fon=
t-family: courier;"> <span style=3D"font-family: courier;">&nbsp;95&nbsp;&n=
bsp;&nbsp; 375&nbsp;&nbsp;&nbsp;&nbsp;
 ~4000 rpm</span><br style=3D"font-family: courier;"> <span style=3D"font-f=
amily: courier;">100&nbsp;&nbsp;&nbsp; 365&nbsp;&nbsp;&nbsp;&nbsp; ~4180 rp=
m</span><br style=3D"font-family: courier;"> <span style=3D"font-family: co=
urier;">105&nbsp;&nbsp;&nbsp; 360&nbsp;&nbsp;&nbsp;&nbsp; ~4230 rpm</span><=
br style=3D"font-family: courier;"> <span style=3D"font-family: courier;">1=
10&nbsp;&nbsp;&nbsp; 345&nbsp;&nbsp;&nbsp;&nbsp; ~4360 rpm</span><br style=
=3D"font-family: courier;"> <span style=3D"font-family: courier;">115&nbsp;=
&nbsp;&nbsp; 345&nbsp;&nbsp;&nbsp;&nbsp; ~4360 rpm</span><br style=3D"font-=
family: courier;"> <span style=3D"font-family: courier;">120&nbsp;&nbsp;&nb=
sp; 335&nbsp;&nbsp;&nbsp;&nbsp; ~4500 rpm</span><br style=3D"font-family: c=
ourier;"> <span style=3D"font-family: courier;">125&nbsp;&nbsp;&nbsp; 330&n=
bsp;&nbsp;&nbsp;&nbsp; ~4630 rpm</span><br style=3D"font-family: courier;">=
 <br style=3D"font-family: courier;"> <br style=3D"font-family: courier;"> =
<span style=3D"font-family: courier;">So if i
 start my pc the pwm is at ~32 and the fan is turning at ~1800rpm. If i inc=
rease</span><br style=3D"font-family: courier;"> <span style=3D"font-family=
: courier;">the pwm value the value of the counter decreased! So if the pwm=
 value is ~110 the van turns at &gt;4000rpm</span><br style=3D"font-family:=
 courier;"> <span style=3D"font-family: courier;">and the fan1 value is ~36=
5.</span><br style=3D"font-family: courier;"> <span style=3D"font-family: c=
ourier;">The pc i use is a barebone by AOpen with an special mainboard and =
fan, both comes with the barebone.</span><br style=3D"font-family: courier;=
"> <br style=3D"font-family: courier;"> <span style=3D"font-family: courier=
;">best regards</span><br style=3D"font-family: courier;"> <span style=3D"f=
ont-family: courier;">christian.</span><p>&#32;
      <hr size=3D1> Die etwas anderen Infos rund um das Thema Reisen.=20
<a href=3D"http://de.rd.yahoo.com/evt=3D48734/*http://de.promotions.yahoo.c=
om/clever/be-a-better/weltenbummler.html" target=3D_new >
<b>BE A BETTER WELTENBUMMLER!</b></a>
--0-2045995512-1183015930=:10863--


--===============3749004484495360302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3749004484495360302==--
