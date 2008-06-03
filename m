From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 03 Jun 2008 19:48:07 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <191fb4ca0806031248n7052b3eajb521fb26fc2d4aa5@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1822760420867253515=="
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
To: lm-sensors@vger.kernel.org

--===============1822760420867253515==
Content-Type: multipart/alternative; 
	boundary="----=_Part_21017_18249477.1212522487390"

------=_Part_21017_18249477.1212522487390
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sergio,


On Tue, Jun 3, 2008 at 11:57 AM, Sergio Bruder <sergio@bruder.com.br> wrote=
:

>
> Em 03/06/2008, =E0s 11:44, Juerg Haefliger escreveu:
>
> Hi Sergio,
>
> On Mon, Jun 2, 2008 at 10:31 PM, Sergio Bruder <sergio@bruder.com.br>
> wrote:
>
>> What is the temperature that are controlling the fan auto control?
>>
>
> Have you read Documentation/hwmon/vt1211 in the kernel source tree? Can y=
ou
> send the output of 'sensors' and 'grep "" /sys/class/hwmon*/device/*''?
>
> grep ""/sys/class/hwmon/hwmon*/device/*.
>
>
>
> ...juerg
>
>
> root@nimbus:/etc# sensors
> vt1211-isa-6000
> Adapter: ISA adapter
> VCore:       +0.98 V  (min =3D  +0.00 V, max =3D  +2.63 V)
> +5V:         +4.63 V  (min =3D  +0.00 V, max =3D  +6.31 V)
> +12V:       +11.72 V  (min =3D  +0.00 V, max =3D +14.99 V)
> +3.3V:       +3.23 V  (min =3D  +3.13 V, max =3D  +3.46 V)
> CPU Fan:       0 RPM  (min =3D    0 RPM, div =3D 2)
> CPU Temp:    -35.5=B0C  (high =3D +190.1=B0C, hyst =3D -77.5=B0C)
> Int Temp:    +51.0=B0C  (high =3D +204.0=B0C, hyst =3D  +0.0=B0C)
> temp3:       -21.8=B0C  (high =3D +64.8=B0C, hyst =3D +60.2=B0C)
> temp4:       -25.8=B0C  (high =3D +44.7=B0C, hyst =3D +39.8=B0C)
> cpu0_vid:   +1.212 V
>
>
> root@nimbus:/sys/class/hwmon/hwmon0/device# grep ""
> /sys/class/hwmon/hwmon*/device/*
> /sys/class/hwmon/hwmon0/device/alarms:4608
> /sys/class/hwmon/hwmon0/device/cpu0_vid:1212
> /sys/class/hwmon/hwmon0/device/fan1_alarm:0
> /sys/class/hwmon/hwmon0/device/fan1_div:2
> /sys/class/hwmon/hwmon0/device/fan1_input:0
> /sys/class/hwmon/hwmon0/device/fan1_min:0
> /sys/class/hwmon/hwmon0/device/fan2_alarm:0
> /sys/class/hwmon/hwmon0/device/fan2_div:2
> /sys/class/hwmon/hwmon0/device/fan2_input:0
> /sys/class/hwmon/hwmon0/device/fan2_min:0
> /sys/class/hwmon/hwmon0/device/in2_alarm:0
> /sys/class/hwmon/hwmon0/device/in2_input:981
> /sys/class/hwmon/hwmon0/device/in2_max:2630
> /sys/class/hwmon/hwmon0/device/in2_min:0
> /sys/class/hwmon/hwmon0/device/in3_alarm:0
> /sys/class/hwmon/hwmon0/device/in3_input:1931
> /sys/class/hwmon/hwmon0/device/in3_max:2630
> /sys/class/hwmon/hwmon0/device/in3_min:0
> /sys/class/hwmon/hwmon0/device/in4_alarm:0
> /sys/class/hwmon/hwmon0/device/in4_input:2056
> /sys/class/hwmon/hwmon0/device/in4_max:2630
> /sys/class/hwmon/hwmon0/device/in4_min:0
> /sys/class/hwmon/hwmon0/device/in5_alarm:0
> /sys/class/hwmon/hwmon0/device/in5_input:3233
> /sys/class/hwmon/hwmon0/device/in5_max:3465
> /sys/class/hwmon/hwmon0/device/in5_min:3133
> /sys/class/hwmon/hwmon0/device/modalias:platform:vt1211
> /sys/class/hwmon/hwmon0/device/name:vt1211
> /sys/class/hwmon/hwmon0/device/pwm1:255
> /sys/class/hwmon/hwmon0/device/pwm1_auto_channels_temp:1
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm:0
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp:0
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm:255
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point2_temp:0
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:255
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point3_temp:0
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point4_pwm:255
> /sys/class/hwmon/hwmon0/device/pwm1_auto_point4_temp:0
> /sys/class/hwmon/hwmon0/device/pwm1_enable:2
> /sys/class/hwmon/hwmon0/device/pwm1_freq:45000
> /sys/class/hwmon/hwmon0/device/pwm2:255
> /sys/class/hwmon/hwmon0/device/pwm2_auto_channels_temp:1
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm:0
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point1_temp:0
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point2_pwm:255
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point2_temp:0
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point3_temp:0
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point4_pwm:255
> /sys/class/hwmon/hwmon0/device/pwm2_auto_point4_temp:0
> /sys/class/hwmon/hwmon0/device/pwm2_enable:0
> /sys/class/hwmon/hwmon0/device/pwm2_freq:45000
> /sys/class/hwmon/hwmon0/device/temp1_alarm:0
> /sys/class/hwmon/hwmon0/device/temp1_input:40000
> /sys/class/hwmon/hwmon0/device/temp1_max:255000
> /sys/class/hwmon/hwmon0/device/temp1_max_hyst:0
> /sys/class/hwmon/hwmon0/device/temp2_alarm:0
> /sys/class/hwmon/hwmon0/device/temp2_input:51000
> /sys/class/hwmon/hwmon0/device/temp2_max:204000
> /sys/class/hwmon/hwmon0/device/temp2_max_hyst:0
> /sys/class/hwmon/hwmon0/device/temp3_alarm:0
> /sys/class/hwmon/hwmon0/device/temp3_input:1970
> /sys/class/hwmon/hwmon0/device/temp3_max:450
> /sys/class/hwmon/hwmon0/device/temp3_max_hyst:503
> /sys/class/hwmon/hwmon0/device/temp4_alarm:0
> /sys/class/hwmon/hwmon0/device/temp4_input:2011
> /sys/class/hwmon/hwmon0/device/temp4_max:723
> /sys/class/hwmon/hwmon0/device/temp4_max_hyst:807
> /sys/class/hwmon/hwmon0/device/uevent:DRIVER=3Dvt1211
> /sys/class/hwmon/hwmon0/device/uevent:MODALIAS=3Dplatform:vt1211
> /sys/class/hwmon/hwmon0/device/vrm:13
>


Thanks but you haven't answered my first question. Did you read the
documentation?

...juerg



>
>
>
>> Sergio Bruder
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>
>
>

------=_Part_21017_18249477.1212522487390
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sergio,<br><br><br><div class=3D"gmail_quote">On Tue, Jun 3, 2008 at 11:=
57 AM, Sergio Bruder &lt;<a href=3D"mailto:sergio@bruder.com.br">sergio@bru=
der.com.br</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
<div style=3D""><br><div><div>Em 03/06/2008, =E0s 11:44, Juerg Haefliger es=
creveu:</div><br><blockquote type=3D"cite">Hi Sergio,<br><br><div class=3D"=
gmail_quote"><div class=3D"Ih2E3d">On Mon, Jun 2, 2008 at 10:31 PM, Sergio =
Bruder &lt;<a href=3D"mailto:sergio@bruder.com.br" target=3D"_blank">sergio=
@bruder.com.br</a>&gt; wrote:</div>
<div class=3D"Ih2E3d"><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;"> What is the temperature that are controlling the fan auto control?<br=
> </blockquote>
<div><br>Have you read Documentation/hwmon/vt1211 in the kernel source tree=
? Can you send the output of &#39;sensors&#39; and &#39;grep &quot;&quot; /=
sys/class/hwmon*/device/*&#39;&#39;?</div></div></div></blockquote>grep &qu=
ot;&quot;/sys/class/hwmon/hwmon*/device/*.&nbsp;<br>
<blockquote type=3D"cite"><div class=3D"gmail_quote"><div><br>&nbsp;<br>...=
juerg<br> <br></div></div></blockquote><div><br></div><div>root@nimbus:/etc=
# sensors</div><div>vt1211-isa-6000</div><div>Adapter: ISA adapter</div><di=
v>VCore: &nbsp; &nbsp; &nbsp; +0.98 V &nbsp;(min =3D &nbsp;+0.00 V, max =3D=
 &nbsp;+2.63 V) &nbsp;&nbsp;</div>
<div>+5V: &nbsp; &nbsp; &nbsp; &nbsp; +4.63 V &nbsp;(min =3D &nbsp;+0.00 V,=
 max =3D &nbsp;+6.31 V) &nbsp;&nbsp;</div><div>+12V: &nbsp; &nbsp; &nbsp; +=
11.72 V &nbsp;(min =3D &nbsp;+0.00 V, max =3D +14.99 V) &nbsp;&nbsp;</div><=
div>+3.3V: &nbsp; &nbsp; &nbsp; +3.23 V &nbsp;(min =3D &nbsp;+3.13 V, max =
=3D &nbsp;+3.46 V) &nbsp;&nbsp;</div><div>CPU Fan: &nbsp; &nbsp; &nbsp; 0 R=
PM &nbsp;(min =3D &nbsp; &nbsp;0 RPM, div =3D 2)</div>
<div>CPU Temp: &nbsp; &nbsp;-35.5=B0C &nbsp;(high =3D +190.1=B0C, hyst =3D =
-77.5=B0C) &nbsp;</div><div>Int Temp: &nbsp; &nbsp;+51.0=B0C &nbsp;(high =
=3D +204.0=B0C, hyst =3D &nbsp;+0.0=B0C) &nbsp;</div><div>temp3: &nbsp; &nb=
sp; &nbsp; -21.8=B0C &nbsp;(high =3D +64.8=B0C, hyst =3D +60.2=B0C) &nbsp;<=
/div><div>temp4: &nbsp; &nbsp; &nbsp; -25.8=B0C &nbsp;(high =3D +44.7=B0C, =
hyst =3D +39.8=B0C) &nbsp;</div>
<div>cpu0_vid: &nbsp; +1.212 V</div><div><br></div><div><br></div><div><div=
>root@nimbus:/sys/class/hwmon/hwmon0/device# grep &quot;&quot; /sys/class/h=
wmon/hwmon*/device/*</div><div>/sys/class/hwmon/hwmon0/device/alarms:4608</=
div>
<div>/sys/class/hwmon/hwmon0/device/cpu0_vid:1212</div><div>/sys/class/hwmo=
n/hwmon0/device/fan1_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/fan1_=
div:2</div><div>/sys/class/hwmon/hwmon0/device/fan1_input:0</div><div>/sys/=
class/hwmon/hwmon0/device/fan1_min:0</div>
<div>/sys/class/hwmon/hwmon0/device/fan2_alarm:0</div><div>/sys/class/hwmon=
/hwmon0/device/fan2_div:2</div><div>/sys/class/hwmon/hwmon0/device/fan2_inp=
ut:0</div><div>/sys/class/hwmon/hwmon0/device/fan2_min:0</div><div>/sys/cla=
ss/hwmon/hwmon0/device/in2_alarm:0</div>
<div>/sys/class/hwmon/hwmon0/device/in2_input:981</div><div>/sys/class/hwmo=
n/hwmon0/device/in2_max:2630</div><div>/sys/class/hwmon/hwmon0/device/in2_m=
in:0</div><div>/sys/class/hwmon/hwmon0/device/in3_alarm:0</div><div>/sys/cl=
ass/hwmon/hwmon0/device/in3_input:1931</div>
<div>/sys/class/hwmon/hwmon0/device/in3_max:2630</div><div>/sys/class/hwmon=
/hwmon0/device/in3_min:0</div><div>/sys/class/hwmon/hwmon0/device/in4_alarm=
:0</div><div>/sys/class/hwmon/hwmon0/device/in4_input:2056</div><div>/sys/c=
lass/hwmon/hwmon0/device/in4_max:2630</div>
<div>/sys/class/hwmon/hwmon0/device/in4_min:0</div><div>/sys/class/hwmon/hw=
mon0/device/in5_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/in5_input:=
3233</div><div>/sys/class/hwmon/hwmon0/device/in5_max:3465</div><div>/sys/c=
lass/hwmon/hwmon0/device/in5_min:3133</div>
<div>/sys/class/hwmon/hwmon0/device/modalias:platform:vt1211</div><div>/sys=
/class/hwmon/hwmon0/device/name:vt1211</div><div>/sys/class/hwmon/hwmon0/de=
vice/pwm1:255</div><div>/sys/class/hwmon/hwmon0/device/pwm1_auto_channels_t=
emp:1</div>
<div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm:0</div><div>/sys/c=
lass/hwmon/hwmon0/device/pwm1_auto_point1_temp:0</div><div>/sys/class/hwmon=
/hwmon0/device/pwm1_auto_point2_pwm:255</div><div>/sys/class/hwmon/hwmon0/d=
evice/pwm1_auto_point2_temp:0</div>
<div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:255</div><div>/sys=
/class/hwmon/hwmon0/device/pwm1_auto_point3_temp:0</div><div>/sys/class/hwm=
on/hwmon0/device/pwm1_auto_point4_pwm:255</div><div>/sys/class/hwmon/hwmon0=
/device/pwm1_auto_point4_temp:0</div>
<div>/sys/class/hwmon/hwmon0/device/pwm1_enable:2</div><div>/sys/class/hwmo=
n/hwmon0/device/pwm1_freq:45000</div><div>/sys/class/hwmon/hwmon0/device/pw=
m2:255</div><div>/sys/class/hwmon/hwmon0/device/pwm2_auto_channels_temp:1</=
div>
<div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm:0</div><div>/sys/c=
lass/hwmon/hwmon0/device/pwm2_auto_point1_temp:0</div><div>/sys/class/hwmon=
/hwmon0/device/pwm2_auto_point2_pwm:255</div><div>/sys/class/hwmon/hwmon0/d=
evice/pwm2_auto_point2_temp:0</div>
<div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255</div><div>/sys=
/class/hwmon/hwmon0/device/pwm2_auto_point3_temp:0</div><div>/sys/class/hwm=
on/hwmon0/device/pwm2_auto_point4_pwm:255</div><div>/sys/class/hwmon/hwmon0=
/device/pwm2_auto_point4_temp:0</div>
<div>/sys/class/hwmon/hwmon0/device/pwm2_enable:0</div><div>/sys/class/hwmo=
n/hwmon0/device/pwm2_freq:45000</div><div>/sys/class/hwmon/hwmon0/device/te=
mp1_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/temp1_input:40000</div=
>
<div>/sys/class/hwmon/hwmon0/device/temp1_max:255000</div><div>/sys/class/h=
wmon/hwmon0/device/temp1_max_hyst:0</div><div>/sys/class/hwmon/hwmon0/devic=
e/temp2_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/temp2_input:51000<=
/div>
<div>/sys/class/hwmon/hwmon0/device/temp2_max:204000</div><div>/sys/class/h=
wmon/hwmon0/device/temp2_max_hyst:0</div><div>/sys/class/hwmon/hwmon0/devic=
e/temp3_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/temp3_input:1970</=
div>
<div>/sys/class/hwmon/hwmon0/device/temp3_max:450</div><div>/sys/class/hwmo=
n/hwmon0/device/temp3_max_hyst:503</div><div>/sys/class/hwmon/hwmon0/device=
/temp4_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/temp4_input:2011</d=
iv>
<div>/sys/class/hwmon/hwmon0/device/temp4_max:723</div><div>/sys/class/hwmo=
n/hwmon0/device/temp4_max_hyst:807</div><div>/sys/class/hwmon/hwmon0/device=
/uevent:DRIVER=3Dvt1211</div><div>/sys/class/hwmon/hwmon0/device/uevent:MOD=
ALIAS=3Dplatform:vt1211</div>
<div>/sys/class/hwmon/hwmon0/device/vrm:13</div><div></div></div></div></di=
v></blockquote><div><br><br>Thanks but you haven&#39;t answered my first qu=
estion. Did you read the documentation?<br><br>...juerg<br><br><br></div>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div style=3D""><=
div><div><div><br></div></div><div class=3D"Ih2E3d"><div><br></div><blockqu=
ote type=3D"cite">
<div class=3D"gmail_quote"><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;"><br> Sergio Bruder<br> <br> ______________________=
_________________________<br>
 lm-sensors mailing list<br> <a href=3D"mailto:lm-sensors@lm-sensors.org" t=
arget=3D"_blank">lm-sensors@lm-sensors.org</a><br> <a href=3D"http://lists.=
lm-sensors.org/mailman/listinfo/lm-sensors" target=3D"_blank">http://lists.=
lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
 </blockquote></div><br></blockquote></div></div><br></div></blockquote></d=
iv><br>

------=_Part_21017_18249477.1212522487390--


--===============1822760420867253515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1822760420867253515==--
