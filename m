From: Andrew Krueger <jaidormi@gmail.com>
Date: Mon, 16 May 2011 16:44:51 +0000
Subject: Re: [lm-sensors] Feature request: smsc47b397 (SCH5307-NS)
Message-Id: <BANLkTi=7T-VTNJ3oz_V4Ky4yW3QX7X_Y=g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5389937064255193054=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTi=+PGMPhMWz9vQA3v90vBRFvrnnYg@mail.gmail.com>
In-Reply-To: <BANLkTi=+PGMPhMWz9vQA3v90vBRFvrnnYg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5389937064255193054==
Content-Type: multipart/alternative; boundary=0015175df130d870ab04a3675ffe

--0015175df130d870ab04a3675ffe
Content-Type: text/plain; charset=ISO-8859-1

Hi Juerg,

> That would certainly help. I'll ask my contact at SMSC.

Thanks so much for offering to ask someone from SMSC.  What a help.

> Which model is this?

The model is xw6400.  It's a workstation with Intel 5000X chipset.

> What makes you think it should? Is this feature mentioned somewhere in
> the doc of the server? If it's handled by the BIOS, then there
> usuallly are some controls in the BIOS. Never heard of a machine that
> does automatic fan control without providing some knobs through the
> BIOS. If your BIOS doesn't have any, it's unlikely, that there is HW
> supported fan control.

Yes, it is mentioned in the docs and the advertising copy.  From their
QuickSpecs doc:
http://h18000.www1.hp.com/products/quickspecs/12505_na/12505_na.pdf
Adaptive Cooling : Fan control parameters are set according to detected
hardware configuration for optimal acoustics

The only BIOS settings available are 5 or 6 discrete settings for fan idle
RPM of the case fans.  These don't seem to change under load either.
I guess I don't know conclusively that there should be BIOS control for
real-time fan speed changes.  Although it seems odd since I believe the SMSC
chip supports it.  I have owned numerous laptops that changed their CPU fan
speeds depending on heat, independent of the OS/drivers.  I have a
recollection of numerous Intel desktop boards doing the same thing.

Perhaps I am mixing fact and fantasy here.

Although I should note, the CPU fans are PWM controlled (I can remove the
control pin and they jump from 1400RPM to ~5000), yet I have seen no BIOS
setting that affects this nor a Windows driver that affects it.  No CPU load
or temperature setting seems to make a difference either.  The fan idle
speed setting in the BIOS does not change the CPU fan speed.  Then why have
PWM control on them at all?  Something seems amiss.

Thanks for your help,
Andrew


On Mon, May 16, 2011 at 3:58 AM, Juerg Haefliger <juergh@gmail.com> wrote:

> Hi Andrew,
>
>
> > Could someone please tell me what it would take to gain PWM control via
> this
> > chip?  A proper data sheet from SMSC?
>
> That would certainly help. I'll ask my contact at SMSC.
>
>
> > Are there other techniques I could
> > try or that others have worked on?
> >
> > The chip is used in my HP workstation and seems not to adapt fan RPM to
> CPU
> > temperatures, whatsoever.
>
> Which model is this?
>
>
> > My understanding is that this should be done
> > automatically at the BIOS/chip level, but it is not.
>
> What makes you think it should? Is this feature mentioned somewhere in
> the doc of the server? If it's handled by the BIOS, then there
> usuallly are some controls in the BIOS. Never heard of a machine that
> does automatic fan control without providing some knobs through the
> BIOS. If your BIOS doesn't have any, it's unlikely, that there is HW
> supported fan control.
>
> ...Juerg
>
>
> > Thus my search for a
> > driver + userspace solution.
> >
> > Thanks,
> > Andrew
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>

--0015175df130d870ab04a3675ffe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Juerg,<br><br>&gt; That would certainly help. I&#39;ll ask my contact at=
 SMSC.<br><br>Thanks so much for offering to ask someone from SMSC.=A0 What=
 a help.<br><br>&gt; Which model is this?<br><br>The model is xw6400.=A0 It=
