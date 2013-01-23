From: Bogdan Butnaru <bogdanb@gmail.com>
Date: Wed, 23 Jan 2013 14:18:03 +0000
Subject: [lm-sensors] Corsair H80i support
Message-Id: <CACp6Rvb8h+br0mkmMJehT7MtnaDzd0EcPfdvvagWcpzryw5PTw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5841232595200109011=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5841232595200109011==
Content-Type: multipart/alternative; boundary=047d7b3436ac8ac66804d3f55eef

--047d7b3436ac8ac66804d3f55eef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99ve recently installed a Corsair Hydro Series H80i* integrated liq=
uid CPU
cooler in my work computer.** It works in Linux without any software, but
Corsair has a Windows software package with some extra features and I was
thinking of porting some of it to Linux. I=E2=80=99ve only just started loo=
king at
reverse engineering it, and I don't even know yet what it can do, but as
far as I can tell it should at least have sensors for the fan rotation
speeds, and it probably has at least one temperature sensor and allows
software control of the fans=E2=80=99 speeds.

I intend to reverse engineer what the Corsair software does and make a
little application to do at least those parts that I=E2=80=99m interested i=
n, but I
thought I might integrate the relevant parts of it in existing Linux tools.
lm-sensors is the first that came to mind, so here I am. This is a sort of
preemptive search for information. Perhaps some of you could offer some
pointers about how best to handle integrating the functionality in
lm-sensors (and maybe other things where it would make sense; I'm willing
to do some work even on programs I don=E2=80=99t use as an exercise, though=
 I=E2=80=99m not
sure how much time I=E2=80=99ll be able to spend on that). Once I have some=
 running
code I=E2=80=99ll start digging through the site and the dev docs by myself=
, no
need for RTFM answers, I=E2=80=99m just hoping that someone with experience=
 could
point me to the more relevant code & documentation or give some advice to
avoid dead-ends or common mistakes. (In particular, the FAQ says =E2=80=9Cs=
ee
doc/developers/new_drivers=E2=80=9D
for instructions, but at least in trunk that file seems to be missing, is
there any replacement somewhere?)

The cooler uses an somewhat unusual (at least in my experience) technique:
it connects to an internal USB header on the motherboard, and presents
itself as a USB HID (human interface device), though to my knowledge it
uses a manufacturer-specific interface (i.e., it does not masquerade as a
keyboard or anything like that).

AFAIK lm-sensors does not seem to have support for anything USB-based, at
least on first sight I didn=E2=80=99t notice any. Some pointers towards the=
 best
way to handle it would be welcome.

=E2=80=94 Bogdan Butnaru

(*:
http://www.corsair.com/us/hydro-series-h80i-high-performance-liquid-cpu-coo=
ler.html)

(**: The previous one, a no longer sold model from a different
manufacturer, decided to spill its coolant all over the inside of the
computer one night. After a day of washing everything with alcohol and
forced drying, everything else seems to work.)

--047d7b3436ac8ac66804d3f55eef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style>Hello,</div><div style><br></div><div style>I=
=E2=80=99ve recently installed a Corsair Hydro Series H80i* integrated liqu=
id CPU cooler in my work computer.** It works in Linux without any software=
, but Corsair has a Windows software package with some extra features and I=
 was thinking of porting some of it to Linux. I=E2=80=99ve only just starte=
d looking at reverse engineering it, and I don&#39;t even know yet what it =
can do, but as far as I can tell it should at least have sensors for the fa=
n rotation speeds, and it probably has at least one temperature sensor and =
allows software control of the fans=E2=80=99 speeds.</div>

<div style><br></div><div style>I intend to reverse engineer what the Corsa=
ir software does and make a little application to do at least those parts t=
hat I=E2=80=99m interested in, but I thought I might integrate the relevant=
=C2=A0parts of it in existing Linux tools. lm-sensors is the first that cam=
e to mind, so here I am. This is a sort of preemptive search for informatio=
n. Perhaps some of you could offer some pointers about how best to handle i=
ntegrating the functionality in lm-sensors (and maybe other things where it=
 would make sense; I&#39;m willing to do some work even on programs I don=
=E2=80=99t use as an exercise, though I=E2=80=99m not sure how much time I=
=E2=80=99ll be able to spend on that). Once I have some running code I=E2=
=80=99ll start digging through the site and the dev docs by myself, no need=
 for RTFM answers, I=E2=80=99m just hoping that someone with experience cou=
ld point me to the more relevant code &amp; documentation or give some advi=
ce to avoid dead-ends or common mistakes. (In particular, the FAQ says =E2=
=80=9Csee=C2=A0<span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&#=
39;Bitstream Vera Sans&#39;,Helvetica,sans-serif;font-size:13px">doc/develo=
pers/new_drivers=E2=80=9D for instructions, but at least in trunk that file=
 seems to be missing, is there any replacement somewhere?)</span></div>

<div style><br></div><div style>The cooler uses an somewhat unusual (at lea=
st in my experience) technique: it connects to an internal USB header on th=
e motherboard, and presents itself as a USB HID (human interface device), t=
hough to my knowledge it uses a manufacturer-specific interface (i.e., it d=
oes not masquerade as a keyboard or anything like that).</div>

<div><br></div><div style>AFAIK lm-sensors does not seem to have support fo=
r anything USB-based, at least on first sight I didn=E2=80=99t notice any. =
Some pointers towards the best way to handle it would be welcome.</div><br =
clear=3D"all">

<div>=E2=80=94=E2=80=8ABogdan=C2=A0Butnaru</div><div><br></div><div>(*:=C2=
=A0<a href=3D"http://www.corsair.com/us/hydro-series-h80i-high-performance-=
liquid-cpu-cooler.html">http://www.corsair.com/us/hydro-series-h80i-high-pe=
rformance-liquid-cpu-cooler.html</a>=E2=80=8A)</div>

<div><br></div><div>(**: The previous one, a no longer sold model from a di=
fferent manufacturer, decided to spill its coolant all over the inside of t=
he computer one night. After a day of washing everything with alcohol and f=
orced drying, everything else seems to work.)<br>

</div><div><br></div><div><br></div>
</div>

--047d7b3436ac8ac66804d3f55eef--


--===============5841232595200109011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5841232595200109011==--
