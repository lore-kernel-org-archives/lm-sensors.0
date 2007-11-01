From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Thu, 01 Nov 2007 11:27:53 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <545004.44336.qm@web25107.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1092647018866716984=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de>
In-Reply-To: <20071017195439.GD3778@stusta.de>
To: lm-sensors@vger.kernel.org

--===============1092647018866716984==
Content-Type: multipart/alternative; boundary="0-1130056255-1193916473=:44336"
Content-Transfer-Encoding: 8bit

--0-1130056255-1193916473=:44336
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

 > Hi:
>=20
> * Riku Voipio  [2007-10-26 14:14:23 +0300]:
> > On Fri, Oct 26, 2007 at 10:36:47AM +0200, Jean Delvare wrote:
> > > Patch looks correct, however it doesn't apply on top of Mark's tree. I
> > > was able to get it to apply by reverting "(f75375s) fix pwm mode
> > > setting" first, but then the build fails. Presumably the other f75375s
> > > patches interact badly. Can you please respin this patch on top of
> > > Mark's tree (i.e. on top the the 4 other f75375s patches you sent sin=
ce
> > > the -rc1 merge)? Thanks.
> >=20
> > The surrounding code had wandered to another function, so it's suprising
> > it applied at all. Here's respin.
> >=20
> > --=20
> > "rm -rf" only sounds scary if you don't have backups
>=20
> > >From 4de69e3ab5b5833cddb503f0dcb2a3ccc2d5b328 Mon Sep 17 00:00:00 > 20=
01
> > From: Riku Voipio=20
> > Date: Fri, 26 Oct 2007 13:53:50 +0300
> > Subject: [PATCH] hwmon (f75375s) fix buggy if() properly
> >=20
> >  Fix value check in set_pwm_mode(). Instead of checking for
> >  chip variant there, make pwmX_mode sysfs nodes only writable
> >  on f75375 variant.
> >=20
> > Signed-off-by: Riku Voipio=20
> > ---
> >  drivers/hwmon/f75375s.c |   19 ++++++++++++++++---
> >  1 files changed, 16 insertions(+), 3 deletions(-)
> >=20
>=20
> Applied to hwmon-2.6.git/testing, thanks.
>=20
> --=20
> Mark M. Hoffman
> mhoffman@lightlink.com

Don't know if necessary, but i tested the driver using kernel 2.6.22-14, dr=
iver from kernel/mhoffman/hwmon-2.6.git - testing (28 Oct) and sensors vers=
ion 3.0.0-rc3 with libsensors version 3.0.0-rc3.=20

Fan-Speed, temperatures and voltage is displayed correctly. I can also chan=
ge the fan speed without problem.
The only modification i made in lm-sensors, setting the value of driver to =
"f75375s" in prog/detect/sensors-detect for "Fintek F75373S/SG".

best regards
christian.
      =20
---------------------------------
Ihr erstes Fernweh? Wo gibt es den sch=F6nsten Strand.=20
--0-1130056255-1193916473=:44336
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: courier;">Hi</span><br style=3D"font-family: co=
urier;"><br style=3D"font-family: courier;"><span style=3D"font-family: cou=
rier;"> &gt; Hi:</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; </span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">&gt; * Riku Voipio  [2007-10-26 14:14:23 +=
0300]:</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt; &gt; On Fri, Oct 26, 2007 at 10:36:47AM +0200, Jean Delvar=
e wrote:</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; &gt; &gt; Patch looks correct, however it doesn't apply =
on top of Mark's tree. I</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">&gt; &gt; &gt; was able to get it to apply by=
 reverting "(f75375s) fix pwm mode</span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">&gt; &gt; &gt; setting" first, but =
then the build fails. Presumably the other
 f75375s</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; &gt; &gt; patches interact badly. Can you please respin =
this patch on top of</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; &gt; &gt; Mark's tree (i.e. on top the the =
4 other f75375s patches you sent since</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; the -rc1 merge)?=
 Thanks.</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; &gt; </span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">&gt; &gt; The surrounding code had wandered t=
o another function, so it's suprising</span><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; &gt; it applied at all. Her=
e's respin.</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">&gt; &gt; </span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">&gt; &gt; --
 </span><br style=3D"font-family: courier;"><span style=3D"font-family: cou=
rier;">&gt; &gt; "rm -rf" only sounds scary if you don't have backups</span=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
&gt; </span><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; &gt; &gt;From 4de69e3ab5b5833cddb503f0dcb2a3ccc2d5b328 Mon =
Sep 17 00:00:00 &gt; 2001</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt; &gt; From: Riku Voipio </span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; =
Date: Fri, 26 Oct 2007 13:53:50 +0300</span><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; &gt; Subject: [PATCH] hwmon=
 (f75375s) fix buggy if() properly</span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">&gt; &gt; </span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">&gt; &gt;  Fix valu=
e check in set_pwm_mode(). Instead of
 checking for</span><br style=3D"font-family: courier;"><span style=3D"font=
-family: courier;">&gt; &gt;  chip variant there, make pwmX_mode sysfs node=
s only writable</span><br style=3D"font-family: courier;"><span style=3D"fo=
nt-family: courier;">&gt; &gt;  on f75375 variant.</span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">&gt; &gt; </span><b=
r style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt=
; &gt; Signed-off-by: Riku Voipio </span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">&gt; &gt; ---</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&gt; &gt;  drive=
rs/hwmon/f75375s.c |   19 ++++++++++++++++---</span><br style=3D"font-famil=
y: courier;"><span style=3D"font-family: courier;">&gt; &gt;  1 files chang=
ed, 16 insertions(+), 3 deletions(-)</span><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">&gt; &gt; </span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family:
 courier;">&gt; </span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; Applied to hwmon-2.6.git/testing, thanks.</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
gt; </span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">&gt; -- </span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt; Mark M. Hoffman</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">&gt; mhoffman@lightlink.c=
om</span><br><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">Don't know if necessary, but i tested the driver using kernel 2=
.6.22-14, driver from kernel/mhoffman/hwmon-2.6.git - testing (28 Oct) and =
sensors version 3.0.0-rc3 with libsensors version 3.0.0-rc3. <br><br style=
=3D"font-family: courier;"></span><span style=3D"font-family: courier;">Fan=
-Speed, temperatures and voltage is displayed correctly. I can also change =
the fan speed without problem.</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">The =
only modification i made in lm-sensors, setting the value of driver to "f75=
375s" in prog/detect/sensors-detect for "Fintek F75373S/SG".</span><br styl=
e=3D"font-family: courier;"><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">best regards<br>christian.</span><p>&#32;
      <hr size=3D1><a href=3D"http://de.rd.yahoo.com/evt=3D48734/*http://de=
.answers.yahoo.com/dir/;_ylc=3DX3oDMTEzY2IyNmI0BF9TAzIxMTQ3MTgzMjIEc2VjA01h=
aWwEc2xrA3RhZ2xpbmVz?link=3Dlist&sid=3D396545469" target=3D_new
><b>Ihr erstes Fernweh?</b> Wo gibt es den sch=F6nsten Strand. </a>
--0-1130056255-1193916473=:44336--


--===============1092647018866716984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1092647018866716984==--
