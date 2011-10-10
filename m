From: Kristen Eisenberg <kristen.eisenberg@yahoo.com>
Date: Mon, 10 Oct 2011 22:29:24 +0000
Subject: [lm-sensors]  hwmon API update
Message-Id: <1318285764.13355.YahooMailNeo@web122301.mail.ne1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1477796465237406111=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
To: lm-sensors@vger.kernel.org

--===============1477796465237406111==
Content-Type: multipart/alternative; boundary="518238472-510183156-1318285764=:13355"

--518238472-510183156-1318285764=:13355
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Am Montag, den 28.02.2011, 10:42 -0800 schrieb Guenter Roeck:=0A> On Mon, F=
eb 28, 2011 at 12:50:45PM -0500, Lucas Stach wrote:=0A> > Hello all,=0A> > =
=0A> > let me revive this discussion a bit. After reading some things about=
 the=0A> > matter I think the way to go is to use Intels thermal framework.=
 It=0A> > should be easy to add the needed temp_get and fan_set functions t=
o the=0A> > affected hwmon drivers. =0A> > =0A> > But then one problem stil=
l persists: when the hwmon driver probes a=0A> > device it automatically cr=
eates the sysfs entries. This is unintended=0A> > behaviour from nouveau's =
point of view. The sensor value is not the real=0A> > temperature value; it=
 has to be scaled with some factor and an offset=0A> > hard-coded in the vi=
deo bios tables. This scaling could only be done on=0A> > nouveau's side, s=
o the hwmon driver is exposing an interface with wrong=0A> > values to the =
userspace.=0A> > =0A> > We need a way to use the hwmon i2c driver without e=
xposing this=0A> > interface. Do you have any preferred way how we could ac=
hieve this?=0A> > =0A> The whole point of the hwmon subsystem is to expose =
hardware monitoring=0A> attributes to userspace. A hwmon driver without sys=
fs attributes does not=0A> make sense.=0A=0A=0AKristen Eisenberg=0ABillige =
Fl=FCge=0AMarketing GmbH=0AEmanuelstr. 3,=0A10317 Berlin=0ADeutschland=0ATe=
lefon: +49 (33)=0A5310967=0AEmail:=0Autebachmeier at=0Agmail.com=0ASite:=0A=
http://flug.airego.de
- Billige Fl=FCge vergleichen
--518238472-510183156-1318285764=:13355
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Am Montag, den 2=
8.02.2011, 10:42 -0800 schrieb Guenter Roeck:<br>&gt; On Mon, Feb 28, 2011 =
at 12:50:45PM -0500, Lucas Stach wrote:<br>&gt; &gt; Hello all,<br>&gt; &gt=
;  <br>&gt; &gt; let me revive this discussion a bit. After reading some th=
ings about the<br>&gt; &gt; matter I think the way to go is to use Intels t=
hermal framework. It<br>&gt; &gt; should be easy to add the needed temp_get=
 and fan_set functions to the<br>&gt; &gt; affected hwmon drivers. <br>&gt;=
 &gt; <br>&gt; &gt; But then one problem still persists: when the hwmon dri=
ver probes a<br>&gt; &gt; device it automatically creates the sysfs entries=
. This is unintended<br>&gt; &gt; behaviour from nouveau's point of view. T=
he sensor value is not the real<br>&gt; &gt; temperature value; it has to b=
e scaled with some factor and an offset<br>&gt; &gt; hard-coded in the
 video bios tables. This scaling could only be done on<br>&gt; &gt; nouveau=
's side, so the hwmon driver is exposing an interface with wrong<br>&gt; &g=
t; values to the userspace.<br>&gt; &gt; <br>&gt; &gt; We need a way to use=
 the hwmon i2c driver without exposing this<br>&gt; &gt; interface. Do you =
have any preferred way how we could achieve this?<br>&gt; &gt; <br>&gt; The=
 whole point of the hwmon subsystem is to expose hardware monitoring<br>&gt=
; attributes to userspace. A hwmon driver without sysfs attributes does not=
<br>&gt; make sense.</div><div><br></div><div>


<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">K=
risten Eisenberg</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">B=
illige Fl=FCge</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">M=
arketing GmbH</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">E=
manuelstr. 3,</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">1=
0317 Berlin</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">D=
eutschland</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">T=
elefon: +49 (33)</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">5=
310967</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">E=
mail:</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">u=
tebachmeier at</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">g=
mail.com</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">S=
ite:</span></div>

<div class=3D"MsoNormal"><span lang=3D"DE" style=3D"mso-ansi-language:DE">h=
ttp://flug.airego.de
- Billige Fl=FCge vergleichen</span></div></div></div></body></html>
--518238472-510183156-1318285764=:13355--


--===============1477796465237406111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1477796465237406111==--
