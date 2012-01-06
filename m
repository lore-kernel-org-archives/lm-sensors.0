From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Fri, 06 Jan 2012 07:32:43 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: fix trailing whitespace
Message-Id: <CACW_hTa72vOP_F=N454LMNrZ=VzcXY=qss+T_JpSFFtji72XWw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5098995642665895138=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============5098995642665895138==
Content-Type: multipart/alternative; boundary=bcaec50165edee411104b5d70d7d

--bcaec50165edee411104b5d70d7d
Content-Type: text/plain; charset=ISO-8859-1

2012/1/6 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Thu, Jan 05, 2012 at 04:23:56PM -0500, Frans Meulenbroeks wrote:
> > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> > ---
> >  drivers/hwmon/adm1025.c   |    2 +-
> >  drivers/hwmon/ds1621.c    |    6 +++---
> >  drivers/hwmon/g760a.c     |    2 +-
> >  drivers/hwmon/hwmon-vid.c |    2 +-
> >  drivers/hwmon/lm78.c      |   10 +++++-----
> >  drivers/hwmon/lm83.c      |    2 +-
> >  drivers/hwmon/max1619.c   |    2 +-
> >  drivers/hwmon/sis5595.c   |    4 ++--
> >  drivers/hwmon/smsc47m1.c  |    2 +-
> >  drivers/hwmon/w83627hf.c  |    2 +-
> >  drivers/hwmon/w83l785ts.c |    2 +-
> >  11 files changed, 18 insertions(+), 18 deletions(-)
> >
> Your other patches are fine, but this one has checkpatch errors and
> warnings:
>
> ERROR: code indent should use tabs where possible
> #793: FILE: drivers/hwmon/hwmon-vid.c:122:
> +^I^I                       1850 - val * 25;$
>
> ERROR: code indent should use tabs where possible
> #812: FILE: drivers/hwmon/hwmon-vid.c:137:
> +^I^I                     2050 - (val) * 50;$
>
> WARNING: please, no spaces at the start of a line
> #1276: FILE: drivers/hwmon/ds1621.c:6:
> +    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with$
>
> WARNING: please, no spaces at the start of a line
> #1300: FILE: drivers/hwmon/g760a.c:8:
> +      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf$
>
> total: 2 errors, 2 warnings, 607 lines checked
>
> NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
>      scripts/cleanfile
>
> While those were already there in the original files, it doesn't really
> help much
> to only remove the spaces at the end of the line. And newly submitted
> patches should
> not have any checkpatch errors or warnings.
>
> I enqueued the other patches for one of the rc candidates.
>
> Thanks,
> Guenter
>

Guenter,

Thanks for your reply.

Probably i should explain a little bit on my way of working.
For me the most efficient way to tackle this is to only fix one error type
at a time.
This reduces the chance of mistakes (like mixing up simple_strtoul and
strict_strtoul), and also makes doing the edits simpler.
However the side effect of this is that not all problems in a file are
solved.

(btw I also peeked at cleanfile, but for some reason it won't work for me.
Probably something at my side).

Best regards, Frans

PS: note that I don't own most of the hardware, so i cannot really run-time
verify my work, only do a compile-test.

--bcaec50165edee411104b5d70d7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/6 Guenter Roeck <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.c=
om</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div class=3D"im"><br>
On Thu, Jan 05, 2012 at 04:23:56PM -0500, Frans Meulenbroeks wrote:<br>
&gt; Signed-off-by: Frans Meulenbroeks &lt;<a href=3D"mailto:fransmeulenbro=
eks@gmail.com">fransmeulenbroeks@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/hwmon/adm1025.c =A0 | =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/ds1621.c =A0 =A0| =A0 =A06 +++---<br>
&gt; =A0drivers/hwmon/g760a.c =A0 =A0 | =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/hwmon-vid.c | =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/lm78.c =A0 =A0 =A0| =A0 10 +++++-----<br>
&gt; =A0drivers/hwmon/lm83.c =A0 =A0 =A0| =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/max1619.c =A0 | =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/sis5595.c =A0 | =A0 =A04 ++--<br>
&gt; =A0drivers/hwmon/smsc47m1.c =A0| =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/w83627hf.c =A0| =A0 =A02 +-<br>
&gt; =A0drivers/hwmon/w83l785ts.c | =A0 =A02 +-<br>
&gt; =A011 files changed, 18 insertions(+), 18 deletions(-)<br>
&gt;<br>
</div>Your other patches are fine, but this one has checkpatch errors and w=
arnings:<br>
<br>
ERROR: code indent should use tabs where possible<br>
#793: FILE: drivers/hwmon/hwmon-vid.c:122:<br>
+^I^I =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1850 - val * 25;$<br>
<br>
ERROR: code indent should use tabs where possible<br>
#812: FILE: drivers/hwmon/hwmon-vid.c:137:<br>
+^I^I =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2050 - (val) * 50;$<br>
<br>
WARNING: please, no spaces at the start of a line<br>
#1276: FILE: drivers/hwmon/ds1621.c:6:<br>
+ =A0 =A0Ported to Linux 2.6 by Aurelien Jarno &lt;<a href=3D"mailto:aureli=
en@aurel32.net">aurelien@aurel32.net</a>&gt; with$<br>
<br>
WARNING: please, no spaces at the start of a line<br>
#1300: FILE: drivers/hwmon/g760a.c:8:<br>
+ =A0 =A0 =A0<a href=3D"http://www.gmt.com.tw/product/datasheet/EDS-760A.pd=
f$" target=3D"_blank">http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf$=
</a><br>
<br>
total: 2 errors, 2 warnings, 607 lines checked<br>
<br>
NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or=
<br>
 =A0 =A0 =A0scripts/cleanfile<br>
<br>
While those were already there in the original files, it doesn&#39;t really=
 help much<br>
to only remove the spaces at the end of the line. And newly submitted patch=
es should<br>
not have any checkpatch errors or warnings.<br>
<br>
I enqueued the other patches for one of the rc candidates.<br>
<br>
Thanks,<br>
Guenter<br></blockquote><div><br>Guenter,<br><br>Thanks for your reply.<br>=
<br>Probably i should explain a little bit on my way of working.<br>For me =
the most efficient way to tackle this is to only fix one error type at a ti=
me. <br>
This reduces the chance of mistakes (like mixing up simple_strtoul and stri=
ct_strtoul), and also makes doing the edits simpler.<br>However the side ef=
fect of this is that not all problems in a file are solved.<br><br>(btw I a=
lso peeked at cleanfile, but for some reason it won&#39;t work for me. Prob=
ably something at my side).<br>
<br>Best regards, Frans<br></div></div><br>PS: note that I don&#39;t own mo=
st of the hardware, so i cannot really run-time verify my work, only do a c=
ompile-test.<br>

--bcaec50165edee411104b5d70d7d--


--===============5098995642665895138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5098995642665895138==--
