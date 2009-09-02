From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 02 Sep 2009 23:07:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: include <linux/io.h> instead of
Message-Id: <cfe85dfa0909021607k76b4993dgb8b901f88ecad64e@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7025094968712845748=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BD79186B4FD85F4B8E60E381CAEE190901BE9DA3@mi8nycmail19.Mi8.com>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901BE9DA3@mi8nycmail19.Mi8.com>
To: lm-sensors@vger.kernel.org

--===============7025094968712845748==
Content-Type: multipart/alternative; boundary=00504502d2f688bf230472a0558b

--00504502d2f688bf230472a0558b
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Sep 2, 2009 at 7:04 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 13 Aug 2009 16:56:56 -0400, H Hartley Sweeten wrote:
> > Drivers should be including <linux/io.h> instead of <asm/io.h>.
> >
> > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Alistair John Strachan <alistair@devzero.co.uk>
> > Cc: Nicolas Boichat <nicolas@boichat.ch>
> > Cc: Juerg Haefliger <juergh@gmail.com>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Cc: Frank Seidel <frank@f-seidel.de>
> > Cc: Jim Cromie <jim.cromie@gmail.com>
> > Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> > Cc: Roger Lucas <vt8231@hiddenengine.co.uk>
>
> Applied, thanks.
>
>

Hi Jean, etal

wheres the tree ?
I checked at git.kernel.org, didnt find /hwmon/

I found this googling, it looks old. (july last year iirc)
http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=summary


Also, wrt ack, I withheld it, cuz I hadnt gotten around to
looking for it in a single tree (or to see whether it was already)

Since I never compiled it, ack'g seemed a bit overstating
what a glance told me; that it looked sensible, and based on other work.

What would you have liked to hear from me in this case ?

tia
jimc



> --
> Jean Delvare
>

--00504502d2f688bf230472a0558b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Sep 2, 2009 at 7:04 AM, Jean Del=
vare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linu=
x-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div class=3D"im">On Thu, 13 Aug 2009 16:56:56 -0400, H Hartley Sweeten wro=
te:<br>
&gt; Drivers should be including &lt;linux/io.h&gt; instead of &lt;asm/io.h=
&gt;.<br>
&gt;<br>
&gt; Signed-off-by: H Hartley Sweeten &lt;<a href=3D"mailto:hsweeten@vision=
engravers.com">hsweeten@visionengravers.com</a>&gt;<br>
&gt; Cc: Alistair John Strachan &lt;<a href=3D"mailto:alistair@devzero.co.u=
k">alistair@devzero.co.uk</a>&gt;<br>
&gt; Cc: Nicolas Boichat &lt;<a href=3D"mailto:nicolas@boichat.ch">nicolas@=
boichat.ch</a>&gt;<br>
&gt; Cc: Juerg Haefliger &lt;<a href=3D"mailto:juergh@gmail.com">juergh@gma=
il.com</a>&gt;<br>
&gt; Cc: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux=
-fr.org</a>&gt;<br>
&gt; Cc: Frank Seidel &lt;<a href=3D"mailto:frank@f-seidel.de">frank@f-seid=
el.de</a>&gt;<br>
&gt; Cc: Jim Cromie &lt;<a href=3D"mailto:jim.cromie@gmail.com">jim.cromie@=
gmail.com</a>&gt;<br>
&gt; Cc: &quot;Mark M. Hoffman&quot; &lt;<a href=3D"mailto:mhoffman@lightli=
nk.com">mhoffman@lightlink.com</a>&gt;<br>
&gt; Cc: Roger Lucas &lt;<a href=3D"mailto:vt8231@hiddenengine.co.uk">vt823=
1@hiddenengine.co.uk</a>&gt;<br>
<br>
</div>Applied, thanks.<br>
<br></blockquote><div><br><br>Hi Jean, etal<br><br>wheres the tree ?=A0 <br=
>I checked at <a href=3D"http://git.kernel.org">git.kernel.org</a>, didnt f=
ind /hwmon/<br><br>I found this googling, it looks old. (july last year iir=
c)<br>
<a href=3D"http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=
=3Dsummary">http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;=
a=3Dsummary</a><br><br><br>Also, wrt ack, I withheld it, cuz I hadnt gotten=
 around to <br>
looking for it in a single tree (or to see whether it was already)<br><br>S=
ince I never compiled it, ack&#39;g seemed a bit overstating<br>what a glan=
ce told me; that it looked sensible, and based on other work.<br><br>What w=
ould you have liked to hear from me in this case ?<br>
<br>tia<br>jimc<br><br>=A0</div><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>

--00504502d2f688bf230472a0558b--


--===============7025094968712845748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7025094968712845748==--
