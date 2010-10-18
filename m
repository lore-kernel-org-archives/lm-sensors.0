From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Mon, 18 Oct 2010 15:09:02 +0000
Subject: Re: [lm-sensors] Writing a .conf for Supermicro X8DTH-6F board
Message-Id: <294A4DE2-119C-4116-B2F5-01E823A22B47@penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0247891806165797613=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
In-Reply-To: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============0247891806165797613==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-3--130302022
Content-Transfer-Encoding: 7bit


--Apple-Mail-3--130302022
Content-Type: text/plain;
	charset=utf-8;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

The Supermicro -F boards have a BMC onboard which monitors and =20
controls the sensors. You should be careful not to change the =20
configuration of the sensor chips so you don't interfere with the BMC =20=

control and monitoring.

You may want to look at the "bmcsensors" module for lm-sensors or use =20=

an IPMI utility directly ("ipmitool sdr elist" or "ipmitool sensor")

However, I would recommend the "coretemp" module so that you can see =20
actual CPU temp. Supermicro policy is to report CPU temps as only =20
green/yellow/red. Very annoying.

Phil P.

--=20
Philip Pokorny, RHCE
Chief Hardware Architect
PENGUIN COMPUTING, Inc
www.penguincomputing.com

On Oct 18, 2010, at 5:56 AM, Kristleifur Da=C3=B0ason =20
<kristleifur@gmail.com> wrote:

> Hi,
>
> I am trying to get fan control running on a Supermicro X8DTH-6F =20
> motherboard[*]. Supermicro tech support provided me with a =20
> specification file for the hardware monitor chip, a Winbond =20
> W83795AG. I have built and installed lm-sensors 3.2.0. I'm trying to =20=

> understand how to convert the specifications into a good lm-sensors =20=

> config file.
>
> Here's an excerpt from the specifications file:
>
> =E2=80=94
> Windbond W83795AG, Slave Address=3D0x2f (0x5E in 8-Bit format)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Fan1 Fan Speed, Offset 0x2e           RPM =3D 84375/Data
> CPU1 Voltage, Offset 0x10             Voltage =3D Data* 0.008
> CPU2 Voltage, Offset 0x11             Voltage =3D Data* 0.008
> +5V Voltage, Offset 0x1f              Voltage =3D Data* 0.008 * =
(40/10)
> =E2=80=94
>
> If I understand this at all, to get the fan monitoring to work, I =20
> want to assign offset 0x2e to fan1, and add a compute line for fan1 =20=

> like so: "compute fan1 84375/@, @*84375". Does that make sense?
>
> Thanks!
>
> - Kristleifur
>
>
> [*] =
http://www.supermicro.com/products/motherboard/QPI/5500/X8DTH-6F.cfm
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--Apple-Mail-3--130302022
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body bgcolor=3D"#FFFFFF"><div>The Supermicro -F boards have a BMC =
onboard which monitors and controls the sensors. You should be careful =
not to change the configuration of the sensor chips so you don't =
interfere with the BMC control and =
monitoring.</div><div><br></div><div>You may want to look at the =
"bmcsensors" module for lm-sensors or use an IPMI utility directly =
("ipmitool sdr elist" or "ipmitool sensor")<span =
class=3D"Apple-style-span" style=3D"-webkit-tap-highlight-color: =
rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, =
192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, =
0.230469); "></span></div><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.292969); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.226562); =
-webkit-composition-frame-color: rgba(77, 128, 180, =
0.226562);"><br></span></div><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); =
-webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); =
">However, I would recommend the "coretemp" module so that you can see =
actual CPU temp. Supermicro policy is to report CPU temps as only =
green/yellow/red. Very annoying.</span></div><div><span =
class=3D"Apple-style-span" style=3D"-webkit-tap-highlight-color: =
rgba(26, 26, 26, 0.292969); -webkit-composition-fill-color: rgba(175, =
192, 227, 0.226562); -webkit-composition-frame-color: rgba(77, 128, 180, =
0.226562);"><br></span></div><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.289062); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.222656); =
-webkit-composition-frame-color: rgba(77, 128, 180, 0.222656);">Phil =
P.&nbsp;</span></div><div><br>--&nbsp;<div>Philip Pokorny, =
RHCE</div><div>Chief Hardware Architect</div><div>PENGUIN COMPUTING, =
Inc&nbsp;</div><div><a =
href=3D"http://www.penguincomputing.com">www.penguincomputing.com</a></div=
></div><div><br>On Oct 18, 2010, at 5:56 AM, Kristleifur Da=C3=B0ason =
&lt;<a href=3D"mailto:kristleifur@gmail.com">kristleifur@gmail.com</a>&gt;=
 wrote:<br><br></div><div></div><blockquote =
