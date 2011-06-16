From: Scott Lipcon <slipcon@gmail.com>
Date: Thu, 16 Jun 2011 03:39:03 +0000
Subject: Re: [lm-sensors] NCT6775F driver
Message-Id: <BANLkTim12g=waiNhYL0FCRVmzV8dyb0GxQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3724668034801631991=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
In-Reply-To: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3724668034801631991==
Content-Type: multipart/alternative; boundary=bcaec53f3513a5592604a5cc02d2

--bcaec53f3513a5592604a5cc02d2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, should have included that.   I think I can figure out computation
factors, if I can figure out which BIOS voltage maps to which sensors
voltage...  but since they're in different orders and there aren't the same
number of them, I'm a bit confused.



nct6775-isa-0290
Adapter: ISA adapter
VCore:         +0.90 V  (min =3D  +0.50 V, max =3D  +1.74 V)
+12V:          +1.10 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:           +1.06 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
+1.3V:         +1.06 V  (min =3D  +1.17 V, max =3D  +1.43 V)   ALARM
VSB:           +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
VBAT:          +3.38 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:          594 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan2:         1054 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan3:          629 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan4:            0 RPM  (div =3D 128)
SYSTIN:        +29.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D
diode
CPUTIN:        +29.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
PECI Agent 0:  +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
PCH_CHIP_TEMP: +45.0=B0C
PECI Agent 1:   +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
cpu0_vid:     +2.050 V


On Wed, Jun 15, 2011 at 11:07 PM, Ian Dobson <i.dobson@planet-ian.com>wrote=
:

>  Hi,
>
>  *From:* Scott Lipcon <slipcon@gmail.com>
> *Sent:* Thursday, June 16, 2011 4:18 AM
> *To:* Guenter Roeck <guenter.roeck@ericsson.com>
> *Cc:* lm-sensors@lm-sensors.org
> *Subject:* Re: [lm-sensors] NCT6775F driver
>
> OK, so I checked in BIOS, and its not clear what the right mapping is....
> this is what I had in BIOS (in order)
>
> +12V =3D 12.14V   (min =3D 11.1, max =3D 12.9 )
> +5V =3D 5.19V      (4.6 - 5.4 )
>
> +3.3V =3D 3.40V     ( 3.0 - 3.6)
>
> Memory VCC =3D 1.58  (0.4 - 2.0)
>
> Process Vcc =3D 1.15 (0.6 - 1.6)
>
> PCH Vcc =3D 1.07 (0.6 - 1.6)
>
> +3.3V Standby =3D 3.42 (3.0 - 3.6)
>
>
>
> Not sure how these (7) map to the (8) that are shown in the sensors outpu=
t
> - the orders or names don't seem to line up.
>
> Any help?
>
> Thanks,
> Scott
>
>
>
> On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck <
> guenter.roeck@ericsson.com> wrote:
>
>>  On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon wrote:
>> > Hello,
>> >
>> > I've got a new machine - Intel DP67DE motherboard, Core i5 CPU.
>> >
>> > sensors-detect shows that it has a NCT6775F chip, so I've compiled the
>> driver
>> > from http://roeck-us.net/linux/drivers/w83627ehf/  and it successfully
>> detects
>> > and provides output, although I'm doubting some of the values, and
>> wanted to
>> > see if I could help debug/test driver updates.
>> >
>> > Here's the current output:
>> >
>> >
>> >
>> >  nct6775-isa-0290
>> > Adapter: ISA adapter
>> > VCore:         +0.89 V  (min =3D  +0.50 V, max =3D  +1.74 V)
>> > +12V:         +17.54 V  (min =3D +10.75 V, max =3D +13.18 V)   ALARM
>> > AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>> > +3.3V:         +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
>> > +5V:           +4.19 V  (min =3D  +4.74 V, max =3D  +5.25 V)   ALARM
>> > +1.3V:         +1.06 V  (min =3D  +1.17 V, max =3D  +1.43 V)   ALARM
>> > VSB:           +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>> > VBAT:          +3.38 V  (min =3D  +2.40 V, max =3D  +3.60 V)
>> > fan1:          620 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
>> > fan2:         1054 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
>> > fan3:          620 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
>> > fan4:            0 RPM  (div =3D 128)
>> > SYSTIN:        +28.0 C  (high =3D  +0.0 C, hyst =3D  +0.0 C)  ALARM  s=
ensor
>> =3D diode
>> > CPUTIN:        +27.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)  sensor =
=3D diode
>> > PECI Agent 0:  +32.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)  sensor =
=3D diode
>> > PCH_CHIP_TEMP: +45.0 C
>> > PECI Agent 1:   +0.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)
>> > cpu0_vid:     +2.050 V
>> >
>> >
>> >
>> > The voltages are a bit surprising - obviously the three with ALARM are
>> out of
>> > range.  I'm not sure if I can validate these in the BIOS but I'll try
>> tonight
>> > when I'm home, but somehow I really doubt my +12V is putting out +17.5=
.
>> >
>> Agreed, that is unlikely. Most likely your sensors.conf entries,
>> specifically the
>> multiplication factors, are wrong. Try to run sensors -u to see the raw
>> output.
>>
>> > I'm not sure why the first 3 fans are showing ALARM, but the values se=
em
>> > reasonable.  The motherboard only has 3 fan connectors, so fan4 =3D 0
>> makes
>> > sense.
>> >
>> Possibly you need to repeat the command a couple of times, to make the
>> alarm go away.
>>
>> Thanks,
>> Guenter
>>
>
>  ------------------------------
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
> And what does sensos show without any calculation factors for voltages?
>
> Regards
> Ian Dobson
>
>

