From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sat, 21 Apr 2012 09:38:54 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iKY-gsUoNXp9qYAZfqfFp2ZSm0qKRCgJCK=Cu8zgq0pWw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3667943444986686170=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3667943444986686170==
Content-Type: multipart/alternative; boundary=14dae93404f766195804be2d2c55

--14dae93404f766195804be2d2c55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have had in mind CPUTIN which is showing in lm-sensors -60 Celsius.
(  it is all described more detailed in my previous posts.)
Just small info :-)

On Fri, Apr 20, 2012 at 4:22 PM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Fri, 2012-04-20 at 06:47 -0400, Martin Suchanek wrote:
> > Hi,
> >
> > Add info:
> > I have found software called open hardware monitor. I have been
> > testing it in windows for couple of days and it works properly with
> > Nuvoton NST6776F chip. I have been comparing results with AI Suite
> > software coming from ASUS and results are corresponding and measuring
> > is with big precise. So , you can have a look to source code and
> > compare with your driver. This software should work on linux as well
> > but I did not try it yet but I will.
> >
> > (I did not tried your experimental driver yet but I will)
> >
> Martin,
>
> please don't top-post.
>
> What is the output you get with open hardware monitor ? They report four
> temperatures, PECI_0, CPUTIN, AUXTIN, and SYSTIN.
>
> Thanks,
> Guenter
>
> > Regards,
> > Martin
> >
> >
> > On Sat, Apr 14, 2012 at 2:09 PM, Martin Suchanek
> > <martin.suc@googlemail.com> wrote:
> >         Hi,
> >
> >         I have found for long time ago that CPUTIN temperature is not
> >         showed correctly by sensors command:
> >
> >         coretemp-isa-0000
> >         Adapter: ISA adapter
> >         Physical id 0:  +34.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D =
+98.0=C2=B0C)
> >         Core 0:         +30.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D =
+98.0=C2=B0C)
> >         ...
> >         nct6776-isa-0290
> >         Adapter: ISA adapter
> >         ...
> >         CPUTIN:        -60.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +=
75.0=C2=B0C)
> >         sensor =3D diode
> >         ...
> >
> >         I have cheked it in BIOS and in AI Suite in windows 7 64 bit
> >         and consulted it with ASUS technical support and everything is
> >         working properly.
> >         So , hardware is fine. Software in windows is fine. Only linux
> >         software is not correct.
> >         I have tried to detect-sensor many times and it is still the
> >         same.
> >         If there is some kind of tweak in config please let me know
> >         but it seems to me there is something wrong with lm-sensors
> >         3.3.1.
> >
> >         ...
> >         Intel digital thermal sensor...
> >         Success!
> >             (driver `coretemp')
> >         ...
> >         Found `Nuvoton NCT6776F Super IO Sensors'
> >         Success!
> >         ...
> >         Driver `w83627ehf':
> >           * ISA bus, address 0x290
> >             Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
> >
> >         Driver `coretemp':
> >           * Chip `Intel digital thermal sensor' (confidence: 9)
> >         ...
> >
> >         my /etc/modules:
> >         ...
> >         coretemp
> >         w83627ehf
> >         ...
> >
> >         This error have appeared on maximus iv extreme motherboard
> >         Revision 3 , BIOS from 1404 to 3202 (latest)
> >         linux ubuntu natty -> oneiric 64 bit kernel from 2.6.39 up to
> >         3.0.0-19 commercial version (tested on 3.3.1 compiled by me)
> >
> >         Could you please help me to solve it ?
> >
> >         Thank you very much for any clue.
> >         Kind Regards,
> >         Martin
> >
> >
>
>
>

--14dae93404f766195804be2d2c55
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">I have had in mind CPUTIN which is showing in lm=
-sensors -60 Celsius.<br>(=C2=A0 it is all described more detailed in my pr=
evious posts.)<br>Just small info :-)<br><br><div class=3D"gmail_quote">On =
Fri, Apr 20, 2012 at 4:22 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=
=3D"mailto:guenter.roeck@ericsson.com" target=3D"_blank">guenter.roeck@eric=
sson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, 2012-04-20 at 06:4=
7 -0400, Martin Suchanek wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Add info:<br>
&gt; I have found software called open hardware monitor. I have been<br>
&gt; testing it in windows for couple of days and it works properly with<br=
>
&gt; Nuvoton NST6776F chip. I have been comparing results with AI Suite<br>
&gt; software coming from ASUS and results are corresponding and measuring<=
br>
&gt; is with big precise. So , you can have a look to source code and<br>
&gt; compare with your driver. This software should work on linux as well<b=
r>
&gt; but I did not try it yet but I will.<br>
&gt;<br>
&gt; (I did not tried your experimental driver yet but I will)<br>
&gt;<br>
</div>Martin,<br>
<br>
please don&#39;t top-post.<br>
<br>
What is the output you get with open hardware monitor ? They report four<br=
>
temperatures, PECI_0, CPUTIN, AUXTIN, and SYSTIN.<br>
<br>
Thanks,<br>
Guenter<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Regards,<br>
&gt; Martin<br>
&gt;<br>
&gt;<br>
&gt; On Sat, Apr 14, 2012 at 2:09 PM, Martin Suchanek<br>
&gt; &lt;<a href=3D"mailto:martin.suc@googlemail.com">martin.suc@googlemail=
.com</a>&gt; wrote:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have found for long time ago that CPUTIN=
 temperature is not<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 showed correctly by sensors command:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 coretemp-isa-0000<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Adapter: ISA adapter<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Physical id 0: =C2=A0+34.0=C2=B0C =C2=A0(h=
igh =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Core 0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +30.0=
=C2=B0C =C2=A0(high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 nct6776-isa-0290<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Adapter: ISA adapter<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUTIN: =C2=A0 =C2=A0 =C2=A0 =C2=A0-60.0=
=C2=B0C =C2=A0(high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 sensor =3D diode<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have cheked it in BIOS and in AI Suite i=
n windows 7 64 bit<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and consulted it with ASUS technical suppo=
rt and everything is<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 working properly.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 So , hardware is fine. Software in windows=
 is fine. Only linux<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 software is not correct.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have tried to detect-sensor many times a=
nd it is still the<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 same.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 If there is some kind of tweak in config p=
lease let me know<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 but it seems to me there is something wron=
g with lm-sensors<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.3.1.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Intel digital thermal sensor...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (driver `coretemp&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Found `Nuvoton NCT6776F Super IO Sensors&#=
39;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Driver `w83627ehf&#39;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ISA bus, address 0x290<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Chip `Nuvoton NCT6776F Super=
 IO Sensors&#39; (confidence: 9)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Driver `coretemp&#39;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Chip `Intel digital thermal senso=
r&#39; (confidence: 9)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 my /etc/modules:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 coretemp<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 w83627ehf<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 This error have appeared on maximus iv ext=
reme motherboard<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Revision 3 , BIOS from 1404 to 3202 (lates=
t)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux ubuntu natty -&gt; oneiric 64 bit ke=
rnel from 2.6.39 up to<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.0.0-19 commercial version (tested on 3.3=
.1 compiled by me)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Could you please help me to solve it ?<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thank you very much for any clue.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kind Regards,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Martin<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br></div>

--14dae93404f766195804be2d2c55--


--===============3667943444986686170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3667943444986686170==--
