From: =?ISO-8859-1?Q?Kristleifur_Da=F0ason?= <kristleifur@gmail.com>
Date: Mon, 18 Oct 2010 12:56:18 +0000
Subject: [lm-sensors] Writing a .conf for Supermicro X8DTH-6F board
Message-Id: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1149875459354892112=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1149875459354892112==
Content-Type: multipart/alternative; boundary=000e0cd28e58fe104d0492e3b4d5

--000e0cd28e58fe104d0492e3b4d5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to get fan control running on a Supermicro X8DTH-6F
motherboard[*]. Supermicro tech support provided me with a specification
file for the hardware monitor chip, a Winbond W83795AG. I have built and
installed lm-sensors 3.2.0. I'm trying to understand how to convert the
specifications into a good lm-sensors config file.

Here's an excerpt from the specifications file:

=97
Windbond W83795AG, Slave Address=3D0x2f (0x5E in 8-Bit format)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Fan1 Fan Speed, Offset 0x2e           RPM =3D 84375/Data
CPU1 Voltage, Offset 0x10             Voltage =3D Data* 0.008
CPU2 Voltage, Offset 0x11             Voltage =3D Data* 0.008
+5V Voltage, Offset 0x1f              Voltage =3D Data* 0.008 * (40/10)
=97

If I understand this at all, to get the fan monitoring to work, I want to
assign offset 0x2e to fan1, and add a compute line for fan1 like so:
"compute fan1 84375/@, @*84375". Does that make sense?

Thanks!

- Kristleifur


[*] http://www.supermicro.com/products/motherboard/QPI/5500/X8DTH-6F.cfm

--000e0cd28e58fe104d0492e3b4d5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I am trying to get fan control running on a Supermic=
ro X8DTH-6F motherboard[*]. Supermicro tech support provided me with a spec=
ification file for the hardware monitor chip, a Winbond=A0W83795AG. I have =
built and installed lm-sensors 3.2.0. I&#39;m trying to understand how to c=
onvert the specifications into a good lm-sensors config file.</div>

<div><br></div><div>Here&#39;s an excerpt from the specifications file:</di=
v><div><br></div><div><meta http-equiv=3D"content-type" content=3D"text/htm=
l; charset=3Dutf-8"><span class=3D"Apple-style-span" style=3D"font-family: =
arial, sans-serif; line-height: 15px; ">=97</span></div>

<div><div>Windbond W83795AG, Slave Address=3D0x2f (0x5E in 8-Bit format)</d=
iv><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Fan1 Fan Speed, Offset=
 0x2e =A0 =A0 =A0 =A0 =A0 RPM =3D 84375/Data</div><div>CPU1 Voltage, Offset=
 0x10 =A0 =A0 =A0 =A0 =A0 =A0 Voltage =3D Data* 0.008</div>

<div>CPU2 Voltage, Offset 0x11 =A0 =A0 =A0 =A0 =A0 =A0 Voltage =3D Data* 0.=
008</div></div><div><div>+5V Voltage, Offset 0x1f =A0 =A0 =A0 =A0 =A0 =A0 =
=A0Voltage =3D Data* 0.008 * (40/10)</div></div><div><meta http-equiv=3D"co=
ntent-type" content=3D"text/html; charset=3Dutf-8"><span class=3D"Apple-sty=
le-span" style=3D"font-family: arial, sans-serif; line-height: 15px; ">=97<=
/span></div>

<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; line-height: 15px; "><br></span></div><div><font class=3D"Apple-style-s=
pan" face=3D"arial, sans-serif"><span class=3D"Apple-style-span" style=3D"l=
ine-height: 15px;">If I understand this at all, to get the fan monitoring t=
o work, I want to assign offset 0x2e to fan1, and add a compute line for fa=
n1 like so: &quot;compute fan1 84375/@, @*84375&quot;. Does that make sense=
?</span></font></div>

<div><br></div><div><meta http-equiv=3D"content-type" content=3D"text/html;=
 charset=3Dutf-8"><font class=3D"Apple-style-span" face=3D"arial, sans-seri=
f"><span class=3D"Apple-style-span" style=3D"line-height: 15px;">Thanks!</s=
pan></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"line-height: 15px;"><br></span></font></div=
><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span cla=
ss=3D"Apple-style-span" style=3D"line-height: 15px;">- Kristleifur</span></=
font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"line-height: 15px;"><br></span></font></div=
><div><br></div><div>[*]=A0<a href=3D"http://www.supermicro.com/products/mo=
therboard/QPI/5500/X8DTH-6F.cfm">http://www.supermicro.com/products/motherb=
oard/QPI/5500/X8DTH-6F.cfm</a></div>

<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8">

--000e0cd28e58fe104d0492e3b4d5--


--===============1149875459354892112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1149875459354892112==--
