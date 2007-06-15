From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Fri, 15 Jun 2007 06:53:28 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <105617.43756.qm@web25113.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0391144908231601401=="
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============0391144908231601401==
Content-Type: multipart/alternative; boundary="0-230200421-1181890408=:43756"
Content-Transfer-Encoding: 8bit

--0-230200421-1181890408=:43756
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello Jean,

> > The module is recognized by 'sensors-detect' but i'm not able to get
> > an output running 'sensors', because the needed functions, structs and
> > defines are mostly not correct.

> I suggest that you take a look at a patch doing the same for another driv=
er:

> http://www.lm-sensors.org/changeset/4355

> This patch was adding user-space support for the dme1737 driver. You=20
> need to do something very similar, except for sensors-detect which you
> probably don't need to change.

> If you have specific questions on the way, feel free to ask, but all in
> all, copy and paste and a bit of trial and error should work fine.

> Please submit your patch when you're done, so that we can apply it and
> everybody benefits.

> --=20
> Jean Delvare

Thank you for your answer. I take a look at the changeset for=20
the dme1737 driver, it seems that this is the example i was looking for.

I will try to start 'copying and pasting' this afternoon,=20
if it work i will submit it.

christian.


 __________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden Schut=
z gegen Massenmails.=20
http://mail.yahoo.com=20
--0-230200421-1181890408=:43756
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<pre>Hello Jean,<br><br>&gt; &gt;<i> The module is recognized by 'sensors-d=
etect' but i'm not able to get<br></i>&gt; &gt;<i> an output running 'senso=
rs', because the needed functions, structs and<br></i>&gt; &gt;<i> defines =
are mostly not correct.<br></i><br><span style=3D"font-style: italic;">&gt;=
 I suggest that you take a look at a patch doing the same for another drive=
r:</span><br style=3D"font-style: italic;"><br style=3D"font-style: italic;=
"><span style=3D"font-style: italic;">&gt; </span><a style=3D"font-style: i=
talic;" href=3D"http://www.lm-sensors.org/changeset/4355">http://www.lm-sen=
sors.org/changeset/4355</a><br style=3D"font-style: italic;"><br style=3D"f=
ont-style: italic;"><span style=3D"font-style: italic;">&gt; This patch was=
 adding user-space support for the dme1737 driver. You </span><br style=3D"=
font-style: italic;"><span style=3D"font-style: italic;">&gt; need to do so=
mething very similar, except for sensors-detect which you</span><br style=
=3D"font-style: italic;"><span
 style=3D"font-style: italic;">&gt; probably don't need to change.</span><b=
r style=3D"font-style: italic;"><br style=3D"font-style: italic;"><span sty=
le=3D"font-style: italic;">&gt; If you have specific questions on the way, =
feel free to ask, but all in</span><br style=3D"font-style: italic;"><span =
style=3D"font-style: italic;">&gt; all, copy and paste and a bit of trial a=
nd error should work fine.</span><br style=3D"font-style: italic;"><br styl=
e=3D"font-style: italic;"><span style=3D"font-style: italic;">&gt; Please s=
ubmit your patch when you're done, so that we can apply it and</span><br st=
yle=3D"font-style: italic;"><span style=3D"font-style: italic;">&gt; everyb=
ody benefits.</span><br style=3D"font-style: italic;"><br style=3D"font-sty=
le: italic;"><span style=3D"font-style: italic;">&gt; -- </span><br style=
=3D"font-style: italic;"><span style=3D"font-style: italic;">&gt; Jean Delv=
are</span><br><br>Thank you for your answer. I take a look at the changeset=
 for <br>the dme1737 driver, it seems that this
 is the example i was looking for.<br><br>I will try to start 'copying and =
pasting' this afternoon, <br>if it work i will submit it.<br><br>christian.=
<br></pre><p>&#32;__________________________________________________<br>Do =
You Yahoo!?<br>Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herau=
sragenden Schutz gegen Massenmails. <br>http://mail.yahoo.com=20
--0-230200421-1181890408=:43756--


--===============0391144908231601401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0391144908231601401==--
