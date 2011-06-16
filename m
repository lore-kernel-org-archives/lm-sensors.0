From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Thu, 16 Jun 2011 03:07:06 +0000
Subject: Re: [lm-sensors] NCT6775F driver
Message-Id: <F0100CF5828A420390610C87D12CC314@portable2>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5913836170521034448=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
In-Reply-To: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
To: lm-sensors@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.

--===============5913836170521034448==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0046_01CC2BE3.3D0155D0"

Dies ist eine mehrteilige Nachricht im MIME-Format.

------=_NextPart_000_0046_01CC2BE3.3D0155D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


From: Scott Lipcon=20
Sent: Thursday, June 16, 2011 4:18 AM
To: Guenter Roeck=20
Cc: lm-sensors@lm-sensors.org=20
Subject: Re: [lm-sensors] NCT6775F driver


OK, so I checked in BIOS, and its not clear what the right mapping =
is.... this is what I had in BIOS (in order)=20


+12V =3D 12.14V   (min =3D 11.1, max =3D 12.9 )
+5V =3D 5.19V      (4.6 - 5.4 )=20
+3.3V =3D 3.40V     ( 3.0 - 3.6)

Memory VCC =3D 1.58  (0.4 - 2.0)

Process Vcc =3D 1.15 (0.6 - 1.6)

PCH Vcc =3D 1.07 (0.6 - 1.6)

+3.3V Standby =3D 3.42 (3.0 - 3.6)







Not sure how these (7) map to the (8) that are shown in the sensors =
output - the orders or names don't seem to line up.


Any help?


Thanks,
Scott






On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck =
<guenter.roeck@ericsson.com> wrote:

  On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon wrote:
  > Hello,
  >
  > I've got a new machine - Intel DP67DE motherboard, Core i5 CPU.
  >
  > sensors-detect shows that it has a NCT6775F chip, so I've compiled =
the driver
  > from http://roeck-us.net/linux/drivers/w83627ehf/  and it =
successfully detects
  > and provides output, although I'm doubting some of the values, and =
wanted to
  > see if I could help debug/test driver updates.
  >
  > Here's the current output:
  >
  >
  >
  >  nct6775-isa-0290
  > Adapter: ISA adapter
  > VCore:         +0.89 V  (min =3D  +0.50 V, max =3D  +1.74 V)
  > +12V:         +17.54 V  (min =3D +10.75 V, max =3D +13.18 V)   ALARM
  > AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
  > +3.3V:         +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
  > +5V:           +4.19 V  (min =3D  +4.74 V, max =3D  +5.25 V)   ALARM
  > +1.3V:         +1.06 V  (min =3D  +1.17 V, max =3D  +1.43 V)   ALARM
  > VSB:           +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
  > VBAT:          +3.38 V  (min =3D  +2.40 V, max =3D  +3.60 V)
  > fan1:          620 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
  > fan2:         1054 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
  > fan3:          620 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
  > fan4:            0 RPM  (div =3D 128)
  > SYSTIN:        +28.0 C  (high =3D  +0.0 C, hyst =3D  +0.0 C)  ALARM  =
sensor =3D diode
  > CPUTIN:        +27.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)  sensor =
=3D diode
  > PECI Agent 0:  +32.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)  sensor =
=3D diode
  > PCH_CHIP_TEMP: +45.0 C
  > PECI Agent 1:   +0.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)
  > cpu0_vid:     +2.050 V
  >
  >
  >
  > The voltages are a bit surprising - obviously the three with ALARM =
are out of
  > range.  I'm not sure if I can validate these in the BIOS but I'll =
try tonight
  > when I'm home, but somehow I really doubt my +12V is putting out =
+17.5.
  >

  Agreed, that is unlikely. Most likely your sensors.conf entries, =
specifically the
  multiplication factors, are wrong. Try to run sensors -u to see the =
raw output.


  > I'm not sure why the first 3 fans are showing ALARM, but the values =
seem
  > reasonable.  The motherboard only has 3 fan connectors, so fan4 =3D =
0 makes
  > sense.
  >

  Possibly you need to repeat the command a couple of times, to make the =
alarm go away.

  Thanks,
  Guenter





-------------------------------------------------------------------------=
-------


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

And what does sensos show without any calculation factors for voltages?

