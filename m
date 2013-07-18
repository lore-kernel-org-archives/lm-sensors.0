From: =?ISO-8859-1?Q?Simon_Sandstr=F6m?= <gurka@acc.umu.se>
Date: Thu, 18 Jul 2013 13:38:01 +0000
Subject: Re: [lm-sensors] Module asus_atk0110 - Fan speed often shows zero instead of correct value
Message-Id: <CA+1DPT1eVW+7_o0=-zhta8AgOkEZ5uN2qk0sKm1hm+WaJvR_-A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5784072566672559446=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
In-Reply-To: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5784072566672559446==
Content-Type: multipart/alternative; boundary=089e0115f112a6a95004e1c951d7

--089e0115f112a6a95004e1c951d7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2013/7/18 Jean Delvare <khali@linux-fr.org>

> On Thu, 18 Jul 2013 15:00:23 +0200, Simon Sandstr=F6m wrote:
> > 2013/7/18 Jean Delvare <khali@linux-fr.org>
> > > Also, the asus_atk0110 driver heavily relies on the BIOS, so a BIOS
> > > update may help.
> >
> > Asus P5K Premium. I'm pretty sure it has the latest BIOS version (can't
> > check now, see below).
>
> You can check the BIOS version of a running system, just read it
> from /sys/class/dmi/id/bios_version. Then compare with what Asus's
> website says is the latest.
>

Oh, I didn't know that. I have version 1101, which is the latest according
to their website.

>
> > I tried using the option new_if=3D1 and it just
> > screwed up all readings. For example it now shows 1.54V for all voltage=
s,
> > 1500~RPM for all fans and 150=B0C for both CPU and MB, which is way off=
.
>
> OK, forget about it then.
>
> > > (...)
> > > For 3-pin fans, speed measurement is easy and reliable when the fan
> > > runs at full speed. However as soon as control is applied, measuremen=
t
> > > becomes harder. This is true when PWM control is used, but even more
> > > when DC control is used: the speed signal weakens as the voltage is
> > > lowered, and after some point it's difficult for the monitoring chip =
to
> > > distinguish between the speed signal and the noise.
> > >
> > > So maybe your fan is spinning at the border between readable and
> > > unreadable.
> >
> > Yes, I have fan control enabled both for CPU and chassi fans. I can not
> > disable it at the moment as the server is running some services which
> needs
> > to be up. CPU is set to automatic and the chassi fans is set to run at
> 70%
> > duty. Both chassi fans are the same model, but only one of them is givi=
ng
> > strange readings with lm-sensors. So I don't think there is a problem
> > because of the speed control.
>
> Keep in mind that the signal/noise ratio is somewhat model-specific and
> even varies from one fan sample to the next.


I tried switching the two fans. Same readings as before: fan2_input showed
700 RPM and fan3_input showed 0 RPM (occasionally 700 RPM). So there seems
to be a problem with the actual motherboard (or, less likely, the
asus_atk0110 module)? I have not tried disabling the speed control in BIOS
yet though.

On another note, how come they set the minimum fan speed for chassi fan 3
(fan4_input) to 800 RPM while the other two chassi fans has a lower limit
of 600 RPM? As I understand, this limit is set by the hardware and can not
be changed?

>


> > I will try to disable the fan control and also try to switch the
> > connectionof the two chassi fans to see if I can come up with anything.
>
> Yes, good idea.
>
> --
> Jean Delvare
>

--089e0115f112a6a95004e1c951d7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
2013/7/18 Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-=
fr.org" target=3D"_blank">khali@linux-fr.org</a>&gt;</span><br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex">
On Thu, 18 Jul 2013 15:00:23 +0200, Simon Sandstr=F6m wrote:<br>
<div class=3D"im">&gt; 2013/7/18 Jean Delvare &lt;<a href=3D"mailto:khali@l=
inux-fr.org">khali@linux-fr.org</a>&gt;<br>
&gt; &gt; Also, the asus_atk0110 driver heavily relies on the BIOS, so a BI=
OS<br>
&gt; &gt; update may help.<br>
&gt;<br>
&gt; Asus P5K Premium. I&#39;m pretty sure it has the latest BIOS version (=
can&#39;t<br>
&gt; check now, see below).<br>
<br>
</div>You can check the BIOS version of a running system, just read it<br>
from /sys/class/dmi/id/bios_version. Then compare with what Asus&#39;s<br>
website says is the latest.<br></blockquote><div><br></div><div>Oh, I didn&=
#39;t know that. I have version 1101, which is the latest according to thei=
r website.=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border=
-left-style:solid;padding-left:1ex">

<div class=3D"im"><br>
&gt; I tried using the option new_if=3D1 and it just<br>
&gt; screwed up all readings. For example it now shows 1.54V for all voltag=
es,<br>
&gt; 1500~RPM for all fans and 150=B0C for both CPU and MB, which is way of=
f.<br>
<br>
</div>OK, forget about it then.<br>
<br>
&gt; &gt; (...)<br>
<div class=3D"im">&gt; &gt; For 3-pin fans, speed measurement is easy and r=
eliable when the fan<br>
&gt; &gt; runs at full speed. However as soon as control is applied, measur=
ement<br>
&gt; &gt; becomes harder. This is true when PWM control is used, but even m=
ore<br>
&gt; &gt; when DC control is used: the speed signal weakens as the voltage =
is<br>
&gt; &gt; lowered, and after some point it&#39;s difficult for the monitori=
ng chip to<br>
&gt; &gt; distinguish between the speed signal and the noise.<br>
&gt; &gt;<br>
&gt; &gt; So maybe your fan is spinning at the border between readable and<=
br>
&gt; &gt; unreadable.<br>
&gt;<br>
&gt; Yes, I have fan control enabled both for CPU and chassi fans. I can no=
t<br>
&gt; disable it at the moment as the server is running some services which =
needs<br>
&gt; to be up. CPU is set to automatic and the chassi fans is set to run at=
 70%<br>
&gt; duty. Both chassi fans are the same model, but only one of them is giv=
ing<br>
&gt; strange readings with lm-sensors. So I don&#39;t think there is a prob=
lem<br>
&gt; because of the speed control.<br>
<br>
</div>Keep in mind that the signal/noise ratio is somewhat model-specific a=
nd<br>
even varies from one fan sample to the next.</blockquote><div><br></div><di=
v>I tried switching the two fans. Same readings as before: fan2_input showe=
d 700 RPM and fan3_input showed 0 RPM (occasionally 700 RPM). So there seem=
s to be a problem with the actual motherboard (or, less likely, the asus_at=
k0110 module)? I have not tried disabling the speed control in BIOS yet tho=
ugh.</div>
<div><br></div><div>On another note, how come they set the minimum fan spee=
d for chassi fan 3 (fan4_input) to 800 RPM while the other two chassi fans =
has a lower limit of 600 RPM? As I understand, this limit is set by the har=
dware and can not be changed?</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">=A0</blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex">

<div class=3D"im"><br>
&gt; I will try to disable the fan control and also try to switch the<br>
&gt; connectionof the two chassi fans to see if I can come up with anything=
.<br>
<br>
</div>Yes, good idea.<br>
<span class=3D""><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div></div>

--089e0115f112a6a95004e1c951d7--


--===============5784072566672559446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5784072566672559446==--
