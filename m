From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sat, 21 Apr 2012 15:04:52 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iL4teBZv5P6_qRoX5OyUy7M6hgTqB444=OgvYON2FY_wA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1367354162320544938=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1367354162320544938==
Content-Type: multipart/alternative; boundary=14dae93408f723174804be31ba84

--14dae93408f723174804be31ba84
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> On Sat, Apr 21, 2012 at 05:38:54AM -0400, Martin Suchanek wrote:
> > I have had in mind CPUTIN which is showing in lm-sensors -60 Celsius.
> > (  it is all described more detailed in my previous posts.)
> > Just small info :-)
> >
> I understand, but since the chip supports variable sensor mapping it woul=
d
> help
> to know the other readings in comparison.
>

Other readings is correct - differencing by max one/two degrees Celsius
depend on measuring frequency. Only CPUTIN has always minus 60 Celsius
(from the May 2011 when I have installed linux with lm-sensors). I compared
those values in windows 7 64 bit by AI Suite with BIOS monitor if you meant
something like this. Or if you have some particular interest -  some other
comparisons - let me know I can do it.


>
>
> > On Fri, Apr 20, 2012 at 4:22 PM, Guenter Roeck <
> guenter.roeck@ericsson.com>
> > wrote:
> >
> >     On Fri, 2012-04-20 at 06:47 -0400, Martin Suchanek wrote:
> >     > Hi,
> >     >
> >     > Add info:
> >     > I have found software called open hardware monitor. I have been
> >     > testing it in windows for couple of days and it works properly wi=
th
> >     > Nuvoton NST6776F chip. I have been comparing results with AI Suit=
e
> >     > software coming from ASUS and results are corresponding and
> measuring
> >     > is with big precise. So , you can have a look to source code and
> >     > compare with your driver. This software should work on linux as
> well
> >     > but I did not try it yet but I will.
> >     >
> >     > (I did not tried your experimental driver yet but I will)
> >     >
> >     Martin,
> >
> >     please don't top-post.
> >
> >     What is the output you get with open hardware monitor ? They report
> four
> >     temperatures, PECI_0, CPUTIN, AUXTIN, and SYSTIN.
> >
> >     Thanks,
> >     Guenter
> >
> >     > Regards,
> >     > Martin
> >     >
> >     >
> >     > On Sat, Apr 14, 2012 at 2:09 PM, Martin Suchanek
> >     > <martin.suc@googlemail.com> wrote:
> >     >         Hi,
> >     >
> >     >         I have found for long time ago that CPUTIN temperature is
> not
> >     >         showed correctly by sensors command:
> >     >
> >     >         coretemp-isa-0000
> >     >         Adapter: ISA adapter
> >     >         Physical id 0:  +34.0=C2=B0C  (high =3D +80.0=C2=B0C, cri=
t =3D +98.0=C2=B0C)
> >     >         Core 0:         +30.0=C2=B0C  (high =3D +80.0=C2=B0C, cri=
t =3D +98.0=C2=B0C)
> >     >         ...
> >     >         nct6776-isa-0290
> >     >         Adapter: ISA adapter
> >     >         ...
> >     >         CPUTIN:        -60.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst=
 =3D +75.0=C2=B0C)
> >     >         sensor =3D diode
> >     >         ...
> >     >
> >     >         I have cheked it in BIOS and in AI Suite in windows 7 64
> bit
> >     >         and consulted it with ASUS technical support and
> everything is
> >     >         working properly.
> >     >         So , hardware is fine. Software in windows is fine. Only
> linux
> >     >         software is not correct.
> >     >         I have tried to detect-sensor many times and it is still
> the
> >     >         same.
> >     >         If there is some kind of tweak in config please let me kn=
ow
> >     >         but it seems to me there is something wrong with lm-senso=
rs
> >     >         3.3.1.
> >     >
> >     >         ...
> >     >         Intel digital thermal sensor...
> >     >         Success!
> >     >             (driver `coretemp')
> >     >         ...
> >     >         Found `Nuvoton NCT6776F Super IO Sensors'
> >     >         Success!
> >     >         ...
> >     >         Driver `w83627ehf':
> >     >           * ISA bus, address 0x290
> >     >             Chip `Nuvoton NCT6776F Super IO Sensors' (confidence:
> 9)
> >     >
> >     >         Driver `coretemp':
> >     >           * Chip `Intel digital thermal sensor' (confidence: 9)
> >     >         ...
> >     >
> >     >         my /etc/modules:
> >     >         ...
> >     >         coretemp
> >     >         w83627ehf
> >     >         ...
> >     >
> >     >         This error have appeared on maximus iv extreme motherboar=
d
> >     >         Revision 3 , BIOS from 1404 to 3202 (latest)
> >     >         linux ubuntu natty -> oneiric 64 bit kernel from 2.6.39 u=
p
> to
> >     >         3.0.0-19 commercial version (tested on 3.3.1 compiled by
> me)
> >     >
> >     >         Could you please help me to solve it ?
> >     >
> >     >         Thank you very much for any clue.
> >     >         Kind Regards,
> >     >         Martin
> >     >
> >     >
> >
> >
> >
> >
>
On Sat, Apr 21, 2012 at 3:49 PM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