--bcaec53f3513a5592604a5cc02d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Sorry, should have included that. =A0 I think I can figure out computa=
tion factors, if I can figure out which BIOS voltage maps to which sensors =
voltage... =A0but since they&#39;re in different orders and there aren&#39;=
t the same number of them, I&#39;m a bit confused.</div>
<div><br></div><div><br></div><div><br></div><div>nct6775-isa-0290</div><di=
v>Adapter: ISA adapter</div><div>VCore: =A0 =A0 =A0 =A0 +0.90 V =A0(min =3D=
 =A0+0.50 V, max =3D =A0+1.74 V) =A0=A0</div><div>+12V: =A0 =A0 =A0 =A0 =A0=
+1.10 V =A0(min =3D =A0+2.04 V, max =3D =A0+2.04 V) =A0 ALARM</div>
<div>AVCC: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V) =A0=A0</div><div>+3.3V: =A0 =A0 =A0 =A0 +3.41 V =A0(min =3D =A0+3.14=
 V, max =3D =A0+3.47 V) =A0=A0</div><div>+5V: =A0 =A0 =A0 =A0 =A0 +1.06 V =
=A0(min =3D =A0+2.04 V, max =3D =A0+2.04 V) =A0 ALARM</div><div>+1.3V: =A0 =
=A0 =A0 =A0 +1.06 V =A0(min =3D =A0+1.17 V, max =3D =A0+1.43 V) =A0 ALARM</=
div>
<div>VSB: =A0 =A0 =A0 =A0 =A0 +3.42 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V) =A0=A0</div><div>VBAT: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+2.=
40 V, max =3D =A0+3.60 V) =A0=A0</div><div>fan1: =A0 =A0 =A0 =A0 =A0594 RPM=
 =A0(min =3D =A0 =A00 RPM, div =3D 32) =A0ALARM</div><div>fan2: =A0 =A0 =A0=
 =A0 1054 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32) =A0ALARM</div>
<div>fan3: =A0 =A0 =A0 =A0 =A0629 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32)=
 =A0ALARM</div><div>fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(div =3D 128)</di=
v><div>SYSTIN: =A0 =A0 =A0 =A0+29.0=B0C =A0(high =3D =A0+0.0=B0C, hyst =3D =
=A0+0.0=B0C) =A0ALARM =A0sensor =3D diode</div><div>CPUTIN: =A0 =A0 =A0 =A0=
+29.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C) =A0sensor =3D diode</=
div>
<div>PECI Agent 0: =A0+38.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
 =A0sensor =3D diode</div><div>PCH_CHIP_TEMP: +45.0=B0C =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0</div><div>PECI Agent 1=
: =A0 +0.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C) =A0</div>
<div>cpu0_vid: =A0 =A0 +2.050 V</div><div><br></div><br><div class=3D"gmail=
_quote">On Wed, Jun 15, 2011 at 11:07 PM, Ian Dobson <span dir=3D"ltr">&lt;=
<a href=3D"mailto:i.dobson@planet-ian.com">i.dobson@planet-ian.com</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">



