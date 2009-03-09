From: =?UTF-8?B?Q3NhcGzDoXIgWm9sdMOhbg==?= <csaplar.zoltan@gmail.com>
Date: Mon, 09 Mar 2009 14:57:36 +0000
Subject: [lm-sensors] lm_sensors help
Message-Id: <622d3d2b0903090757p3057e107q882f6347d2961480@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7247287692084831241=="
List-Id: <lm-sensors.vger.kernel.org>
References: <622d3d2b0903090451v50a8614bjed6e5ba66cafebdd@mail.gmail.com>
In-Reply-To: <622d3d2b0903090451v50a8614bjed6e5ba66cafebdd@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7247287692084831241==
Content-Type: multipart/alternative; boundary=001636c5c2f1ec6e8c0464b0daa6

--001636c5c2f1ec6e8c0464b0daa6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for your quick answer. Unfortunately, it maybe happen, that I
cannot find the right information at first sight because of the language
problems, so, please, forgive it to me. Could you send me a specific
example to the below mentioned own-made sensors.d? There is a
it8712-isa-0290 chip on my motherboard, but it would be also useful a conf
file made to another type because I could conclude to the way of the
transcription from that.
As well as, do you know an other command for linux except of sensors to let
me know the chip (e.g. it8712-isa-0290) of my PC?

Thank you very much,
Zolt=C3=A1n Csapl=C3=A1r

re>
You apparently didn't read the release notes very carefully. The
default configuration file has changed in release 3.1.0 to only include
settings which are common to all mainboards. This avoids giving the
feeling to the users that their sensors are properly configured when
they aren't. Most settings are mainboard-specific and we have no way to
know if the vendor followed the recommended wiring or not.

If you want to revert to the previous behavior, you can copy
etc/sensors.conf.eg (from the lm-sensors source tree)
to /etc/sensors3.conf. But beware that the labels and voltage scaling
you will then get may or may not match your mainboard. The right way to
go is to write a custom configuration file tailored for your mainboard
and put it into /etc/sensors.d. This is no trivial task though.


On Mon, 9 Mar 2009 12:51:07 +0100, Csapl=C3=A1r Zolt=C3=A1n wrote:
> I would like to ask you for your help. By this time I have used lm_sensor=
s
> modul but now I downloaded 3.1 version.
> I don't know what the problem is, but if I use the program, I get the
> following datas:
>
> *it8712-isa-0290
> Adapter: ISA adapter
> in0:         +1.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +2.59 V  (min =3D  +1.28 V, max =3D  +1.68 V)
> in2:         +3.28 V  (min =3D  +2.78 V, max =3D  +3.78 V)
> in3:         +2.94 V  (min =3D  +2.67 V, max =3D  +3.26 V)
> in4:         +2.93 V  (min =3D  +2.50 V, max =3D  +3.49 V)
> in5:         +1.01 V  (min =3D  +0.58 V, max =3D  +1.34 V)
> in6:         +2.00 V  (min =3D  +1.04 V, max =3D  +1.36 V)
> in7:         +2.34 V  (min =3D  +2.67 V, max =3D  +3.26 V)
> Vbat:        +3.23 V
> fan1:       3245 RPM  (min =3D  664 RPM, div =3D 8)
> fan2:          0 RPM  (min =3D  332 RPM, div =3D 16)
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
> temp1:       +40.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +96.0=C2=B0C=
)  sensor =3D thermal
> diode
> temp2:       +36.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +126.0=C2=B0=
C)  sensor =3D
> transistor
> temp3:       +21.0=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D +127.0=C2=B0C=
)  sensor =3D
transistor
> cpu0_vid:   +1.088 V*
>
> I cannot read the labels and the usual values are missing (5V, 12V etc.)
> What could be the problem? Could you write it down exactly, how I could
> corrigate the problem?

--001636c5c2f1ec6e8c0464b0daa6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"im">Hello,<br><br>Thank you for your quick answer. Unfortunat=
ely,=C2=A0it maybe happen,
that I cannot find the right information at first sight because of the
language problems, so, please, forgive it to me.
<div>Could you send me a=C2=A0specific example=C2=A0to the below mentioned
own-made sensors.d? There is a it8712-isa-0290 chip on my motherboard,
but it would be also=C2=A0useful a conf file made to another type because I
could conclude to the way of the transcription from that.</div>

<div>As well as, do you know an other=C2=A0command for linux except of sens=
ors to let me know the chip (e.g. it8712-isa-0290) of my PC?</div>
<div>=C2=A0</div>
<div>Thank you very much,</div>
Zolt=C3=A1n Csapl=C3=A1r<br><br>re&gt;<br>You apparently didn&#39;t read th=
e release notes very carefully. The<br>