Regards
Ian Dobson
------=_NextPart_000_0046_01CC2BE3.3D0155D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META content=3Dtext/html;charset=3Diso-8859-1 =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 9.00.8112.16430"></HEAD>
<BODY style=3D"PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: =
15px"=20
id=3DMailContainerBody leftMargin=3D0 topMargin=3D0 =
CanvasTabStop=3D"true"=20
name=3D"Compose message area">
<DIV><FONT face=3DCalibri>Hi,</FONT></DIV>
<DIV style=3D"FONT: 10pt Tahoma">
<DIV><BR></DIV>
<DIV style=3D"BACKGROUND: #f5f5f5">
<DIV style=3D"font-color: black"><B>From:</B> <A=20
title=3D"mailto:slipcon@gmail.com&#10;STRG + Klicken, um Verkn=FCpfung =
zu folgen"=20
href=3D"mailto:slipcon@gmail.com">Scott Lipcon</A> </DIV>
<DIV><B>Sent:</B> Thursday, June 16, 2011 4:18 AM</DIV>
<DIV><B>To:</B> <A title=3Dguenter.roeck@ericsson.com=20
href=3D"mailto:guenter.roeck@ericsson.com">Guenter Roeck</A> </DIV>
<DIV><B>Cc:</B> <A title=3Dlm-sensors@lm-sensors.org=20
href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</A> =
</DIV>
<DIV><B>Subject:</B> Re: [lm-sensors] NCT6775F driver</DIV></DIV></DIV>
<DIV><BR></DIV>OK, so I checked in BIOS, and its not clear what the =
right=20
mapping is.... this is what I had in BIOS (in order)=20
<DIV><BR></DIV>
<DIV>+12V =3D 12.14V &nbsp; (min =3D 11.1, max =3D 12.9 )</DIV>
<DIV>+5V =3D 5.19V &nbsp; &nbsp; &nbsp;(<SPAN=20
style=3D"FONT-FAMILY: Helvetica; FONT-SIZE: 12px" =
class=3DApple-style-span>4.6 - 5.4=20
)</SPAN>=20
<META content=3Dtext/css http-equiv=3DContent-Style-Type>
<META name=3DGenerator content=3D"Cocoa HTML Writer">
<META name=3DCocoaVersion content=3D1038.35>
<STYLE type=3Dtext/css>
p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica}
</STYLE>

<P class=3Dp1>+3.3V =3D 3.40V&nbsp; &nbsp; &nbsp;( 3.0 - 3.6)</P>
<P class=3Dp1>Memory VCC =3D 1.58&nbsp; (0.4 - 2.0)</P>
<P class=3Dp1>Process Vcc =3D 1.15 (0.6 - 1.6)</P>
<P class=3Dp1>PCH Vcc =3D 1.07 (0.6 - 1.6)</P>
<P class=3Dp1>+3.3V Standby =3D 3.42 (3.0 - 3.6)</P>
<DIV><BR></DIV>
<DIV><BR></DIV>
<DIV><BR></DIV>Not sure how these (7) map to the (8) that are shown in =
the=20
sensors output - the orders or names don't seem to line up.</DIV>
<DIV><BR></DIV>
<DIV>Any help?</DIV>
<DIV><BR></DIV>
<DIV>Thanks,</DIV>
<DIV>Scott</DIV>
<DIV><BR></DIV>
<DIV><BR></DIV>
<DIV><BR>
<DIV class=3Dgmail_quote>On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck =
<SPAN=20
dir=3Dltr>&lt;<A=20
href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.com</A>=
&gt;</SPAN>=20
wrote:<BR>
<BLOCKQUOTE=20
style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex; =
PADDING-LEFT: 1ex"=20
class=3Dgmail_quote>
  <DIV>
  <DIV></DIV>
  <DIV class=3Dh5>On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon =

  wrote:<BR>&gt; Hello,<BR>&gt;<BR>&gt; I've got a new machine - Intel =
DP67DE=20
  motherboard, Core i5 CPU.<BR>&gt;<BR>&gt; sensors-detect shows that it =
has a=20
  NCT6775F chip, so I've compiled the driver<BR>&gt; from <A=20
  href=3D"http://roeck-us.net/linux/drivers/w83627ehf/"=20
  target=3D_blank>http://roeck-us.net/linux/drivers/w83627ehf/</A> =
&nbsp;and it=20
  successfully detects<BR>&gt; and provides output, although I'm =
doubting some=20
  of the values, and wanted to<BR>&gt; see if I could help debug/test =
driver=20
  updates.<BR>&gt;<BR>&gt; Here's the current=20
  output:<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; &nbsp;nct6775-isa-0290<BR>&gt; =

  Adapter: ISA adapter<BR>&gt; VCore: &nbsp; &nbsp; &nbsp; &nbsp; +0.89 =
V=20
  &nbsp;(min =3D &nbsp;+0.50 V, max =3D &nbsp;+1.74 V)<BR>&gt; +12V: =
&nbsp; &nbsp;=20
  &nbsp; &nbsp; +17.54 V &nbsp;(min =3D +10.75 V, max =3D +13.18 V) =
&nbsp;=20
  ALARM<BR>&gt; AVCC: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+3.41 V =
&nbsp;(min =3D=20
  &nbsp;+2.98 V, max =3D &nbsp;+3.63 V)<BR>&gt; +3.3V: &nbsp; &nbsp; =
