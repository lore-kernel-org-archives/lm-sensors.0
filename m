From: Scott Lipcon <slipcon@gmail.com>
Date: Thu, 16 Jun 2011 02:18:44 +0000
Subject: Re: [lm-sensors] NCT6775F driver
Message-Id: <BANLkTin+mQ-fnEF_XKiNWN_2z=Swe9myXQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6092714081640585397=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
In-Reply-To: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6092714081640585397==
Content-Type: multipart/alternative; boundary=bcaec53f351373ab8704a5cae374

--bcaec53f351373ab8704a5cae374
Content-Type: text/plain; charset=ISO-8859-1

OK, so I checked in BIOS, and its not clear what the right mapping is....
this is what I had in BIOS (in order)

+12V = 12.14V   (min = 11.1, max = 12.9 )
+5V = 5.19V      (4.6 - 5.4 )

+3.3V = 3.40V     ( 3.0 - 3.6)

Memory VCC = 1.58  (0.4 - 2.0)

Process Vcc = 1.15 (0.6 - 1.6)

PCH Vcc = 1.07 (0.6 - 1.6)

+3.3V Standby = 3.42 (3.0 - 3.6)



Not sure how these (7) map to the (8) that are shown in the sensors output -
the orders or names don't seem to line up.

Any help?

Thanks,
Scott



On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon wrote:
> > Hello,
> >
> > I've got a new machine - Intel DP67DE motherboard, Core i5 CPU.
> >
> > sensors-detect shows that it has a NCT6775F chip, so I've compiled the
> driver
> > from http://roeck-us.net/linux/drivers/w83627ehf/  and it successfully
> detects
> > and provides output, although I'm doubting some of the values, and wanted
> to
> > see if I could help debug/test driver updates.
> >
> > Here's the current output:
> >
> >
> >
> >  nct6775-isa-0290
> > Adapter: ISA adapter
> > VCore:         +0.89 V  (min =  +0.50 V, max =  +1.74 V)
> > +12V:         +17.54 V  (min = +10.75 V, max = +13.18 V)   ALARM
> > AVCC:          +3.41 V  (min =  +2.98 V, max =  +3.63 V)
> > +3.3V:         +3.41 V  (min =  +3.14 V, max =  +3.47 V)
> > +5V:           +4.19 V  (min =  +4.74 V, max =  +5.25 V)   ALARM
> > +1.3V:         +1.06 V  (min =  +1.17 V, max =  +1.43 V)   ALARM
> > VSB:           +3.42 V  (min =  +2.98 V, max =  +3.63 V)
> > VBAT:          +3.38 V  (min =  +2.40 V, max =  +3.60 V)
> > fan1:          620 RPM  (min =    0 RPM, div = 32)  ALARM
> > fan2:         1054 RPM  (min =    0 RPM, div = 32)  ALARM
> > fan3:          620 RPM  (min =    0 RPM, div = 32)  ALARM
> > fan4:            0 RPM  (div = 128)
> > SYSTIN:        +28.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor =
> diode
> > CPUTIN:        +27.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> > PECI Agent 0:  +32.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> > PCH_CHIP_TEMP: +45.0 C
> > PECI Agent 1:   +0.0 C  (high = +80.0 C, hyst = +75.0 C)
> > cpu0_vid:     +2.050 V
> >
> >
> >
> > The voltages are a bit surprising - obviously the three with ALARM are
> out of
> > range.  I'm not sure if I can validate these in the BIOS but I'll try
> tonight
> > when I'm home, but somehow I really doubt my +12V is putting out +17.5.
> >
> Agreed, that is unlikely. Most likely your sensors.conf entries,
> specifically the
> multiplication factors, are wrong. Try to run sensors -u to see the raw
> output.
>
> > I'm not sure why the first 3 fans are showing ALARM, but the values seem
> > reasonable.  The motherboard only has 3 fan connectors, so fan4 = 0 makes
> > sense.
> >
> Possibly you need to repeat the command a couple of times, to make the
> alarm go away.
>
> Thanks,
> Guenter
>

--bcaec53f351373ab8704a5cae374
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