--14dae93408f723174804be31ba84
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div class=3D"im">On Sat, Apr 21, 2012 at =
05:38:54AM -0400, Martin Suchanek wrote:<br>

&gt; I have had in mind CPUTIN which is showing in lm-sensors -60 Celsius.<=
br>
&gt; (=C2=A0 it is all described more detailed in my previous posts.)<br>
&gt; Just small info :-)<br>
&gt;<br>
</div>I understand, but since the chip supports variable sensor mapping it =
would help<br>
to know the other readings in comparison.<br></blockquote><div>=C2=A0</div>=
<div>Other readings is correct - differencing by max one/two degrees Celsiu=
s depend on measuring frequency. Only=20
CPUTIN has always minus 60 Celsius (from the May 2011 when I have installed=
 linux=20
with lm-sensors). I compared those values in windows 7 64 bit by AI Suite=
=20
with BIOS monitor if you meant something like this. Or if you have some par=
ticular interest -=C2=A0 some other comparisons - let me know I can do it.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>

<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Fri, Apr 20, 2012 at 4:22 PM, Guenter Roeck &lt;<a href=3D"mailto:g=
uenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 On Fri, 2012-04-20 at 06:47 -0400, Martin Suchanek wrote=
:<br>
&gt; =C2=A0 =C2=A0 &gt; Hi,<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; Add info:<br>
&gt; =C2=A0 =C2=A0 &gt; I have found software called open hardware monitor.=
 I have been<br>
&gt; =C2=A0 =C2=A0 &gt; testing it in windows for couple of days and it wor=
ks properly with<br>
&gt; =C2=A0 =C2=A0 &gt; Nuvoton NST6776F chip. I have been comparing result=
s with AI Suite<br>
&gt; =C2=A0 =C2=A0 &gt; software coming from ASUS and results are correspon=
ding and measuring<br>
&gt; =C2=A0 =C2=A0 &gt; is with big precise. So , you can have a look to so=
urce code and<br>
&gt; =C2=A0 =C2=A0 &gt; compare with your driver. This software should work=
 on linux as well<br>
&gt; =C2=A0 =C2=A0 &gt; but I did not try it yet but I will.<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; (I did not tried your experimental driver yet but I=
 will)<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 Martin,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 please don&#39;t top-post.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 What is the output you get with open hardware monitor ? =
They report four<br>
&gt; =C2=A0 =C2=A0 temperatures, PECI_0, CPUTIN, AUXTIN, and SYSTIN.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Thanks,<br>
&gt; =C2=A0 =C2=A0 Guenter<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; Regards,<br>
&gt; =C2=A0 =C2=A0 &gt; Martin<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; On Sat, Apr 14, 2012 at 2:09 PM, Martin Suchanek<br=
>
&gt; =C2=A0 =C2=A0 &gt; &lt;<a href=3D"mailto:martin.suc@googlemail.com">ma=
rtin.suc@googlemail.com</a>&gt; wrote:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have found for long t=
ime ago that CPUTIN temperature is not<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 showed correctly by sen=
sors command:<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 coretemp-isa-0000<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Adapter: ISA adapter<br=
>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Physical id 0: =C2=A0+3=
4.0=C2=B0C =C2=A0(high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C)<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Core 0: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +30.0=C2=B0C =C2=A0(high =3D +80.0=C2=B0C, crit =3D +98.0=C2=
=B0C)<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 nct6776-isa-0290<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Adapter: ISA adapter<br=
>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUTIN: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-60.0=C2=B0C =C2=A0(high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 sensor =3D diode<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have cheked it in BIO=
S and in AI Suite in windows 7 64 bit<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and consulted it with A=
SUS technical support and everything is<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 working properly.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 So , hardware is fine. =
Software in windows is fine. Only linux<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 software is not correct=
.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have tried to detect-=
sensor many times and it is still the<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 same.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 If there is some kind o=
f tweak in config please let me know<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 but it seems to me ther=
e is something wrong with lm-sensors<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.3.1.<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Intel digital thermal s=
ensor...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (driver `=
coretemp&#39;)<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Found `Nuvoton NCT6776F=
 Super IO Sensors&#39;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Driver `w83627ehf&#39;:=
<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ISA bus, addre=
ss 0x290<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Chip `Nuv=
oton NCT6776F Super IO Sensors&#39; (confidence: 9)<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Driver `coretemp&#39;:<=
br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Chip `Intel di=
gital thermal sensor&#39; (confidence: 9)<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 my /etc/modules:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 coretemp<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 w83627ehf<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 This error have appeare=
d on maximus iv extreme motherboard<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Revision 3 , BIOS from =
1404 to 3202 (latest)<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux ubuntu natty -&gt=
; oneiric 64 bit kernel from 2.6.39 up to<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.0.0-19 commercial ver=
sion (tested on 3.3.1 compiled by me)<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Could you please help m=
e to solve it ?<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thank you very much for=
 any clue.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kind Regards,<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Martin<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div>On Sat, Apr 21, 2012 at 3:49 PM, Guenter Roe=
ck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com" targ=
et=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br><br></div=
>

--14dae93408f723174804be31ba84--


--===============1367354162320544938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1367354162320544938==--