type=3D"cite"><div>Hi,<div><br></div><div>I am trying to get fan control =
running on a Supermicro X8DTH-6F motherboard[*]. Supermicro tech support =
provided me with a specification file for the hardware monitor chip, a =
Winbond&nbsp;W83795AG. I have built and installed lm-sensors 3.2.0. I'm =
trying to understand how to convert the specifications into a good =
lm-sensors config file.</div>

<div><br></div><div>Here's an excerpt from the specifications =
file:</div><div><br></div><div><span class=3D"Apple-style-span" =
style=3D"font-family: arial, sans-serif; line-height: 15px; =
">=E2=80=94</span></div>

<div><div>Windbond W83795AG, Slave Address=3D0x2f (0x5E in 8-Bit =
format)</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Fan1 Fan =
Speed, Offset 0x2e &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RPM =3D =
84375/Data</div><div>CPU1 Voltage, Offset 0x10 &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; Voltage =3D Data* 0.008</div>

<div>CPU2 Voltage, Offset 0x11 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
Voltage =3D Data* 0.008</div></div><div><div>+5V Voltage, Offset 0x1f =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Voltage =3D Data* 0.008 =
* (40/10)</div></div><div><span class=3D"Apple-style-span" =
style=3D"font-family: arial, sans-serif; line-height: 15px; =
">=E2=80=94</span></div>

<div><span class=3D"Apple-style-span" style=3D"font-family: arial, =
sans-serif; line-height: 15px; "><br></span></div><div><font =
class=3D"Apple-style-span" face=3D"arial, sans-serif"><span =
class=3D"Apple-style-span" style=3D"line-height: 15px;">If I understand =
this at all, to get the fan monitoring to work, I want to assign offset =
0x2e to fan1, and add a compute line for fan1 like so: "compute fan1 =
84375/@, @*84375". Does that make sense?</span></font></div>

<div><br></div><div><font class=3D"Apple-style-span" face=3D"arial, =
sans-serif"><span class=3D"Apple-style-span" style=3D"line-height: =
15px;">Thanks!</span></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span =
class=3D"Apple-style-span" style=3D"line-height: =
15px;"><br></span></font></div><div><font class=3D"Apple-style-span" =
face=3D"arial, sans-serif"><span class=3D"Apple-style-span" =
style=3D"line-height: 15px;">- Kristleifur</span></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span =
class=3D"Apple-style-span" style=3D"line-height: =
15px;"><br></span></font></div><div><br></div><div>[*]&nbsp;<a =
href=3D"http://www.supermicro.com/products/motherboard/QPI/5500/X8DTH-6F.c=
fm"><a =
href=3D"http://www.supermicro.com/products/motherboard/QPI/5500/X8DTH-6F.c=
fm">http://www.supermicro.com/products/motherboard/QPI/5500/X8DTH-6F.cfm</=
a></a></div>

<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8">
</div></blockquote><blockquote =
type=3D"cite"><div><span>_______________________________________________</=
span><br><span>lm-sensors mailing list</span><br><span><a =
href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a></s=
pan><br><span><a =
href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://li=
sts.lm-sensors.org/mailman/listinfo/lm-sensors</a></span></div></blockquot=
e></body></html>=

--Apple-Mail-3--130302022--


--===============0247891806165797613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0247891806165797613==--