OK, so I checked in BIOS, and its not clear what the right mapping is.... t=
his is what I had in BIOS (in order)<div><br></div><div>+12V =3D 12.14V =A0=
 (min =3D 11.1, max =3D 12.9 )</div><div>+5V =3D 5.19V =A0 =A0 =A0(<span cl=
ass=3D"Apple-style-span" style=3D"font-family: Helvetica; font-size: 12px; =
">4.6 - 5.4 )</span><meta http-equiv=3D"Content-Type" content=3D"text/html;=
 charset=3DUTF-8"><meta http-equiv=3D"Content-Style-Type" content=3D"text/c=
ss"><title>
</title><meta name=3D"Generator" content=3D"Cocoa HTML Writer"><meta name=
=3D"CocoaVersion" content=3D"1038.35"><style type=3D"text/css">
p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica}
</style>
<p class=3D"p1">+3.3V =3D 3.40V=A0 =A0 =A0( 3.0 - 3.6)</p>
<p class=3D"p1">Memory VCC =3D 1.58=A0 (0.4 - 2.0)</p>
<p class=3D"p1">Process Vcc =3D 1.15 (0.6 - 1.6)</p>
<p class=3D"p1">PCH Vcc =3D 1.07 (0.6 - 1.6)</p>
<p class=3D"p1">+3.3V Standby =3D 3.42 (3.0 - 3.6)</p><div><br></div><div><=
br></div><div><br></div>Not sure how these (7) map to the (8) that are show=
n in the sensors output - the orders or names don&#39;t seem to line up.</d=
iv>
<div><br></div><div>Any help?</div><div><br></div><div>Thanks,</div><div>Sc=
ott</div><div><br></div><div><br></div><div><br><div class=3D"gmail_quote">=
On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Wed, J=
un 15, 2011 at 09:01:20AM -0400, Scott Lipcon wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;ve got a new machine - Intel DP67DE motherboard, Core i5 CPU.<br=
>
&gt;<br>
&gt; sensors-detect shows that it has a NCT6775F chip, so I&#39;ve compiled=
 the driver<br>
&gt; from <a href=3D"http://roeck-us.net/linux/drivers/w83627ehf/" target=
=3D"_blank">http://roeck-us.net/linux/drivers/w83627ehf/</a> =A0and it succ=
essfully detects<br>
&gt; and provides output, although I&#39;m doubting some of the values, and=
 wanted to<br>
&gt; see if I could help debug/test driver updates.<br>
&gt;<br>
&gt; Here&#39;s the current output:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0nct6775-isa-0290<br>
&gt; Adapter: ISA adapter<br>
&gt; VCore: =A0 =A0 =A0 =A0 +0.89 V =A0(min =3D =A0+0.50 V, max =3D =A0+1.7=
4 V)<br>
&gt; +12V: =A0 =A0 =A0 =A0 +17.54 V =A0(min =3D +10.75 V, max =3D +13.18 V)=
 =A0 ALARM<br>
&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; +3.3V: =A0 =A0 =A0 =A0 +3.41 V =A0(min =3D =A0+3.14 V, max =3D =A0+3.4=
7 V)<br>
&gt; +5V: =A0 =A0 =A0 =A0 =A0 +4.19 V =A0(min =3D =A0+4.74 V, max =3D =A0+5=
.25 V) =A0 ALARM<br>
&gt; +1.3V: =A0 =A0 =A0 =A0 +1.06 V =A0(min =3D =A0+1.17 V, max =3D =A0+1.4=
3 V) =A0 ALARM<br>
&gt; VSB: =A0 =A0 =A0 =A0 =A0 +3.42 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; VBAT: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+2.40 V, max =3D =A0+3=
.60 V)<br>
&gt; fan1: =A0 =A0 =A0 =A0 =A0620 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32)=
 =A0ALARM<br>
&gt; fan2: =A0 =A0 =A0 =A0 1054 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32) =
=A0ALARM<br>
&gt; fan3: =A0 =A0 =A0 =A0 =A0620 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32)=
 =A0ALARM<br>
&gt; fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(div =3D 128)<br>
&gt; SYSTIN: =A0 =A0 =A0 =A0+28.0 C =A0(high =3D =A0+0.0 C, hyst =3D =A0+0.=
0 C) =A0ALARM =A0sensor =3D diode<br>
&gt; CPUTIN: =A0 =A0 =A0 =A0+27.0 C =A0(high =3D +80.0 C, hyst =3D +75.0 C)=
 =A0sensor =3D diode<br>
&gt; PECI Agent 0: =A0+32.0 C =A0(high =3D +80.0 C, hyst =3D +75.0 C) =A0se=
nsor =3D diode<br>
&gt; PCH_CHIP_TEMP: +45.0 C<br>
&gt; PECI Agent 1: =A0 +0.0 C =A0(high =3D +80.0 C, hyst =3D +75.0 C)<br>
&gt; cpu0_vid: =A0 =A0 +2.050 V<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; The voltages are a bit surprising - obviously the three with ALARM are=
 out of<br>
&gt; range. =A0I&#39;m not sure if I can validate these in the BIOS but I&#=
39;ll try tonight<br>
&gt; when I&#39;m home, but somehow I really doubt my +12V is putting out +=
17.5.<br>
&gt;<br>
</div></div>Agreed, that is unlikely. Most likely your sensors.conf entries=
, specifically the<br>
multiplication factors, are wrong. Try to run sensors -u to see the raw out=
put.<br>
<div class=3D"im"><br>
&gt; I&#39;m not sure why the first 3 fans are showing ALARM, but the value=
s seem<br>
&gt; reasonable. =A0The motherboard only has 3 fan connectors, so fan4 =3D =
0 makes<br>
&gt; sense.<br>
&gt;<br>
</div>Possibly you need to repeat the command a couple of times, to make th=
e alarm go away.<br>
<br>
Thanks,<br>
<font color=3D"#888888">Guenter<br>
</font></blockquote></div><br></div>

--bcaec53f351373ab8704a5cae374--


--===============6092714081640585397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6092714081640585397==--