&#39;s a workstation with Intel 5000X chipset.<br>
<br>
&gt; What makes you think it should? Is this feature mentioned somewhere in=
<br>
&gt; the doc of the server? If it&#39;s handled by the BIOS, then there<br>=
&gt; usuallly are some controls in the BIOS. Never heard of a machine that<=
br>
&gt; does automatic fan control without providing some knobs through the<br=
>&gt; BIOS. If your BIOS doesn&#39;t have any, it&#39;s unlikely, that ther=
e is HW<br>
&gt; supported fan control.<br><br>Yes, it is mentioned in the docs and the=
 advertising copy.=A0 From their QuickSpecs doc:<br><a href=3D"http://h1800=
0.www1.hp.com/products/quickspecs/12505_na/12505_na.pdf">http://h18000.www1=
.hp.com/products/quickspecs/12505_na/12505_na.pdf</a><br>
Adaptive Cooling : Fan control parameters are set according to detected har=
dware configuration for optimal acoustics<br><br>The only BIOS settings ava=
ilable are 5 or 6 discrete settings for fan idle RPM of the case fans.=A0 T=
hese don&#39;t seem to change under load either.<br>
I guess I don&#39;t know conclusively that there should be BIOS control for=
 real-time fan speed changes.=A0 Although it seems odd since I believe the =
SMSC chip supports it.=A0 I have owned numerous laptops that changed their =
CPU fan speeds depending on heat, independent of the OS/drivers.=A0 I have =
a recollection of numerous Intel desktop boards doing the same thing.<br>
<br>Perhaps I am mixing fact and fantasy here.<br><br>Although I should not=
e, the CPU fans are PWM controlled (I can remove the control pin and they j=
ump from 1400RPM to ~5000), yet I have seen no BIOS setting that affects th=
is nor a Windows driver that affects it.=A0 No CPU load or temperature sett=
ing seems to make a difference either.=A0 The fan idle speed setting in the=
 BIOS does not change the CPU fan speed.=A0 Then why have PWM control on th=
em at all?=A0 Something seems amiss.<br>
<br>Thanks for your help,<br>Andrew<br><br><br><div class=3D"gmail_quote">O=
n Mon, May 16, 2011 at 3:58 AM, Juerg Haefliger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:juergh@gmail.com" target=3D"_blank">juergh@gmail.com</a>&gt;</=
span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Andrew,<br>
<div><br>
<br>
&gt; Could someone please tell me what it would take to gain PWM control vi=
a this<br>
&gt; chip?=A0 A proper data sheet from SMSC?<br>
<br>
</div>That would certainly help. I&#39;ll ask my contact at SMSC.<br>
<div><br>
<br>
&gt; Are there other techniques I could<br>
&gt; try or that others have worked on?<br>
&gt;<br>
&gt; The chip is used in my HP workstation and seems not to adapt fan RPM t=
o CPU<br>
&gt; temperatures, whatsoever.<br>
<br>
</div>Which model is this?<br>
<div><br>
<br>
&gt; My understanding is that this should be done<br>
&gt; automatically at the BIOS/chip level, but it is not.<br>
<br>
</div>What makes you think it should? Is this feature mentioned somewhere i=
n<br>
the doc of the server? If it&#39;s handled by the BIOS, then there<br>
usuallly are some controls in the BIOS. Never heard of a machine that<br>
does automatic fan control without providing some knobs through the<br>
BIOS. If your BIOS doesn&#39;t have any, it&#39;s unlikely, that there is H=
W<br>
supported fan control.<br>
<br>
...Juerg<br>
<div><br>
<br>
&gt; Thus my search for a<br>
&gt; driver + userspace solution.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Andrew<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; lm-sensors mailing list<br>
&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org" target=3D"_blank">lm-sens=
ors@lm-sensors.org</a><br>
&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" ta=
rget=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>=
<br>
&gt;<br>
</blockquote></div><br>

--0015175df130d870ab04a3675ffe--


--===============5389937064255193054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5389937064255193054==--