<div style=3D"padding-left:10px;padding-right:10px;padding-top:15px" name=
=3D"Compose message area">
<div><font face=3D"Calibri">Hi,</font></div>
<div style=3D"font:10pt Tahoma">
<div><br></div>
<div style=3D"background:#f5f5f5">
<div><b>From:</b> <a title=3D"mailto:slipcon@gmail.com
STRG + Klicken, um Verkn=FCpfung zu folgen" href=3D"mailto:slipcon@gmail.co=
m" target=3D"_blank">Scott Lipcon</a> </div>
<div><b>Sent:</b> Thursday, June 16, 2011 4:18 AM</div>
<div><b>To:</b> <a title=3D"guenter.roeck@ericsson.com" href=3D"mailto:guen=
ter.roeck@ericsson.com" target=3D"_blank">Guenter Roeck</a> </div>
<div><b>Cc:</b> <a title=3D"lm-sensors@lm-sensors.org" href=3D"mailto:lm-se=
nsors@lm-sensors.org" target=3D"_blank">lm-sensors@lm-sensors.org</a> </div=
>
<div><b>Subject:</b> Re: [lm-sensors] NCT6775F driver</div></div></div><div=
><div></div><div class=3D"h5">
<div><br></div>OK, so I checked in BIOS, and its not clear what the right=
=20
mapping is.... this is what I had in BIOS (in order)=20
<div><br></div>
<div>+12V =3D 12.14V =A0 (min =3D 11.1, max =3D 12.9 )</div>
<div>+5V =3D 5.19V =A0 =A0 =A0(<span style=3D"font-family:Helvetica;font-si=
ze:12px">4.6 - 5.4=20
)</span>=20





<p>+3.3V =3D 3.40V=A0 =A0 =A0( 3.0 - 3.6)</p>
<p>Memory VCC =3D 1.58=A0 (0.4 - 2.0)</p>
<p>Process Vcc =3D 1.15 (0.6 - 1.6)</p>
<p>PCH Vcc =3D 1.07 (0.6 - 1.6)</p>
<p>+3.3V Standby =3D 3.42 (3.0 - 3.6)</p>
<div><br></div>
<div><br></div>
<div><br></div>Not sure how these (7) map to the (8) that are shown in the=
=20
sensors output - the orders or names don&#39;t seem to line up.</div>
<div><br></div>
<div>Any help?</div>
<div><br></div>
<div>Thanks,</div>
<div>Scott</div>
<div><br></div>
<div><br></div>
<div><br>
<div class=3D"gmail_quote">On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck =
<span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com" target=
=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span>=20
wrote:<br>
<blockquote style=3D"border-left:#ccc 1px solid;margin:0px 0px 0px 0.8ex;pa=
dding-left:1ex" class=3D"gmail_quote">
  <div>
  <div></div>
  <div>On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon=20
  wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I&#39;ve got a new machine - Intel =
DP67DE=20
  motherboard, Core i5 CPU.<br>&gt;<br>&gt; sensors-detect shows that it ha=
s a=20
  NCT6775F chip, so I&#39;ve compiled the driver<br>&gt; from <a href=3D"ht=
tp://roeck-us.net/linux/drivers/w83627ehf/" target=3D"_blank">http://roeck-=
us.net/linux/drivers/w83627ehf/</a> =A0and it=20
  successfully detects<br>&gt; and provides output, although I&#39;m doubti=
ng some=20
  of the values, and wanted to<br>&gt; see if I could help debug/test drive=