default configuration file has changed in release 3.1.0 to only include<br>

settings which are common to all mainboards. This avoids giving the<br>

feeling to the users that their sensors are properly configured when<br>

they aren&#39;t. Most settings are mainboard-specific and we have no way to=
<br>

know if the vendor followed the recommended wiring or not.<br>

<br>

If you want to revert to the previous behavior, you can copy<br>

etc/<a href=3D"http://sensors.conf.eg/" target=3D"_blank">sensors.conf.eg</=
a> (from the lm-sensors source tree)<br>

to /etc/sensors3.conf. But beware that the labels and voltage scaling<br>

you will then get may or may not match your mainboard. The right way to<br>

go is to write a custom configuration file tailored for your mainboard<br>

and put it into /etc/sensors.d. This is no trivial task though.<br><br><br>=
On Mon, 9 Mar 2009 12:51:07 +0100, Csapl=C3=A1r Zolt=C3=A1n wrote:<br>
&gt; I would like to ask you for your help. By this time I have used lm_sen=
sors<br>
&gt; modul but now I downloaded 3.1 version.<br>
&gt; I don&#39;t know what the problem is, but if I use the program, I get =
the<br>
&gt; following datas:<br>
&gt;<br>
&gt; *it8712-isa-0290<br>
&gt; Adapter: ISA adapter<br>
&gt; in0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +1.33 V =C2=A0(min =3D =C2=A0+0.00 V,=
 max =3D =C2=A0+4.08 V)<br>
&gt; in1: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.59 V =C2=A0(min =3D =C2=A0+1.28 V,=
 max =3D =C2=A0+1.68 V)<br>
&gt; in2: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +3.28 V =C2=A0(min =3D =C2=A0+2.78 V,=
 max =3D =C2=A0+3.78 V)<br>
&gt; in3: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.94 V =C2=A0(min =3D =C2=A0+2.67 V,=
 max =3D =C2=A0+3.26 V)<br>
&gt; in4: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.93 V =C2=A0(min =3D =C2=A0+2.50 V,=
 max =3D =C2=A0+3.49 V)<br>
&gt; in5: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +1.01 V =C2=A0(min =3D =C2=A0+0.58 V,=
 max =3D =C2=A0+1.34 V)<br>
&gt; in6: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.00 V =C2=A0(min =3D =C2=A0+1.04 V,=
 max =3D =C2=A0+1.36 V)<br>
&gt; in7: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.34 V =C2=A0(min =3D =C2=A0+2.67 V,=
 max =3D =C2=A0+3.26 V)<br>
&gt; Vbat: =C2=A0 =C2=A0 =C2=A0 =C2=A0+3.23 V<br>
&gt; fan1: =C2=A0 =C2=A0 =C2=A0 3245 RPM =C2=A0(min =3D =C2=A0664 RPM, div =
=3D 8)<br>
&gt; fan2: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 RPM =C2=A0(min =3D =C2=A0332=
 RPM, div =3D 16)<br>
&gt; fan3: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 RPM =C2=A0(min =3D =C2=A0 =
=C2=A00 RPM, div =3D 8)<br>
&gt; temp1: =C2=A0 =C2=A0 =C2=A0 +40.0=C2=B0C =C2=A0(low =C2=A0=3D +127.0=
=C2=B0C, high =3D +96.0=C2=B0C) =C2=A0sensor =3D thermal<br>
&gt; diode<br>
&gt; temp2: =C2=A0 =C2=A0 =C2=A0 +36.0=C2=B0C =C2=A0(low =C2=A0=3D +127.0=
=C2=B0C, high =3D +126.0=C2=B0C) =C2=A0sensor =3D<br>
&gt; transistor<br>
&gt; temp3: =C2=A0 =C2=A0 =C2=A0 +21.0=C2=B0C =C2=A0(low =C2=A0=3D =C2=A0+0=
.0=C2=B0C, high =3D +127.0=C2=B0C) =C2=A0sensor =3D transistor<br>
&gt; cpu0_vid: =C2=A0 +1.088 V*<br>
&gt;<br>
&gt; I cannot read the labels and the usual values are missing (5V, 12V etc=
.)<br>
&gt; What could be the problem? Could you write it down exactly, how I coul=
d<br>
&gt; corrigate the problem?<br>
<br>
</div><br>

--001636c5c2f1ec6e8c0464b0daa6--


--===============7247287692084831241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7247287692084831241==--
