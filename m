From: Sergio Bruder <sergio@bruder.com.br>
Date: Tue, 03 Jun 2008 18:57:45 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <CB6EE892-F074-4DFC-8C5C-32987973FC0D@bruder.com.br>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3244062183070446372=="
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
To: lm-sensors@vger.kernel.org


--===============3244062183070446372==
Content-Type: multipart/alternative; boundary=Apple-Mail-15-136548237


--Apple-Mail-15-136548237
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable


Em 03/06/2008, =E0s 11:44, Juerg Haefliger escreveu:

> Hi Sergio,
>
> On Mon, Jun 2, 2008 at 10:31 PM, Sergio Bruder =20
> <sergio@bruder.com.br> wrote:
> What is the temperature that are controlling the fan auto control?
>
> Have you read Documentation/hwmon/vt1211 in the kernel source tree? =20=

> Can you send the output of 'sensors' and 'grep "" /sys/class/hwmon*/=20=

> device/*''?
grep ""/sys/class/hwmon/hwmon*/device/*.
>
>
> ...juerg
>

root@nimbus:/etc# sensors
vt1211-isa-6000
Adapter: ISA adapter
VCore:       +0.98 V  (min =3D  +0.00 V, max =3D  +2.63 V)
+5V:         +4.63 V  (min =3D  +0.00 V, max =3D  +6.31 V)
+12V:       +11.72 V  (min =3D  +0.00 V, max =3D +14.99 V)
+3.3V:       +3.23 V  (min =3D  +3.13 V, max =3D  +3.46 V)
CPU Fan:       0 RPM  (min =3D    0 RPM, div =3D 2)
CPU Temp:    -35.5=B0C  (high =3D +190.1=B0C, hyst =3D -77.5=B0C)
Int Temp:    +51.0=B0C  (high =3D +204.0=B0C, hyst =3D  +0.0=B0C)
temp3:       -21.8=B0C  (high =3D +64.8=B0C, hyst =3D +60.2=B0C)
temp4:       -25.8=B0C  (high =3D +44.7=B0C, hyst =3D +39.8=B0C)
cpu0_vid:   +1.212 V


root@nimbus:/sys/class/hwmon/hwmon0/device# grep "" /sys/class/hwmon/=20
hwmon*/device/*
/sys/class/hwmon/hwmon0/device/alarms:4608
/sys/class/hwmon/hwmon0/device/cpu0_vid:1212
/sys/class/hwmon/hwmon0/device/fan1_alarm:0
/sys/class/hwmon/hwmon0/device/fan1_div:2
/sys/class/hwmon/hwmon0/device/fan1_input:0
/sys/class/hwmon/hwmon0/device/fan1_min:0
/sys/class/hwmon/hwmon0/device/fan2_alarm:0
/sys/class/hwmon/hwmon0/device/fan2_div:2
/sys/class/hwmon/hwmon0/device/fan2_input:0
/sys/class/hwmon/hwmon0/device/fan2_min:0
/sys/class/hwmon/hwmon0/device/in2_alarm:0
/sys/class/hwmon/hwmon0/device/in2_input:981
/sys/class/hwmon/hwmon0/device/in2_max:2630
/sys/class/hwmon/hwmon0/device/in2_min:0
/sys/class/hwmon/hwmon0/device/in3_alarm:0
/sys/class/hwmon/hwmon0/device/in3_input:1931
/sys/class/hwmon/hwmon0/device/in3_max:2630
/sys/class/hwmon/hwmon0/device/in3_min:0
/sys/class/hwmon/hwmon0/device/in4_alarm:0
/sys/class/hwmon/hwmon0/device/in4_input:2056
/sys/class/hwmon/hwmon0/device/in4_max:2630
/sys/class/hwmon/hwmon0/device/in4_min:0
/sys/class/hwmon/hwmon0/device/in5_alarm:0
/sys/class/hwmon/hwmon0/device/in5_input:3233
/sys/class/hwmon/hwmon0/device/in5_max:3465
/sys/class/hwmon/hwmon0/device/in5_min:3133
/sys/class/hwmon/hwmon0/device/modalias:platform:vt1211
/sys/class/hwmon/hwmon0/device/name:vt1211
/sys/class/hwmon/hwmon0/device/pwm1:255
/sys/class/hwmon/hwmon0/device/pwm1_auto_channels_temp:1
/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm:0
/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp:0
/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm:255
/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_temp:0
/sys/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:255
/sys/class/hwmon/hwmon0/device/pwm1_auto_point3_temp:0
/sys/class/hwmon/hwmon0/device/pwm1_auto_point4_pwm:255
/sys/class/hwmon/hwmon0/device/pwm1_auto_point4_temp:0
/sys/class/hwmon/hwmon0/device/pwm1_enable:2
/sys/class/hwmon/hwmon0/device/pwm1_freq:45000
/sys/class/hwmon/hwmon0/device/pwm2:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_channels_temp:1
/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm:0
/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_temp:0
/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_pwm:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_temp:0
/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_temp:0
/sys/class/hwmon/hwmon0/device/pwm2_auto_point4_pwm:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_point4_temp:0
/sys/class/hwmon/hwmon0/device/pwm2_enable:0
/sys/class/hwmon/hwmon0/device/pwm2_freq:45000
/sys/class/hwmon/hwmon0/device/temp1_alarm:0
/sys/class/hwmon/hwmon0/device/temp1_input:40000
/sys/class/hwmon/hwmon0/device/temp1_max:255000
/sys/class/hwmon/hwmon0/device/temp1_max_hyst:0
/sys/class/hwmon/hwmon0/device/temp2_alarm:0
/sys/class/hwmon/hwmon0/device/temp2_input:51000
/sys/class/hwmon/hwmon0/device/temp2_max:204000
/sys/class/hwmon/hwmon0/device/temp2_max_hyst:0
/sys/class/hwmon/hwmon0/device/temp3_alarm:0
/sys/class/hwmon/hwmon0/device/temp3_input:1970
/sys/class/hwmon/hwmon0/device/temp3_max:450
/sys/class/hwmon/hwmon0/device/temp3_max_hyst:503
/sys/class/hwmon/hwmon0/device/temp4_alarm:0
/sys/class/hwmon/hwmon0/device/temp4_input:2011
/sys/class/hwmon/hwmon0/device/temp4_max:723
/sys/class/hwmon/hwmon0/device/temp4_max_hyst:807
/sys/class/hwmon/hwmon0/device/uevent:DRIVER=3Dvt1211
/sys/class/hwmon/hwmon0/device/uevent:MODALIAS=3Dplatform:vt1211
/sys/class/hwmon/hwmon0/device/vrm:13


>
>
> Sergio Bruder
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


--Apple-Mail-15-136548237
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><br><div><div>Em 03/06/2008, =E0s=
 11:44, Juerg Haefliger escreveu:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite">Hi =
Sergio,<br><br><div class=3D"gmail_quote">On Mon, Jun 2, 2008 at 10:31 =
PM, Sergio Bruder &lt;<a =
href=3D"mailto:sergio@bruder.com.br">sergio@bruder.com.br</a>> =
wrote:<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> What =
is the temperature that are controlling the fan auto control?<br> =
</blockquote><div><br>Have you read Documentation/hwmon/vt1211 in the =
kernel source tree? Can you send the output of 'sensors' and 'grep "" =
/sys/class/hwmon*/device/*''?</div></div></blockquote>grep =
""/sys/class/hwmon/hwmon*/device/*.&nbsp;<br><blockquote =
type=3D"cite"><div class=3D"gmail_quote"><div><br>&nbsp;<br>...juerg<br> =
<br></div></div></blockquote><div><br></div><div>root@nimbus:/etc# =
sensors</div><div>vt1211-isa-6000</div><div>Adapter: ISA =
adapter</div><div>VCore: &nbsp; &nbsp; &nbsp; +0.98 V &nbsp;(min =3D =
&nbsp;+0.00 V, max =3D &nbsp;+2.63 V) &nbsp;&nbsp;</div><div>+5V: &nbsp; =
&nbsp; &nbsp; &nbsp; +4.63 V &nbsp;(min =3D &nbsp;+0.00 V, max =3D =
&nbsp;+6.31 V) &nbsp;&nbsp;</div><div>+12V: &nbsp; &nbsp; &nbsp; +11.72 =
V &nbsp;(min =3D &nbsp;+0.00 V, max =3D +14.99 V) =
&nbsp;&nbsp;</div><div>+3.3V: &nbsp; &nbsp; &nbsp; +3.23 V &nbsp;(min =3D =
&nbsp;+3.13 V, max =3D &nbsp;+3.46 V) &nbsp;&nbsp;</div><div>CPU Fan: =
&nbsp; &nbsp; &nbsp; 0 RPM &nbsp;(min =3D &nbsp; &nbsp;0 RPM, div =3D =
2)</div><div>CPU Temp: &nbsp; &nbsp;-35.5=B0C &nbsp;(high =3D +190.1=B0C, =
hyst =3D -77.5=B0C) &nbsp;</div><div>Int Temp: &nbsp; &nbsp;+51.0=B0C =
&nbsp;(high =3D +204.0=B0C, hyst =3D &nbsp;+0.0=B0C) =
&nbsp;</div><div>temp3: &nbsp; &nbsp; &nbsp; -21.8=B0C &nbsp;(high =3D =
+64.8=B0C, hyst =3D +60.2=B0C) &nbsp;</div><div>temp4: &nbsp; &nbsp; =
&nbsp; -25.8=B0C &nbsp;(high =3D +44.7=B0C, hyst =3D +39.8=B0C) =
&nbsp;</div><div>cpu0_vid: &nbsp; +1.212 =
V</div><div><br></div><div><br></div><div><div>root@nimbus:/sys/class/hwmo=
n/hwmon0/device# grep "" =
/sys/class/hwmon/hwmon*/device/*</div><div>/sys/class/hwmon/hwmon0/device/=
alarms:4608</div><div>/sys/class/hwmon/hwmon0/device/cpu0_vid:1212</div><d=
iv>/sys/class/hwmon/hwmon0/device/fan1_alarm:0</div><div>/sys/class/hwmon/=
hwmon0/device/fan1_div:2</div><div>/sys/class/hwmon/hwmon0/device/fan1_inp=
ut:0</div><div>/sys/class/hwmon/hwmon0/device/fan1_min:0</div><div>/sys/cl=
ass/hwmon/hwmon0/device/fan2_alarm:0</div><div>/sys/class/hwmon/hwmon0/dev=
ice/fan2_div:2</div><div>/sys/class/hwmon/hwmon0/device/fan2_input:0</div>=
<div>/sys/class/hwmon/hwmon0/device/fan2_min:0</div><div>/sys/class/hwmon/=
hwmon0/device/in2_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/in2_inp=
ut:981</div><div>/sys/class/hwmon/hwmon0/device/in2_max:2630</div><div>/sy=
s/class/hwmon/hwmon0/device/in2_min:0</div><div>/sys/class/hwmon/hwmon0/de=
vice/in3_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/in3_input:1931</=
div><div>/sys/class/hwmon/hwmon0/device/in3_max:2630</div><div>/sys/class/=
hwmon/hwmon0/device/in3_min:0</div><div>/sys/class/hwmon/hwmon0/device/in4=
_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/in4_input:2056</div><div=
>/sys/class/hwmon/hwmon0/device/in4_max:2630</div><div>/sys/class/hwmon/hw=
mon0/device/in4_min:0</div><div>/sys/class/hwmon/hwmon0/device/in5_alarm:0=
</div><div>/sys/class/hwmon/hwmon0/device/in5_input:3233</div><div>/sys/cl=
ass/hwmon/hwmon0/device/in5_max:3465</div><div>/sys/class/hwmon/hwmon0/dev=
ice/in5_min:3133</div><div>/sys/class/hwmon/hwmon0/device/modalias:platfor=
m:vt1211</div><div>/sys/class/hwmon/hwmon0/device/name:vt1211</div><div>/s=
ys/class/hwmon/hwmon0/device/pwm1:255</div><div>/sys/class/hwmon/hwmon0/de=
vice/pwm1_auto_channels_temp:1</div><div>/sys/class/hwmon/hwmon0/device/pw=
m1_auto_point1_pwm:0</div><div>/sys/class/hwmon/hwmon0/device/pwm1_auto_po=
int1_temp:0</div><div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm:=
255</div><div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_temp:0</div>=
<div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:255</div><div>/sy=
s/class/hwmon/hwmon0/device/pwm1_auto_point3_temp:0</div><div>/sys/class/h=
wmon/hwmon0/device/pwm1_auto_point4_pwm:255</div><div>/sys/class/hwmon/hwm=
on0/device/pwm1_auto_point4_temp:0</div><div>/sys/class/hwmon/hwmon0/devic=
e/pwm1_enable:2</div><div>/sys/class/hwmon/hwmon0/device/pwm1_freq:45000</=
div><div>/sys/class/hwmon/hwmon0/device/pwm2:255</div><div>/sys/class/hwmo=
n/hwmon0/device/pwm2_auto_channels_temp:1</div><div>/sys/class/hwmon/hwmon=
0/device/pwm2_auto_point1_pwm:0</div><div>/sys/class/hwmon/hwmon0/device/p=
wm2_auto_point1_temp:0</div><div>/sys/class/hwmon/hwmon0/device/pwm2_auto_=
point2_pwm:255</div><div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_t=
emp:0</div><div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255</d=
iv><div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_temp:0</div><div>/=
sys/class/hwmon/hwmon0/device/pwm2_auto_point4_pwm:255</div><div>/sys/clas=
s/hwmon/hwmon0/device/pwm2_auto_point4_temp:0</div><div>/sys/class/hwmon/h=
wmon0/device/pwm2_enable:0</div><div>/sys/class/hwmon/hwmon0/device/pwm2_f=
req:45000</div><div>/sys/class/hwmon/hwmon0/device/temp1_alarm:0</div><div=
>/sys/class/hwmon/hwmon0/device/temp1_input:40000</div><div>/sys/class/hwm=
on/hwmon0/device/temp1_max:255000</div><div>/sys/class/hwmon/hwmon0/device=
/temp1_max_hyst:0</div><div>/sys/class/hwmon/hwmon0/device/temp2_alarm:0</=
div><div>/sys/class/hwmon/hwmon0/device/temp2_input:51000</div><div>/sys/c=
lass/hwmon/hwmon0/device/temp2_max:204000</div><div>/sys/class/hwmon/hwmon=
0/device/temp2_max_hyst:0</div><div>/sys/class/hwmon/hwmon0/device/temp3_a=
larm:0</div><div>/sys/class/hwmon/hwmon0/device/temp3_input:1970</div><div=
>/sys/class/hwmon/hwmon0/device/temp3_max:450</div><div>/sys/class/hwmon/h=
wmon0/device/temp3_max_hyst:503</div><div>/sys/class/hwmon/hwmon0/device/t=
emp4_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/temp4_input:2011</di=
v><div>/sys/class/hwmon/hwmon0/device/temp4_max:723</div><div>/sys/class/h=
wmon/hwmon0/device/temp4_max_hyst:807</div><div>/sys/class/hwmon/hwmon0/de=
vice/uevent:DRIVER=3Dvt1211</div><div>/sys/class/hwmon/hwmon0/device/ueven=
t:MODALIAS=3Dplatform:vt1211</div><div>/sys/class/hwmon/hwmon0/device/vrm:=
13</div><div><br></div></div><div><br></div><blockquote type=3D"cite"><div=
 class=3D"gmail_quote"><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;"><br> Sergio Bruder<br> <br> =
_______________________________________________<br> lm-sensors mailing =
list<br> <a =
href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><br=
> <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" =
target=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<=
/a><br> </blockquote></div><br></blockquote></div><br></body></html>=

--Apple-Mail-15-136548237--


--===============3244062183070446372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3244062183070446372==--