&nbsp; &nbsp;=20
  +3.41 V &nbsp;(min =3D &nbsp;+3.14 V, max =3D &nbsp;+3.47 V)<BR>&gt; =
+5V: &nbsp;=20
  &nbsp; &nbsp; &nbsp; &nbsp; +4.19 V &nbsp;(min =3D &nbsp;+4.74 V, max =
=3D=20
  &nbsp;+5.25 V) &nbsp; ALARM<BR>&gt; +1.3V: &nbsp; &nbsp; &nbsp; &nbsp; =
+1.06 V=20
  &nbsp;(min =3D &nbsp;+1.17 V, max =3D &nbsp;+1.43 V) &nbsp; =
ALARM<BR>&gt; VSB:=20
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; +3.42 V &nbsp;(min =3D &nbsp;+2.98 =
V, max =3D=20
  &nbsp;+3.63 V)<BR>&gt; VBAT: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+3.38 V =

  &nbsp;(min =3D &nbsp;+2.40 V, max =3D &nbsp;+3.60 V)<BR>&gt; fan1: =
&nbsp; &nbsp;=20
  &nbsp; &nbsp; &nbsp;620 RPM &nbsp;(min =3D &nbsp; &nbsp;0 RPM, div =3D =
32)=20
  &nbsp;ALARM<BR>&gt; fan2: &nbsp; &nbsp; &nbsp; &nbsp; 1054 RPM =
&nbsp;(min =3D=20
  &nbsp; &nbsp;0 RPM, div =3D 32) &nbsp;ALARM<BR>&gt; fan3: &nbsp; =
&nbsp; &nbsp;=20
  &nbsp; &nbsp;620 RPM &nbsp;(min =3D &nbsp; &nbsp;0 RPM, div =3D 32)=20
  &nbsp;ALARM<BR>&gt; fan4: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 =
RPM=20
  &nbsp;(div =3D 128)<BR>&gt; SYSTIN: &nbsp; &nbsp; &nbsp; &nbsp;+28.0 C =

  &nbsp;(high =3D &nbsp;+0.0 C, hyst =3D &nbsp;+0.0 C) &nbsp;ALARM =
&nbsp;sensor =3D=20
  diode<BR>&gt; CPUTIN: &nbsp; &nbsp; &nbsp; &nbsp;+27.0 C &nbsp;(high =
=3D +80.0=20
  C, hyst =3D +75.0 C) &nbsp;sensor =3D diode<BR>&gt; PECI Agent 0: =
&nbsp;+32.0 C=20
  &nbsp;(high =3D +80.0 C, hyst =3D +75.0 C) &nbsp;sensor =3D =
diode<BR>&gt;=20
  PCH_CHIP_TEMP: +45.0 C<BR>&gt; PECI Agent 1: &nbsp; +0.0 C &nbsp;(high =
=3D +80.0=20
  C, hyst =3D +75.0 C)<BR>&gt; cpu0_vid: &nbsp; &nbsp; +2.050=20
  V<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; The voltages are a bit surprising -=20
  obviously the three with ALARM are out of<BR>&gt; range. &nbsp;I'm not =
sure if=20
  I can validate these in the BIOS but I'll try tonight<BR>&gt; when I'm =
home,=20
  but somehow I really doubt my +12V is putting out=20
  +17.5.<BR>&gt;<BR></DIV></DIV>Agreed, that is unlikely. Most likely =
your=20
  sensors.conf entries, specifically the<BR>multiplication factors, are =
wrong.=20
  Try to run sensors -u to see the raw output.<BR>
  <DIV class=3Dim><BR>&gt; I'm not sure why the first 3 fans are showing =
ALARM,=20
  but the values seem<BR>&gt; reasonable. &nbsp;The motherboard only has =
3 fan=20
  connectors, so fan4 =3D 0 makes<BR>&gt; =
sense.<BR>&gt;<BR></DIV>Possibly you=20
  need to repeat the command a couple of times, to make the alarm go=20
  away.<BR><BR>Thanks,<BR><FONT=20
color=3D#888888>Guenter<BR></FONT></BLOCKQUOTE></DIV><BR></DIV>
<P>
<HR>

<P></P>
<DIV>_______________________________________________<BR>lm-sensors =
mailing=20
list<BR>lm-sensors@lm-sensors.org<BR><A=20
title=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors&#10;STRG=
 + Klicken, um Verkn=FCpfung zu folgen"=20
href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://l=
ists.lm-sensors.org/mailman/listinfo/lm-sensors</A></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DCalibri>And what does sensos show without any =
calculation=20
factors for voltages</FONT><FONT face=3DCalibri>?</FONT></DIV>
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>
<DIV><FONT face=3DCalibri>Regards</FONT></DIV>
<DIV><FONT face=3DCalibri>Ian Dobson</FONT></DIV></BODY></HTML>

------=_NextPart_000_0046_01CC2BE3.3D0155D0--



--===============5913836170521034448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5913836170521034448==--

