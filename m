From: "Anian Wurzenberger" <a.wurzenberger@transact-gmbh.de>
Date: Tue, 05 Jun 2007 08:38:37 +0000
Subject: Re: [lm-sensors] Negative Values on many Systems
Message-Id: <46653D2D.55AF.0080.0@transactgmbh.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7995413316104469998=="
List-Id: <lm-sensors.vger.kernel.org>
References: <466445BA.5030002@transact-gmbh.de>
In-Reply-To: <466445BA.5030002@transact-gmbh.de>
To: lm-sensors@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--===============7995413316104469998==
Content-Type: multipart/alternative; boundary="=__Part7750591D.0__="

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part7750591D.0__=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.transact-gmbh.de
	id l558cvpB023532

Hi,
this is what I get on one system (Fedora5, kernel 2.6.15-1.2054 in this
case, but we use different versions of Fedora on other systems with the
same/similar problem) with sensors version 2.9.2 with libsensors version
2.9.2. (unfortunately I can=C2=B4t find out what kind of board it is righ=
t
now (can=C2=B4t reboot or take it out of the rack), but it=C2=B4s some se=
rver
board with an Intel chipset):
=20
w83627hf-isa-0290
Adapter: ISA adapter
[...]
temp1:       +32 =C2=B0C  (high =3D   +50=C3=82=C2=B0C, hyst =3D   +45=C3=
=82=C2=B0C)   sensor =3D
thermistor  =20
temp2:     -48.0 =C2=B0C  (high =3D   +85=C3=82=C2=B0C, hyst =3D   +80=C3=
=82=C2=B0C)   sensor =3D
thermistor  =20
temp3:     +29.0 =C2=B0C  (high =3D   +85=C3=82=C2=B0C, hyst =3D   +80=C3=
=82=C2=B0C)   sensor =3D
thermistor
[...]
=20
Changing the sensor-types brings different values, but no useful ones.
Also, the value doesn=C2=B4t change over time, I always get -48.0 =C2=B0C=
 with the
thermistor setting.
If sensors logs into /var/log/messages, then there=C2=B4s no entry.
I would have posted more info in the first post, but I thought (and
still think) this is a case of "no sensor attached", just wanted to make
sure.
=20
Thanks
Anian


>>> "Juerg Haefliger" <juergh@gmail.com> 06/04/07 7:52 pm >>>
Anian,

Some more details would be really helpful. It's impossible to answer
"It doesn't work, what's wrong?" kind of questions.

What kernel? What system/motherboard/hwmon chip? What version of
sensors? Logs? Ouputs?

...juerg


On 6/4/07, Anian Wurzenberger <a.wurzenberger@transact-gmbh.de> wrote:
> Hi List-Members,
> I=CC=81m installing lm_sensors on some of our systems right now. On two
of
> them I get a degree-value of -48,0=C2=B0C respectively -48,5=C2=B0C. Ch=
anging
of
> the sensor-types doesn=CC=81t seem to help.
> I supoose this means that the sensor-ports just aren=CC=81t in use, am =
I
> right? (I=CC=81m just asking because I seem to be missing the CPU-temp,
or
> it=CC=81s just very low (31=C2=B0C on an Intel 1800, 32=C2=B0C on Intel=
 3000) ).
>
> Thank you guys
> Anian W.
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org=20
> http://lists.lm ( http://lists.lm/
)-sensors.org/mailman/listinfo/lm-sensors

--=__Part7750591D.0__=
Content-Type: text/html; charset=UTF-8
Content-Description: HTML
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-15=
">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma">
<DIV>Hi,<BR></DIV>
<DIV>this is what I get on&nbsp;one&nbsp;system (Fedora5, kernel 2.6.15-1.2=
054&nbsp;in this case, but we use different versions of Fedora on other =
systems with the same/similar problem) with sensors version 2.9.2 with =
libsensors version 2.9.2. (unfortunately I can?t find out what kind of =
board it is right now (can?t reboot or take it out of the rack), but it?s =
some server board with an Intel chipset):</DIV>
<DIV>&nbsp;</DIV>
<DIV>w83627hf-isa-0290<BR>Adapter: ISA adapter<BR>[...]</DIV>
<DIV>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +32 =B0C&nbsp; (high =
=3D&nbsp;&nbsp; +50=C2=B0C, hyst =3D&nbsp;&nbsp; +45=C2=B0C)&nbsp;&nbsp; =
sensor =3D thermistor&nbsp;&nbsp; <BR>temp2:&nbsp;&nbsp;&nbsp;&nbsp; -48.0 =
=B0C&nbsp; (high =3D&nbsp;&nbsp; +85=C2=B0C, hyst =3D&nbsp;&nbsp; =
+80=C2=B0C)&nbsp;&nbsp; sensor =3D thermistor&nbsp;&nbsp; <BR>temp3:&nbsp;&=
nbsp;&nbsp;&nbsp; +29.0 =B0C&nbsp; (high =3D&nbsp;&nbsp; +85=C2=B0C, hyst =
=3D&nbsp;&nbsp; +80=C2=B0C)&nbsp;&nbsp; sensor =3D thermistor<BR>[...]</DIV=
>
<DIV>&nbsp;</DIV>
<DIV>Changing the sensor-types brings different values, but no useful =
ones.&nbsp;Also, the value doesn?t change over time, I always get -48.0 =
=B0C with the thermistor setting.</DIV>
<DIV>If sensors logs into /var/log/messages, then there?s no entry.</DIV>
<DIV>I would have posted more info in the first post, but I thought (and =
still think) this is a case of "no sensor attached", just wanted to make =
sure.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks</DIV>
<DIV>Anian</DIV>
<DIV><BR><BR>&gt;&gt;&gt; "Juerg Haefliger" &lt;juergh@gmail.com&gt; =
06/04/07 7:52 pm &gt;&gt;&gt;<BR>Anian,<BR><BR>Some more details would be =
really helpful. It's impossible to answer<BR>"It doesn't work, what's =
wrong?" kind of questions.<BR><BR>What kernel? What system/motherboard/hwmo=
n chip? What version of<BR>sensors? Logs? Ouputs?<BR><BR>...juerg<BR><BR><B=
R>On 6/4/07, Anian Wurzenberger &lt;a.wurzenberger@transact-gmbh.de&gt; =
wrote:<BR>&gt; Hi List-Members,<BR>&gt; I?m installing lm_sensors on some =
of our systems right now. On two of<BR>&gt; them I get a degree-value of =
-48,0=B0C respectively -48,5=B0C. Changing of<BR>&gt; the sensor-types =
doesn?t seem to help.<BR>&gt; I supoose this means that the sensor-ports =
just aren?t in use, am I<BR>&gt; right? (I?m just asking because I seem to =
be missing the CPU-temp, or<BR>&gt; it?s just very low (31=B0C on an Intel =
1800, 32=B0C on Intel 3000) ).<BR>&gt;<BR>&gt; Thank you guys<BR>&gt; =
Anian W.<BR>&gt;<BR>&gt; _______________________________________________<BR=
>&gt; lm-sensors mailing list<BR>&gt; lm-sensors@lm-sensors.org<BR>&gt; <A =
href=3D"http://lists.lm/">http://lists.lm</A>-sensors.org/mailman/listinfo/=
lm-sensors<BR></DIV></BODY></HTML>

--=__Part7750591D.0__=--


--===============7995413316104469998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7995413316104469998==--