r=20
  updates.<br>&gt;<br>&gt; Here&#39;s the current=20
  output:<br>&gt;<br>&gt;<br>&gt;<br>&gt; =A0nct6775-isa-0290<br>&gt;=20
  Adapter: ISA adapter<br>&gt; VCore: =A0 =A0 =A0 =A0 +0.89 V=20
  =A0(min =3D =A0+0.50 V, max =3D =A0+1.74 V)<br>&gt; +12V: =A0 =A0=20
  =A0 =A0 +17.54 V =A0(min =3D +10.75 V, max =3D +13.18 V) =A0=20
  ALARM<br>&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D=20
  =A0+2.98 V, max =3D =A0+3.63 V)<br>&gt; +3.3V: =A0 =A0 =A0 =A0=20
  +3.41 V =A0(min =3D =A0+3.14 V, max =3D =A0+3.47 V)<br>&gt; +5V: =A0=20
  =A0 =A0 =A0 =A0 +4.19 V =A0(min =3D =A0+4.74 V, max =3D=20
  =A0+5.25 V) =A0 ALARM<br>&gt; +1.3V: =A0 =A0 =A0 =A0 +1.06 V=20
  =A0(min =3D =A0+1.17 V, max =3D =A0+1.43 V) =A0 ALARM<br>&gt; VSB:=20
  =A0 =A0 =A0 =A0 =A0 +3.42 V =A0(min =3D =A0+2.98 V, max =3D=20
  =A0+3.63 V)<br>&gt; VBAT: =A0 =A0 =A0 =A0 =A0+3.38 V=20
  =A0(min =3D =A0+2.40 V, max =3D =A0+3.60 V)<br>&gt; fan1: =A0 =A0=20
  =A0 =A0 =A0620 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32)=20
  =A0ALARM<br>&gt; fan2: =A0 =A0 =A0 =A0 1054 RPM =A0(min =3D=20
  =A0 =A00 RPM, div =3D 32) =A0ALARM<br>&gt; fan3: =A0 =A0 =A0=20
  =A0 =A0620 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32)=20
  =A0ALARM<br>&gt; fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM=20
  =A0(div =3D 128)<br>&gt; SYSTIN: =A0 =A0 =A0 =A0+28.0 C=20
  =A0(high =3D =A0+0.0 C, hyst =3D =A0+0.0 C) =A0ALARM =A0sensor =3D=20
  diode<br>&gt; CPUTIN: =A0 =A0 =A0 =A0+27.0 C =A0(high =3D +80.0=20
  C, hyst =3D +75.0 C) =A0sensor =3D diode<br>&gt; PECI Agent 0: =A0+32.0 C=
=20
  =A0(high =3D +80.0 C, hyst =3D +75.0 C) =A0sensor =3D diode<br>&gt;=20
  PCH_CHIP_TEMP: +45.0 C<br>&gt; PECI Agent 1: =A0 +0.0 C =A0(high =3D +80.=
0=20
  C, hyst =3D +75.0 C)<br>&gt; cpu0_vid: =A0 =A0 +2.050=20
  V<br>&gt;<br>&gt;<br>&gt;<br>&gt; The voltages are a bit surprising -=20
  obviously the three with ALARM are out of<br>&gt; range. =A0I&#39;m not s=
ure if=20
  I can validate these in the BIOS but I&#39;ll try tonight<br>&gt; when I&=
#39;m home,=20
  but somehow I really doubt my +12V is putting out=20
  +17.5.<br>&gt;<br></div></div>Agreed, that is unlikely. Most likely your=
=20
  sensors.conf entries, specifically the<br>multiplication factors, are wro=
ng.=20
  Try to run sensors -u to see the raw output.<br>
  <div><br>&gt; I&#39;m not sure why the first 3 fans are showing ALARM,=20
  but the values seem<br>&gt; reasonable. =A0The motherboard only has 3 fan=
=20
  connectors, so fan4 =3D 0 makes<br>&gt; sense.<br>&gt;<br></div>Possibly =
you=20
  need to repeat the command a couple of times, to make the alarm go=20
  away.<br><br>Thanks,<br><font color=3D"#888888">Guenter<br></font></block=
quote></div><br></div>
</div></div><p>
</p><hr>

<p></p>
<div>_______________________________________________<br>lm-sensors mailing=
=20
list<br><a href=3D"mailto:lm-sensors@lm-sensors.org" target=3D"_blank">lm-s=
ensors@lm-sensors.org</a><br><a title=3D"http://lists.lm-sensors.org/mailma=
n/listinfo/lm-sensors
STRG + Klicken, um Verkn=FCpfung zu folgen" href=3D"http://lists.lm-sensors=
.org/mailman/listinfo/lm-sensors" target=3D"_blank">http://lists.lm-sensors=
.org/mailman/listinfo/lm-sensors</a></div>
<div>=A0</div>
<div><font face=3D"Calibri">And what does sensos show without any calculati=
on=20
factors for voltages</font><font face=3D"Calibri">?</font></div>
<div><font face=3D"Calibri"></font>=A0</div>
<div><font face=3D"Calibri">Regards</font></div>
<div><font face=3D"Calibri">Ian Dobson</font></div><p></p></div>
</blockquote></div><br>

--bcaec53f3513a5592604a5cc02d2--


--===============3724668034801631991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3724668034801631991==--
