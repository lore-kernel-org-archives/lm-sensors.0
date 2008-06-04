From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 04 Jun 2008 21:31:40 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <191fb4ca0806041431v9be7de3w211884d6758b5b31@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_3305_11466360.1212615100237"
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
To: lm-sensors@vger.kernel.org

------=_Part_3305_11466360.1212615100237
Content-Type: multipart/alternative; 
	boundary="----=_Part_3306_20219601.1212615100238"

------=_Part_3306_20219601.1212615100238
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sergio,


On Mon, Jun 2, 2008 at 10:31 PM, Sergio Bruder <sergio@bruder.com.br> wrote=
:
>>
>>> What is the temperature that are controlling the fan auto control?
>>>
>>
>> Have you read Documentation/hwmon/vt1211 in the kernel source tree? Can
>> you send the output of 'sensors' and 'grep "" /sys/class/hwmon*/device/*=
''?
>>
>> grep ""/sys/class/hwmon/hwmon*/device/*.
>>
>>
>>
>> ...juerg
>>
>>
>> root@nimbus:/etc# sensors
>> vt1211-isa-6000
>> Adapter: ISA adapter
>> VCore:       +0.98 V  (min =3D  +0.00 V, max =3D  +2.63 V)
>> +5V:         +4.63 V  (min =3D  +0.00 V, max =3D  +6.31 V)
>> +12V:       +11.72 V  (min =3D  +0.00 V, max =3D +14.99 V)
>> +3.3V:       +3.23 V  (min =3D  +3.13 V, max =3D  +3.46 V)
>> CPU Fan:       0 RPM  (min =3D    0 RPM, div =3D 2)
>> CPU Temp:    -35.5=B0C  (high =3D +190.1=B0C, hyst =3D -77.5=B0C)
>> Int Temp:    +51.0=B0C  (high =3D +204.0=B0C, hyst =3D  +0.0=B0C)
>> temp3:       -21.8=B0C  (high =3D +64.8=B0C, hyst =3D +60.2=B0C)
>> temp4:       -25.8=B0C  (high =3D +44.7=B0C, hyst =3D +39.8=B0C)
>> cpu0_vid:   +1.212 V
>>
>>
>> root@nimbus:/sys/class/hwmon/hwmon0/device# grep ""
>> /sys/class/hwmon/hwmon*/device/*
>> /sys/class/hwmon/hwmon0/device/alarms:4608
>> /sys/class/hwmon/hwmon0/device/cpu0_vid:1212
>> /sys/class/hwmon/hwmon0/device/fan1_alarm:0
>> /sys/class/hwmon/hwmon0/device/fan1_div:2
>> /sys/class/hwmon/hwmon0/device/fan1_input:0
>> /sys/class/hwmon/hwmon0/device/fan1_min:0
>> /sys/class/hwmon/hwmon0/device/fan2_alarm:0
>> /sys/class/hwmon/hwmon0/device/fan2_div:2
>> /sys/class/hwmon/hwmon0/device/fan2_input:0
>> /sys/class/hwmon/hwmon0/device/fan2_min:0
>> /sys/class/hwmon/hwmon0/device/in2_alarm:0
>> /sys/class/hwmon/hwmon0/device/in2_input:981
>> /sys/class/hwmon/hwmon0/device/in2_max:2630
>> /sys/class/hwmon/hwmon0/device/in2_min:0
>> /sys/class/hwmon/hwmon0/device/in3_alarm:0
>> /sys/class/hwmon/hwmon0/device/in3_input:1931
>> /sys/class/hwmon/hwmon0/device/in3_max:2630
>> /sys/class/hwmon/hwmon0/device/in3_min:0
>> /sys/class/hwmon/hwmon0/device/in4_alarm:0
>> /sys/class/hwmon/hwmon0/device/in4_input:2056
>> /sys/class/hwmon/hwmon0/device/in4_max:2630
>> /sys/class/hwmon/hwmon0/device/in4_min:0
>> /sys/class/hwmon/hwmon0/device/in5_alarm:0
>> /sys/class/hwmon/hwmon0/device/in5_input:3233
>> /sys/class/hwmon/hwmon0/device/in5_max:3465
>> /sys/class/hwmon/hwmon0/device/in5_min:3133
>> /sys/class/hwmon/hwmon0/device/modalias:platform:vt1211
>> /sys/class/hwmon/hwmon0/device/name:vt1211
>> /sys/class/hwmon/hwmon0/device/pwm1:255
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_channels_temp:1
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm:0
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm:255
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point2_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:255
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point3_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point4_pwm:255
>> /sys/class/hwmon/hwmon0/device/pwm1_auto_point4_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm1_enable:2
>> /sys/class/hwmon/hwmon0/device/pwm1_freq:45000
>> /sys/class/hwmon/hwmon0/device/pwm2:255
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_channels_temp:1
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm:0
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point1_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point2_pwm:255
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point2_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point3_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point4_pwm:255
>> /sys/class/hwmon/hwmon0/device/pwm2_auto_point4_temp:0
>> /sys/class/hwmon/hwmon0/device/pwm2_enable:0
>> /sys/class/hwmon/hwmon0/device/pwm2_freq:45000
>> /sys/class/hwmon/hwmon0/device/temp1_alarm:0
>> /sys/class/hwmon/hwmon0/device/temp1_input:40000
>> /sys/class/hwmon/hwmon0/device/temp1_max:255000
>> /sys/class/hwmon/hwmon0/device/temp1_max_hyst:0
>> /sys/class/hwmon/hwmon0/device/temp2_alarm:0
>> /sys/class/hwmon/hwmon0/device/temp2_input:51000
>> /sys/class/hwmon/hwmon0/device/temp2_max:204000
>> /sys/class/hwmon/hwmon0/device/temp2_max_hyst:0
>> /sys/class/hwmon/hwmon0/device/temp3_alarm:0
>> /sys/class/hwmon/hwmon0/device/temp3_input:1970
>> /sys/class/hwmon/hwmon0/device/temp3_max:450
>> /sys/class/hwmon/hwmon0/device/temp3_max_hyst:503
>> /sys/class/hwmon/hwmon0/device/temp4_alarm:0
>> /sys/class/hwmon/hwmon0/device/temp4_input:2011
>> /sys/class/hwmon/hwmon0/device/temp4_max:723
>> /sys/class/hwmon/hwmon0/device/temp4_max_hyst:807
>> /sys/class/hwmon/hwmon0/device/uevent:DRIVER=3Dvt1211
>> /sys/class/hwmon/hwmon0/device/uevent:MODALIAS=3Dplatform:vt1211
>> /sys/class/hwmon/hwmon0/device/vrm:13
>>
>
>
> Thanks but you haven't answered my first question. Did you read the
> documentation?
>
>
> yes, but I dont understand which temperature governs the autocontrol.
>

pwmX controls fanX. pwmX_auto_channels_temp is used to map a temp input to =
a
pwm output for the auto controller. It's a bit map i.e.:
pwmX_auto_channels_temp =3D=3D 1 -> temp1 controls pwmX
pwmX_auto_channels_temp =3D=3D 2 -> temp2 controls pwmX
pwmX_auto_channels_temp =3D=3D 4 -> temp3 controls pwmX
pwmX_auto_channels_temp =3D=3D 8 -> temp4 controls pwmX
aso


"Be aware that automatic mode hasn't been
> tested very well (due to the fact that my EPIA M10000 doesn't have the fa=
ns
> connected to the PWM outputs of the VT1211 :-()."
>
> You mean, hardware wise you cant control it? But in my case, that doing a
> echo 2 > pwm1_enable just stops the fan?
>

Yes HW wise. The PWM outputs on the M10000 are not connected and the fans
are always blasting away at full speed. I hacked the board up so that the
case fan is now controlled by the vt1211 so I can do some limited testing.
Fan inputs however are connected so I can read RPMs.




> vt1211 here can read fan's RPM:
>
> root@nimbus:~# sensors | grep Fan
> CPU Fan:    3244 RPM  (min =3D    0 RPM, div =3D 2)
>
> "There is only a single controller that controls both PWM outputs but eac=
h
> PWM output can be individually enabled and disabled."
>
> So, which temperature governs the fan speed control? Its just not clear.
>

Now a couple of things:
1) The temp conversion for the C7 is currently not correct as you might hav=
e
guessed from the -35C output :-) The only valid temp is temp2 (vt1211
internal) as the conversion is always the same and done by the driver
itself. The C7 is supposed to have another internal temp diode that can be
read via SW which I'm hopping we can use to determine the somewhat correct
formula for the vt1211 CPU temp reading. Can you run the attached cpuid
program and send me the output?
2) Can you turn the fan on and send another output of 'grep ""
/sys/class/hwmon/hwmon*/device/*' so that I can see where the Fan is
connected to?
3) What is the rev of your vt1211? It's printed in the kernel log during
module load. Your board is the first that I see that actually has the vt121=
1
controlling the Fans. Interesting.
4) Can you try to manually control the fans? Write 1 to pwmX_enable (where =
X
is the number of the pwm controller that controls the CPU fan). And then tr=
y
writing different values in the range 0-255 to pwmX. The fan RPMs hopefully
change accordingly.

Let's try to get the temp readings somewhat correct before we dive into PWM
auto control.

Thanks
...juerg



>
> ...juerg
>
>
>

------=_Part_3306_20219601.1212615100238
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sergio,<br><br><br><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;"><div style=3D""><div><div><div class=3D"Wj3=
C7c"><blockquote type=3D"cite">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;"><div><div><blockquote type=3D"cite"><div class=3D"gmail_quote"><d=
iv>On Mon, Jun 2, 2008 at 10:31 PM, Sergio Bruder &lt;<a href=3D"mailto:ser=
gio@bruder.com.br" target=3D"_blank">sergio@bruder.com.br</a>&gt; wrote:</d=
iv>
 <div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> What is th=
e temperature that are controlling the fan auto control?<br> </blockquote> =
<div>
<br>Have you read Documentation/hwmon/vt1211 in the kernel source tree? Can=
 you send the output of &#39;sensors&#39; and &#39;grep &quot;&quot; /sys/c=
lass/hwmon*/device/*&#39;&#39;?</div></div></div></blockquote>grep &quot;&q=
uot;/sys/class/hwmon/hwmon*/device/*.&nbsp;<br>
 <blockquote type=3D"cite"><div class=3D"gmail_quote"><div><br>&nbsp;<br>..=
.juerg<br> <br></div></div></blockquote><div><br></div><div>root@nimbus:/et=
c# sensors</div><div>vt1211-isa-6000</div><div>Adapter: ISA adapter</div><d=
iv>VCore: &nbsp; &nbsp; &nbsp; +0.98 V &nbsp;(min =3D &nbsp;+0.00 V, max =
=3D &nbsp;+2.63 V) &nbsp;&nbsp;</div>
 <div>+5V: &nbsp; &nbsp; &nbsp; &nbsp; +4.63 V &nbsp;(min =3D &nbsp;+0.00 V=
, max =3D &nbsp;+6.31 V) &nbsp;&nbsp;</div><div>+12V: &nbsp; &nbsp; &nbsp; =
+11.72 V &nbsp;(min =3D &nbsp;+0.00 V, max =3D +14.99 V) &nbsp;&nbsp;</div>=
<div>+3.3V: &nbsp; &nbsp; &nbsp; +3.23 V &nbsp;(min =3D &nbsp;+3.13 V, max =
=3D &nbsp;+3.46 V) &nbsp;&nbsp;</div><div>CPU Fan: &nbsp; &nbsp; &nbsp; 0 R=
PM &nbsp;(min =3D &nbsp; &nbsp;0 RPM, div =3D 2)</div>
 <div>CPU Temp: &nbsp; &nbsp;-35.5=B0C &nbsp;(high =3D +190.1=B0C, hyst =3D=
 -77.5=B0C) &nbsp;</div><div>Int Temp: &nbsp; &nbsp;+51.0=B0C &nbsp;(high =
=3D +204.0=B0C, hyst =3D &nbsp;+0.0=B0C) &nbsp;</div><div>temp3: &nbsp; &nb=
sp; &nbsp; -21.8=B0C &nbsp;(high =3D +64.8=B0C, hyst =3D +60.2=B0C) &nbsp;<=
/div><div>temp4: &nbsp; &nbsp; &nbsp; -25.8=B0C &nbsp;(high =3D +44.7=B0C, =
hyst =3D +39.8=B0C) &nbsp;</div>
 <div>cpu0_vid: &nbsp; +1.212 V</div><div><br></div><div><br></div><div><di=
v>root@nimbus:/sys/class/hwmon/hwmon0/device# grep &quot;&quot; /sys/class/=
hwmon/hwmon*/device/*</div><div>/sys/class/hwmon/hwmon0/device/alarms:4608<=
/div>
 <div>/sys/class/hwmon/hwmon0/device/cpu0_vid:1212</div><div>/sys/class/hwm=
on/hwmon0/device/fan1_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/fan1=
_div:2</div><div>/sys/class/hwmon/hwmon0/device/fan1_input:0</div><div>
/sys/class/hwmon/hwmon0/device/fan1_min:0</div> <div>/sys/class/hwmon/hwmon=
0/device/fan2_alarm:0</div><div>/sys/class/hwmon/hwmon0/device/fan2_div:2</=
div><div>/sys/class/hwmon/hwmon0/device/fan2_input:0</div><div>/sys/class/h=
wmon/hwmon0/device/fan2_min:0</div>
<div>/sys/class/hwmon/hwmon0/device/in2_alarm:0</div> <div>/sys/class/hwmon=
/hwmon0/device/in2_input:981</div><div>/sys/class/hwmon/hwmon0/device/in2_m=
ax:2630</div><div>/sys/class/hwmon/hwmon0/device/in2_min:0</div><div>/sys/c=
lass/hwmon/hwmon0/device/in3_alarm:0</div>
<div>/sys/class/hwmon/hwmon0/device/in3_input:1931</div> <div>/sys/class/hw=
mon/hwmon0/device/in3_max:2630</div><div>/sys/class/hwmon/hwmon0/device/in3=
_min:0</div><div>/sys/class/hwmon/hwmon0/device/in4_alarm:0</div><div>/sys/=
class/hwmon/hwmon0/device/in4_input:2056</div>
<div>/sys/class/hwmon/hwmon0/device/in4_max:2630</div> <div>/sys/class/hwmo=
n/hwmon0/device/in4_min:0</div><div>/sys/class/hwmon/hwmon0/device/in5_alar=
m:0</div><div>/sys/class/hwmon/hwmon0/device/in5_input:3233</div><div>/sys/=
class/hwmon/hwmon0/device/in5_max:3465</div>
<div>/sys/class/hwmon/hwmon0/device/in5_min:3133</div> <div>/sys/class/hwmo=
n/hwmon0/device/modalias:platform:vt1211</div><div>/sys/class/hwmon/hwmon0/=
device/name:vt1211</div><div>/sys/class/hwmon/hwmon0/device/pwm1:255</div>
<div>/sys/class/hwmon/hwmon0/device/pwm1_auto_channels_temp:1</div> <div>/s=
ys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm:0</div><div>/sys/class/hw=
mon/hwmon0/device/pwm1_auto_point1_temp:0</div><div>/sys/class/hwmon/hwmon0=
/device/pwm1_auto_point2_pwm:255</div>
<div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_temp:0</div> <div>/sys=
/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:255</div><div>/sys/class/hw=
mon/hwmon0/device/pwm1_auto_point3_temp:0</div><div>/sys/class/hwmon/hwmon0=
/device/pwm1_auto_point4_pwm:255</div>
<div>/sys/class/hwmon/hwmon0/device/pwm1_auto_point4_temp:0</div> <div>/sys=
/class/hwmon/hwmon0/device/pwm1_enable:2</div><div>/sys/class/hwmon/hwmon0/=
device/pwm1_freq:45000</div><div>/sys/class/hwmon/hwmon0/device/pwm2:255</d=
iv>
<div>/sys/class/hwmon/hwmon0/device/pwm2_auto_channels_temp:1</div> <div>/s=
ys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm:0</div><div>/sys/class/hw=
mon/hwmon0/device/pwm2_auto_point1_temp:0</div><div>/sys/class/hwmon/hwmon0=
/device/pwm2_auto_point2_pwm:255</div>
<div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_temp:0</div> <div>/sys=
/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255</div><div>/sys/class/hw=
mon/hwmon0/device/pwm2_auto_point3_temp:0</div><div>/sys/class/hwmon/hwmon0=
/device/pwm2_auto_point4_pwm:255</div>
<div>/sys/class/hwmon/hwmon0/device/pwm2_auto_point4_temp:0</div> <div>/sys=
/class/hwmon/hwmon0/device/pwm2_enable:0</div><div>/sys/class/hwmon/hwmon0/=
device/pwm2_freq:45000</div><div>/sys/class/hwmon/hwmon0/device/temp1_alarm=
:0</div>
<div>/sys/class/hwmon/hwmon0/device/temp1_input:40000</div> <div>/sys/class=
/hwmon/hwmon0/device/temp1_max:255000</div><div>/sys/class/hwmon/hwmon0/dev=
ice/temp1_max_hyst:0</div><div>/sys/class/hwmon/hwmon0/device/temp2_alarm:0=
</div>
<div>/sys/class/hwmon/hwmon0/device/temp2_input:51000</div> <div>/sys/class=
/hwmon/hwmon0/device/temp2_max:204000</div><div>/sys/class/hwmon/hwmon0/dev=
ice/temp2_max_hyst:0</div><div>/sys/class/hwmon/hwmon0/device/temp3_alarm:0=
</div>
<div>/sys/class/hwmon/hwmon0/device/temp3_input:1970</div> <div>/sys/class/=
hwmon/hwmon0/device/temp3_max:450</div><div>/sys/class/hwmon/hwmon0/device/=
temp3_max_hyst:503</div><div>/sys/class/hwmon/hwmon0/device/temp4_alarm:0</=
div>
<div>/sys/class/hwmon/hwmon0/device/temp4_input:2011</div> <div>/sys/class/=
hwmon/hwmon0/device/temp4_max:723</div><div>/sys/class/hwmon/hwmon0/device/=
temp4_max_hyst:807</div><div>/sys/class/hwmon/hwmon0/device/uevent:DRIVER=
=3Dvt1211</div>
<div>/sys/class/hwmon/hwmon0/device/uevent:MODALIAS=3Dplatform:vt1211</div>=
 <div>/sys/class/hwmon/hwmon0/device/vrm:13</div><div></div></div></div></d=
iv></blockquote><div><br><br>Thanks but you haven&#39;t answered my first q=
uestion. Did you read the documentation?</div>
</div></blockquote><br></div></div>yes, but I dont understand which tempera=
ture governs the autocontrol.</div><div></div></div></blockquote><div><br>p=
wmX controls fanX. pwmX_auto_channels_temp is used to map a temp input to a=
 pwm output for the auto controller. It&#39;s a bit map i.e.:<br>
pwmX_auto_channels_temp =3D=3D 1 -&gt; temp1 controls pwmX<br>pwmX_auto_cha=
nnels_temp =3D=3D 2 -&gt; temp2 controls pwmX<br>
pwmX_auto_channels_temp =3D=3D 4 -&gt; temp3 controls pwmX<br>
pwmX_auto_channels_temp =3D=3D 8 -&gt; temp4 controls pwmX<br>
aso<br><br><br></div><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;"><div style=3D""><div><div>&quot;Be aware that automatic mode hasn&#39;t=
 been</div>
<div>tested very well (due to the fact that my EPIA M10000 doesn&#39;t have=
 the fans</div><div>connected to the PWM outputs of the VT1211 :-().&quot;<=
/div><div><br></div><div>You mean, hardware wise you cant control it? But i=
n my case, that doing a&nbsp;</div>
<div>echo 2 &gt; pwm1_enable just stops the fan?</div></div></div></blockqu=
ote><div><br>Yes HW wise. The PWM outputs on the M10000 are not connected a=
nd the fans are always blasting away at full speed. I hacked the board up s=
o that the case fan is now controlled by the vt1211 so I can do some limite=
d testing. Fan inputs however are connected so I can read RPMs.<br>
<br><br>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;"><div style=3D""><div><div></div></div><div>vt1211 here can read fan&#39;=
s RPM:</div>
<div><br></div><div><div>root@nimbus:~# sensors | grep Fan</div><div>CPU Fa=
n: &nbsp; &nbsp;3244 RPM &nbsp;(min =3D &nbsp; &nbsp;0 RPM, div =3D 2)</div=
><div><br></div><div>&quot;There is only a single controller that&nbsp;cont=
rols both PWM outputs but each&nbsp;</div>
<div>PWM output can be individually enabled and&nbsp;disabled.&quot;</div><=
div><br></div><div>So, which temperature governs the fan speed control? Its=
 just not clear.</div></div></div></blockquote><div><br>Now a couple of thi=
ngs:<br>
1) The temp conversion for the C7 is currently not correct as you might hav=
e guessed from the -35C output :-) The only valid temp is temp2 (vt1211 int=
ernal) as the conversion is always the same and done by the driver itself. =
The C7 is supposed to have another internal temp diode that can be read via=
 SW which I&#39;m hopping we can use to determine the somewhat correct form=
ula for the vt1211 CPU temp reading. Can you run the attached cpuid program=
 and send me the output?<br>
2) Can you turn the fan on and send another output of &#39;grep &quot;&quot=
; /sys/class/hwmon/hwmon*/device/*&#39; so that I can see where the Fan is =
connected to?<br>3) What is the rev of your vt1211? It&#39;s printed in the=
 kernel log during module load. Your board is the first that I see that act=
ually has the vt1211 controlling the Fans. Interesting. <br>
4) Can you try to manually control the fans? Write 1 to pwmX_enable (where =
X is the number of the pwm controller that controls the CPU fan). And then =
try writing different values in the range 0-255 to pwmX. The fan RPMs hopef=
ully change accordingly.<br>
<br>Let&#39;s try to get the temp readings somewhat correct before we dive =
into PWM auto control.<br><br>Thanks<br>...juerg<br><br>&nbsp;</div><blockq=
uote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 20=
4); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div style=3D""><div><div></div><blockquote type=3D"cite"><div class=3D"gma=
il_quote"><div><br>...juerg<br></div></div></blockquote></div><br></div></b=
lockquote></div><br>

------=_Part_3306_20219601.1212615100238--

------=_Part_3305_11466360.1212615100237
Content-Type: application/octet-stream; name=cpuid
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fh2ehdli0
Content-Disposition: attachment; filename=cpuid

f0VMRgEBAQAAAAAAAAAAAAIAAwABAAAAgIMECDQAAADgRAAAAAAAADQAIAAHACgAIgAfAAYAAAA0
AAAANIAECDSABAjgAAAA4AAAAAUAAAAEAAAAAwAAABQBAAAUgQQIFIEECBMAAAATAAAABAAAAAEA
AAABAAAAAAAAAACABAgAgAQIIDgAACA4AAAFAAAAABAAAAEAAAAgOAAAIMgECCDIBAhABAAASAQA
AAYAAAAAEAAAAgAAADQ4AAA0yAQINMgECMgAAADIAAAABgAAAAQAAAAEAAAAKAEAACiBBAgogQQI
IAAAACAAAAAEAAAABAAAAFHldGQAAAAAAAAAAAAAAAAAAAAAAAAAAAYAAAAEAAAAL2xpYi9sZC1s
aW51eC5zby4yAAAEAAAAEAAAAAEAAABHTlUAAAAAAAIAAAAEAAAAAQAAAAMAAAAJAAAACAAAAAQA
AAAHAAAAAAAAAAAAAAAAAAAAAQAAAAIAAAAAAAAAAwAAAAUAAAAGAAAAAAAAAAAAAAAAAAAAAAAA
ABoAAAAAAAAA+gAAABIAAAAwAAAAAAAAAH8BAAASAAAAKQAAAGDMBAgEAAAAEQAXAE0AAAAAAAAA
5wAAABIAAAAiAAAAAAAAADkAAAASAAAANQAAAAAAAADnAAAAEgAAAD4AAAAEnAQIBAAAABEADgAB
AAAAAAAAAAAAAAAgAAAAAF9fZ21vbl9zdGFydF9fAGxpYmMuc28uNgBwdXRjaGFyAHByaW50ZgBz
dGRvdXQAcHV0cwBfSU9fcHV0YwBfSU9fc3RkaW5fdXNlZABfX2xpYmNfc3RhcnRfbWFpbgBHTElC
Q18yLjAAAAAAAgACAAIAAgACAAIAAQAAAAEAAQAQAAAAEAAAAAAAAAAQaWkNAAACAF8AAAAAAAAA
/MgECAYIAABgzAQIBQMAAAzJBAgHAQAAEMkECAcCAAAUyQQIBwQAABjJBAgHBQAAHMkECAcGAAAg
yQQIBwgAAFWJ5YPsCOitAAAA6AQBAADorxgAAMnDAP81BMkECP8lCMkECAAAAAD/JQzJBAhoAAAA
AOng/////yUQyQQIaAgAAADp0P////8lFMkECGgQAAAA6cD/////JRjJBAhoGAAAAOmw/////yUc
yQQIaCAAAADpoP////8lIMkECGgoAAAA6ZD///8AAAAAAAAAAAAAAAAx7V6J4YPk8FBUUmgAmwQI
aFCbBAhRVmjgmAQI6JP////0kJBVieVTg+wE6AAAAABbgcNQRQAAi5P8////hdJ0Beie////WFvJ
w5CQkJCQkFWJ5YPsCIA9ZMwECAB0DOscg8AEo0jJBAj/0qFIyQQIixCF0nXrxgVkzAQIAcnDkFWJ
5YPsCKEwyAQIhcB0ErgAAAAAhcB0CccEJDDIBAj/0MnDkJCQkJCQkJCQkJCQkFWJ5Q+2RQiD+HB0
B4PAgHQPXcPHRQgInAQIXenU/v//x0UINJwECF3px/7//412AFWJ5VOD7BQPtl0Ihdt1BoPEFFtd
w4lcJATHBCSMqwQI6L/+//+B+4UAAAB3B/8knWi1BAjHRQiTqwQIg8QUW13pf/7//8dFCGScBAiD
xBRbXelu/v//x0UI+KMECIPEFFtd6V3+///HRQi8owQIg8QUW13pTP7//8dFCICjBAiDxBRbXek7
/v//x0UIRKMECIPEFFtd6Sr+///HRQgAowQIg8QUW13pGf7//8dFCLiiBAiDxBRbXekI/v//x0UI
cKIECIPEFFtd6ff9///HRQgoogQIg8QUW13p5v3//8dFCPyhBAiDxBRbXenV/f//x0UI0KEECIPE
FFtd6cT9///HRQikoQQIg8QUW13ps/3//8dFCGShBAiDxBRbXemi/f//x0UIJKEECIPEFFtd6ZH9
///HRQjkoAQIg8QUW13pgP3//8dFCLigBAiDxBRbXelv/f//x0UIjKAECIPEFFtd6V79///HRQhk
oAQIg8QUW13pTf3//8dFCCygBAiDxBRbXek8/f//x0UI9J8ECIPEFFtd6Sv9///HRQi8nwQIg8QU
W13pGv3//8dFCICfBAiDxBRbXekJ/f//x0UIRJ8ECIPEFFtd6fj8///HRQgInwQIg8QUW13p5/z/
/8dFCMyeBAiDxBRbXenW/P//x0UIkJ4ECIPEFFtd6cX8///HRQhIngQIg8QUW13ptPz//8dFCAie
BAiDxBRbXemj/P//x0UIyJ0ECIPEFFtd6ZL8///HRQiAnQQIg8QUW13pgfz//8dFCDidBAiDxBRb
Xelw/P//x0UICJ0ECIPEFFtd6V/8///HRQjUnAQIg8QUW13pTvz//8dFCJycBAiDxBRbXek9/P//
ifaNvCcAAAAAVTHSieVXVlOD7CyLfRCNXeOLdRTGRfMAkI20JgAAAACLRQiNDNUAAAAA0/iIBBqL
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
AAAQD4UkAQAAiXwkBDHbxwQkkq8ECOjJ7f//6w2NdgBDg/sgD4Q+/f//ifiI2dP4qAF07IsEnaDJ
BAiJBCToge3//+vbiwSdYMkECMcEJDOvBAiJRCQE6Ijt///pd////8cEJB+uBAjod+3//412AOnB
/P//xwQkKbEECOhj7f//6bD8//+DfeQID4fY/v//i1Xk/ySV1LcECMcEJEOuBAjoPu3//8cEJAoA
AADoAu3//+mD/v//xwQkSK4ECOgh7f//6+HHBCRNrgQI6BPt///r08cEJFWuBAjoBe3//5DrxMcE
JGGuBAjo9uz//8cEJAoAAADouuz//4tF3McEJGuuBAjB6BQl/wAAAIlEJAToz+z//4td5McEJH+u
BAiJXCQE6Lzs///pO/7//8Ft4BDHBCR0rwQID7ZF4IlEJATon+z//+m//v//i03YxwQkX68ECIlM
JAToh+z//+mb/v//i1XUxwQkFKcECIlUJATob+z//+l4/v//g33kAg+E1wEAAA+O2wAAAIN95AOJ
9g+E1gEAAIN95ASNtgAAAAAPhcL9///HBCRitQQI6DLs///pxAAAAD0DAACAD4Yl/v//xwQkRq8E
CL4CAACA6BHs//+J8EYPoolUJAyJTCQIiVwkBIkEJOik7///gf4FAACAdd/HBCQHsAQI6MTr///p
4v3//8cEJCmuBAjo0+v//+kg+///g33kCA+HSP3//4tN5P8kjfi3BAiF2410JgAPhQD7///HBCQS
rgQI6KLr///p7/r//4tF3McEJPOuBAjB6BCD4A+JRCQE6ITr///pGv3//4N95AEPhfn8///HBCS8
rgQI6Gnr///HBCQKAAAA6C3r///p8/z//8cEJFWuBAjoTOv//+vhxwQkjKYECOg+6///69PHBCTr
rgQI6DDr///rxccEJKymBAjoIuv//+u3xwQk4KYECOgU6///66nHBCTYrgQI6Abr//+J9uuZxwQk
i64ECOj26v//ifbpc/z//8cEJI6uBAjo4+r//+l1////xwQkka4ECOjS6v//6WT////HBCSZrgQI
6MHq///pU////8cEJJyuBAjosOr//+lC////xwQkoK4ECOif6v//6TH////HBCS4rgQI6I7q///p
IP///8cEJMKuBAjofer//+kP////xwQkya4ECOhs6v//6f7+//+NdgCNTCQEg+Tw/3H8McBVieVX
VjH2U1GD7CgPoiX//wAAiUXsxwQkQKcECOgW6v//ifaJ8Il0JARGD6LHBCTerwQIiVQkFIlMJBCJ
XCQMiUQkCOgP6v//OXXsc9a6AAAAgInQD6I9////f4nHdj2+AAAAgOsNkJCQkJCQkJCQkJCQkInw
iXQkBEYPoscEJGynBAiJVCQUiUwkEIlcJAyJRCQI6L/p//8593PXugAAAMCJ0A+iPf///7+Jx3Yu
vgAAAMCJ8Il0JARGD6LHBCRspwQIiVQkFIlMJBCJXCQMiUQkCOh/6f//Ofdz18cEJAoAAADoP+n/
/zHAD6KJTeiJ14nexwQk/K8ECDHb6Fbp//+J9qFgzAQIiNmDwwiJRCQEifDT6IkEJOhK6f//g/sg
deEx2+sNkJCQkJCQkJCQkJCQkKFgzAQIiNmDwwiJRCQEifjT6IkEJOga6f//g/sgdeEx2+sNkJCQ
kJCQkJCQkJCQkKFgzAQIiNmDwwiJRCQEi0Xo0+iJBCTo6ej//4P7IHXgi13sxwQkCbAECIlcJATo
wej//4H+Q3lyaXQqgf5HZW51dDuB/kF1dGh0TMcEJB6wBAjofej//4PEKDHAWVteX12NYfzDi03s
iQwk6KDs//+DxCgxwFlbXl9djWH8w4tF7IkEJOgX9///g8QoMcBZW15fXY1h/MOLVeyJFCToLvD/
/4PEKDHAWVteX12NYfzDVYnlV1ZT6JgAAACBw/UtAACD7AyNgyD///+NuyD///8p+MH4Ao1w/4P+
/3QMjXYA/xS3ToP+/3X3jbQmAAAAAOifAAAAg8QMW15fXcONdgBVieVXVlPoSAAAAIHDpS0AAIPs
DOiD5///jYMg////jZMg////KdDB+AKJRfB0HDH/idaNtgAAAACNvCcAAAAAR/8Wg8YEOX3wdfWD
xAxbXl9dw4scJMOQkJCQkJCQkJBVieVTuyDIBAiD7AShIMgECIP4/3QWjXYAjbwnAAAAAIPrBP/Q
iwOD+P919FhbXZDDkJCQVYnlU4PsBOgAAAAAW4HDEC0AAOjU5///WVvJwwMAAAABAAIAVExCOiAz
MiBlbnRyaWVzIDQtd2F5IGFzc29jaWF0aXZlIDRLQiBwYWdlcwBMMSBDYWNoZTogMTZLQiA0LXdh
eSBhc3NvY2lhdGl2ZSAxNiBieXRlcy9saW5lAABJbnN0cnVjdGlvbiBUTEI6IDRLQiBwYWdlcywg
NC13YXkgc2V0IGFzc29jLCAzMiBlbnRyaWVzAEluc3RydWN0aW9uIFRMQjogNE1CIHBhZ2VzLCA0
LXdheSBzZXQgYXNzb2MsIDIgZW50cmllcwAARGF0YSBUTEI6IDRLQiBwYWdlcywgNC13YXkgc2V0
IGFzc29jLCA2NCBlbnRyaWVzAAAAAERhdGEgVExCOiA0TUIgcGFnZXMsIDQtd2F5IHNldCBhc3Nv
YywgOCBlbnRyaWVzADFzdC1sZXZlbCBpbnN0cnVjdGlvbiBjYWNoZTogOEtCLCA0LXdheSBzZXQg
YXNzb2MsIDMyIGJ5dGUgbGluZSBzaXplAAAAADFzdC1sZXZlbCBpbnN0cnVjdGlvbiBjYWNoZTog
MTZLQiwgNC13YXkgc2V0IGFzc29jLCAzMiBieXRlIGxpbmUgc2l6ZQAAADFzdC1sZXZlbCBkYXRh
IGNhY2hlOiA4S0IsIDItd2F5IHNldCBhc3NvYywgMzIgYnl0ZSBsaW5lIHNpemUAAAAxc3QtbGV2
ZWwgZGF0YSBjYWNoZTogMTZLQiwgNC13YXkgc2V0IGFzc29jLCAzMiBieXRlIGxpbmUgc2l6ZQAA
Tm8gMm5kLWxldmVsIGNhY2hlLCBvciBpZiAybmQtbGV2ZWwgY2FjaGUgZXhpc3RzLCBubyAzcmQt
bGV2ZWwgY2FjaGUAAAAAMm5kLWxldmVsIGNhY2hlOiAxMjhLQiwgNC13YXkgc2V0IGFzc29jLCAz
MiBieXRlIGxpbmUgc2l6ZQAAMm5kLWxldmVsIGNhY2hlOiAyNTZLQiwgNC13YXkgc2V0IGFzc29j
LCAzMiBieXRlIGxpbmUgc2l6ZQAAMm5kLWxldmVsIGNhY2hlOiA1MTJLQiwgNC13YXkgc2V0IGFz
c29jLCAzMiBieXRlIGxpbmUgc2l6ZQAAMm5kLWxldmVsIGNhY2hlOiAxTUIsIDQtd2F5IHNldCBh
c3NvYywgMzIgYnl0ZSBsaW5lIHNpemUAAAAAMm5kLWxldmVsIGNhY2hlOiAyTUIsIDQtd2F5IHNl
dCBhc3NvYywgMzIgYnl0ZSBsaW5lIHNpemUAAAAASW5zdHJ1Y3Rpb24gVExCOiA0S0IgYW5kIDJN
QiBvciA0TUIgcGFnZXMsIDY0IGVudHJpZXMAAABJbnN0cnVjdGlvbiBUTEI6IDRLQiBhbmQgMk1C
IG9yIDRNQiBwYWdlcywgMTI4IGVudHJpZXMAAEluc3RydWN0aW9uIFRMQjogNEtCIGFuZCAyTUIg
b3IgNE1CIHBhZ2VzLCAyNTYgZW50cmllcwAARGF0YSBUTEI6IDRLQiBhbmQgNE1CIHBhZ2VzLCA2
NCBlbnRyaWVzAERhdGEgVExCOiA0S0IgYW5kIDRNQiBwYWdlcywgMTI4IGVudHJpZXMAAAAARGF0
YSBUTEI6IDRLQiBhbmQgNE1CIHBhZ2VzLCAyNTYgZW50cmllcwAAAAAxc3QtbGV2ZWwgZGF0YSBj
YWNoZTogOEtCLCA0LXdheSBzZXQgYXNzb2MsIDY0IGJ5dGUgbGluZSBzaXplAAAAMXN0LWxldmVs
IGRhdGEgY2FjaGU6IDE2S0IsIDQtd2F5IHNldCBhc3NvYywgNjQgYnl0ZSBsaW5lIHNpemUAADFz
dC1sZXZlbCBkYXRhIGNhY2hlOiAzMktCLCA0LXdheSBzZXQgYXNzb2MsIDY0IGJ5dGUgbGluZSBz
aXplAABUcmFjZSBjYWNoZTogMTJLLW1pY3JvLW9wLCA0LXdheSBzZXQgYXNzb2MAAFRyYWNlIGNh
Y2hlOiAxNkstbWljcm8tb3AsIDQtd2F5IHNldCBhc3NvYwAAVHJhY2UgY2FjaGU6IDMySy1taWNy
by1vcCwgNC13YXkgc2V0IGFzc29jAAAybmQtbGV2ZWwgY2FjaGU6IDEyOEtCLCA4LXdheSBzZXQg
YXNzb2MsIHNlY3RvcmVkLCA2NCBieXRlIGxpbmUgc2l6ZQAAAAAybmQtbGV2ZWwgY2FjaGU6IDI1
NktCLCA4LXdheSBzZXQgYXNzb2MsIHNlY3RvcmVkLCA2NCBieXRlIGxpbmUgc2l6ZQAAAAAybmQt
bGV2ZWwgY2FjaGU6IDUxMktCLCA4LXdheSBzZXQgYXNzb2MsIHNlY3RvcmVkLCA2NCBieXRlIGxp
bmUgc2l6ZQAAAAAybmQtbGV2ZWwgY2FjaGU6IDFNQiwgOC13YXkgc2V0IGFzc29jLCBzZWN0b3Jl
ZCwgNjQgYnl0ZSBsaW5lIHNpemUAADJuZC1sZXZlbCBjYWNoZTogMjU2S0IsIDgtd2F5IHNldCBh
c3NvYywgMzIgYnl0ZSBsaW5lIHNpemUAADJuZC1sZXZlbCBjYWNoZTogNTEyS0IsIDgtd2F5IHNl
dCBhc3NvYyAzMiBieXRlIGxpbmUgc2l6ZQAAADJuZC1sZXZlbCBjYWNoZTogMU1CLCA4LXdheSBz
ZXQgYXNzb2MsIDMyIGJ5dGUgbGluZSBzaXplAAAAADJuZC1sZXZlbCBjYWNoZTogMk1CLCA4LXdh
eSBzZXQgYXNzb2MsIDMyIGJ5dGUgbGluZSBzaXplAAAAAGVheCBpbjogMHgleCwgZWF4ID0gJTA4
bHggZWJ4ID0gJTA4bHggZWN4ID0gJTA4bHggZWR4ID0gJTA4bHgKAABBdGhsb24gTVAvTW9iaWxl
IEF0aGxvbiBtb2RlbCA2AFN0YW5kYXJkIGZlYXR1cmUgZmxhZ3MgJTA4bHg6CgAARXh0ZW5kZWQg
ZmVhdHVyZSBmbGFncyAlMDhseDoKAAAgICBEYXRhIFRMQjogYXNzb2NpYXRpdml0eSAlbGQtd2F5
ICNlbnRyaWVzICVsZAoAAAAAICAgSW5zdHJ1Y3Rpb24gVExCOiBhc3NvY2lhdGl2aXR5ICVsZC13
YXkgI2VudHJpZXMgJWxkCgAgICBzaXplICVsZCBLQiBhc3NvY2lhdGl2aXR5ICVseC13YXkgbGlu
ZXMgcGVyIHRhZyAlbGQgbGluZSBzaXplICVsZAoAAAAgICBEYXRhIFRMQjogYXNzb2NpYXRpdml0
eSAlcyAjZW50cmllcyAlbGQKACAgIEluc3RydWN0aW9uIFRMQjogYXNzb2NpYXRpdml0eSAlcyAj
ZW50cmllcyAlbGQKAAAgICBzaXplICVsZCBLQiBhc3NvY2lhdGl2aXR5ICVzIGxpbmVzIHBlciB0
YWcgJWxkIGxpbmUgc2l6ZSAlbGQKAAAAAEFkdmFuY2VkIFBvd2VyIE1hbmFnZW1lbnQgRmVhdHVy
ZSBGbGFncwBNYXhpbXVtIGxpbmVhciBhZGRyZXNzOiAlbGQ7IG1heGltdW0gcGh5cyBhZGRyZXNz
ICVsZAoAAFBlbnRpdW0gSUkgTW9kZWwgNS9YZW9uL0NlbGVyb24AUGVudGl1bSBJSUkvUGVudGl1
bSBJSUkgWGVvbiAtIGV4dGVybmFsIEwyIGNhY2hlAAAAAFBlbnRpdW0gSUlJL1BlbnRpdW0gSUlJ
IFhlb24gLSBpbnRlcm5hbCBMMiBjYWNoZQAAAABDTEZMVVNIIGluc3RydWN0aW9uIGNhY2hlIGxp
bmUgc2l6ZTogJWQKAAAAACBlYXggaW4gICAgZWF4ICAgICAgZWJ4ICAgICAgZWN4ICAgICAgZWR4
AAAAJTA4bHggJTA4bHggJTA4bHggJTA4bHggJTA4bHgKAABJbnRlbCBQZW50aXVtIElJSSBYZW9u
IHByb2Nlc3NvcgAAAABWTUUgICAgVmlydHVhbCA4MDg2IE1vZGUgRW5oYW5jZW1lbnRzAAAATVNS
ICAgIE1vZGVsIFNwZWNpZmljIFJlZ2lzdGVycwBQQUUgICAgUGh5c2ljYWwgQWRkcmVzcyBFeHRl
bnNpb24AAABNQ0UgICAgTWFjaGluZSBDaGVjayBFeGNlcHRpb24AAEFQSUMgICBPbi1jaGlwIEFk
dmFuY2VkIFByb2dyYW1tYWJsZSBJbnRlcnJ1cHQgQ29udHJvbGxlciBwcmVzZW50IGFuZCBlbmFi
bGVkAAAATVRSUiAgIE1lbW9yeSBUeXBlIFJhbmdlIFJlZ2lzdGVycwAATUNBICAgIE1hY2hpbmUg
Q2hlY2sgQXJjaGl0ZWN0dXJlAAAAQ01PViAgIENvbmRpdGlvbmFsIE1vdmUgYW5kIENvbXBhcmUg
SW5zdHJ1Y3Rpb25zAAAAAFBTRS0zNiAzNi1iaXQgUGFnZSBTaXplIEV4dGVuc2lvbgAAAFBOICAg
ICBQcm9jZXNzb3IgU2VyaWFsIE51bWJlciBwcmVzZW50IGFuZCBlbmFibGVkAABBQ1BJICAgVGhl
cm1hbCBNb25pdG9yIGFuZCBDbG9jayBDdHJsAAAARlhTUiAgIEZhc3QgRlAvTU1YIFN0cmVhbWlu
ZyBTSU1EIEV4dGVuc2lvbnMgc2F2ZS9yZXN0b3JlAAAAU1NFICAgIFN0cmVhbWluZyBTSU1EIEV4
dGVuc2lvbnMgaW5zdHJ1Y3Rpb24gc2V0AAAAAFRpbWUgU3RhbXAgQ291bnRlciAod2l0aCBSRFRT
QyBhbmQgQ1I0IGRpc2FibGUgYml0KQBNb2RlbCBTcGVjaWZpYyBSZWdpc3RlcnMgd2l0aCBSRE1T
UiAmIFdSTVNSAFNZU0NBTEwvU1lTUkVUIG9yIFNZU0VOVEVSL1NZU0VYSVQgaW5zdHJ1Y3Rpb25z
AE1UUlIgLSBNZW1vcnkgVHlwZSBSYW5nZSBSZWdpc3RlcnMAAEFNRCBNTVggSW5zdHJ1Y3Rpb24g
RXh0ZW5zaW9ucwAAUkRNU1IvV1JNU1IgKE1vZGVsIFNwZWNpZmljIFJlZ2lzdGVycykAAEFQSUMg
LSBPbi1jaGlwIEFkdmFuY2VkIFByb2dyYW1tYWJsZSBJbnRlcnJ1cHQgQ29udHJvbGxlciBwcmVz
ZW50IGFuZCBlbmFibGVkAAAATVRSUiAgTWVtb3J5IFR5cGUgUmFuZ2UgUmVnaXN0ZXJzAAAAQ01P
ViAgQ29uZGl0aW9uYWwgTW92ZSBJbnN0cnVjdGlvbgAAJTAyeDogAHVua25vd24gVExCL2NhY2hl
IGRlc2NyaXB0b3IAJXMAQ3lyaXgtc3BlY2lmaWMgZnVuY3Rpb25zAEZhbWlseTogJWQgTW9kZWw6
ICVkIFsATWVkaWFHWAA2eDg2AEJYbQA2eDg2L01YAApFeHRlbmRlZCBpbmZvOgA2eDg2L0dYbQBF
eHRlbmRlZCBmZWF0dXJlIGZsYWdzOgBQcm9jZXNzb3IgbmFtZSBzdHJpbmc6IABBTUQtc3BlY2lm
aWMgZnVuY3Rpb25zAFZlcnNpb24gJTA4bHg6CgA0ODYgbW9kZWwgJWQASzYgTW9kZWwgJWQASzYt
MiBNb2RlbCA4AEs2LUlJSSBNb2RlbCA5AEs1L0s2IG1vZGVsICVkAER1cm9uIG1vZGVsIDMATW9i
aWxlIER1cm9uIE1vZGVsIDcARHVyb24vQXRobG9uIG1vZGVsICVkAEdsb2JhbCBQYWdpbmcgRXh0
ZW5zaW9ucwAxMyAtIHJlc2VydmVkAEdlbmVyYXRpb246ICVkIE1vZGVsOiAlZAoATDEgQ2FjaGUg
SW5mb3JtYXRpb246ADIvNC1NQiBQYWdlczoANC1LQiBQYWdlczoATDEgRGF0YSBjYWNoZToATDEg
SW5zdHJ1Y3Rpb24gY2FjaGU6AEwyIENhY2hlIEluZm9ybWF0aW9uOgBIYXMgdGVtcGVyYXR1cmUg
c2Vuc2luZyBkaW9kZQBTdXBwb3J0cyBGcmVxdWVuY3kgSUQgY29udHJvbABTdXBwb3J0cyBWb2x0
YWdlIElEIGNvbnRyb2wASW50ZWwtc3BlY2lmaWMgZnVuY3Rpb25zOgBUeXBlICVkIC0gAE9yaWdp
bmFsIE9FTQBPdmVyZHJpdmUARHVhbC1jYXBhYmxlAEZhbWlseSAlZCAtIABpMzg2AGk0ODYAUGVu
dGl1bQBQZW50aXVtIFBybwBQZW50aXVtIDQARXh0ZW5kZWQgZmFtaWx5ICVkCgBNb2RlbCAlZCAt
IABEWABTWAA0ODcvRFgyAFNMAFNYMgB3cml0ZS1iYWNrIGVuaGFuY2VkIERYMgBEWDQANjAvNjYA
NzUtMjAwAGZvciA0ODYgc3lzdGVtAFBlbnRpdW0gSUkgTW9kZWwgMwBDZWxlcm9uAEV4dGVuZGVk
IG1vZGVsICVkCgBTdGVwcGluZyAlZAoAUmVzZXJ2ZWQgJWQKCgBCcmFuZCBpbmRleDogJWQgWwAl
c10KAG5vdCBpbiB0YWJsZV0ARXh0ZW5kZWQgYnJhbmQgc3RyaW5nOiAiAEluaXRpYWwgQVBJQyBJ
RDogJWQKAEh5cGVyIHRocmVhZGluZyBzaWJsaW5nczogJWQKAApGZWF0dXJlIGZsYWdzICUwOHg6
CgBUTEIgYW5kIGNhY2hlIGluZm86AFByb2Nlc3NvciBzZXJpYWw6IAAtJTA0bFgALSUwNGxYCgAl
MDh4ICUwOGx4ICUwOGx4ICUwOGx4ICUwOGx4CgBWZW5kb3IgSUQ6ICIAIjsgQ1BVSUQgbGV2ZWwg
JWxkCgoAVW5rbm93biB2ZW5kb3IAYnJhbmQgMABDZWxlcm9uIHByb2Nlc3NvcgBQZW50aXVtIElJ
SSBwcm9jZXNzb3IAYnJhbmQgNABicmFuZCA1AGJyYW5kIDYAYnJhbmQgNwBJbnRlbCBQZW50aXVt
IDQgcHJvY2Vzc29yAEZQVSAgICBGbG9hdGluZyBQb2ludCBVbml0AERFICAgICBEZWJ1Z2dpbmcg
RXh0ZW5zaW9ucwBQU0UgICAgUGFnZSBTaXplIEV4dGVuc2lvbnMAVFNDICAgIFRpbWUgU3RhbXAg
Q291bnRlcgBDWDggICAgQ09NUFhDSEc4QiBJbnN0cnVjdGlvbgAxMCAgICAgUmVzZXJ2ZWQAU0VQ
ICAgIEZhc3QgU3lzdGVtIENhbGwAUEdFICAgIFBURSBHbG9iYWwgRmxhZwBGR1BBVCAgUGFnZSBB
dHRyaWJ1dGUgVGFibGUAQ0xGU0ggIENGTFVTSCBpbnN0cnVjdGlvbgAyMCAgICAgcmVzZXJ2ZWQA
RFMgICAgIERlYnVnIHN0b3JlAE1NWCAgICBNTVggaW5zdHJ1Y3Rpb24gc2V0AFNTRTIgICBTU0Uy
IGV4dGVuc2lvbnMAU1MgICAgIFNlbGYgU25vb3AASFQgICAgIEh5cGVyIFRocmVhZGluZwBUTSAg
ICAgVGhlcm1hbCBtb25pdG9yADMwICAgICByZXNlcnZlZAAzMSAgICAgcmVzZXJ2ZWQAUEFFIC0g
UGFnZSBBZGRyZXNzIEV4dGVuc2lvbnMATWFjaGluZSBDaGVjayBFeGNlcHRpb24AQVBJQwAxMCAt
IFJlc2VydmVkAEdsb2JhbCBwYWdpbmcgZXh0ZW5zaW9uAE1hY2hpbmUgQ2hlY2sgQXJjaGl0ZWN0
dXJlAENvbmRpdGlvbmFsIE1vdmUgSW5zdHJ1Y3Rpb24AUEFUIC0gUGFnZSBBdHRyaWJ1dGUgVGFi
bGUAUFNFLTM2IC0gUGFnZSBTaXplIEV4dGVuc2lvbnMAMTggLSByZXNlcnZlZAAxOSAtIHJlc2Vy
dmVkADIwIC0gcmVzZXJ2ZWQAMjEgLSByZXNlcnZlZABNTVggaW5zdHJ1Y3Rpb25zAEZYU0FWRS9G
WFJTVE9SADI1IC0gcmVzZXJ2ZWQAMjYgLSByZXNlcnZlZAAyNyAtIHJlc2VydmVkADI4IC0gcmVz
ZXJ2ZWQAMjkgLSByZXNlcnZlZAAzRE5vdyEgSW5zdHJ1Y3Rpb24gRXh0ZW5zaW9ucwAzRE5vdyBp
bnN0cnVjdGlvbnMATDIgb2ZmAERpcmVjdCBtYXBwZWQAMi13YXkANC13YXkAOC13YXkAMTYtd2F5
AGZ1bGwARlBVICAgRmxvYXRpbmcgUG9pbnQgVW5pdABWODYgICBWaXJ0dWFsIE1vZGUgRXh0ZW5z
aW9ucwBEZWJ1ZyBFeHRlbnNpb24ANE1CIFBhZ2UgU2l6ZQBQQUUAMTEgLSBSZXNlcnZlZABNYWNo
aW5lIENoZWNrADE2IC0gcmVzZXJ2ZWQAMTcgLSByZXNlcnZlZAAyMiAtIHJlc2VydmVkADI0IC0g
cmVzZXJ2ZWQAMzAgLSByZXNlcnZlZABHbG9iYWwgUGFnaW5nIEV4dGVuc2lvbgBDeXJpeCBNU1IA
TUMgRXhjZXB0aW9uAENPTVBYQ0hHOEIAQVBJQyBvbiBjaGlwAFNZU0NBTEwvU1lTUkVUADExIC0g
cmVzZXJ2ZWQATVRSUgBHbG9iYWwgYml0AEZQVSBDTU9WAEV4dGVuZGVkIE1NWAAAAG+EBAilhAQI
1oYECMWGBAi0hgQIlIQECKOGBAiUhAQIkoYECJSEBAiBhgQIlIQECHCGBAiUhAQIlIQECJSEBAiU
hAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSE
BAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQE
CJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQI
lIQECJSEBAiUhAQIlIQECJSEBAhfhgQIToYECD2GBAgshgQIG4YECAqGBAiUhAQIlIQECJSEBAiU
hAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQI+YUECOiFBAjXhQQIlIQECJSEBAiUhAQIlIQECJSE
BAiUhAQIlIQECJSEBAjGhQQItYUECKSFBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQE
CJOFBAiChQQIcYUECJSEBAiUhAQIlIQECJSEBAiUhAQIlIQECJSEBAhghQQIT4UECD6FBAiUhAQI
lIQECJSEBAiUhAQIlIQECJSEBAgthQQIHIUECAuFBAj6hAQIlIQECJSEBAiUhAQIlIQECJSEBAjp
hAQI2IQECMeEBAi2hAQIN5EECJyRBAickQQIi5EECJyRBAg3kQQIsZEECMWRBAj6lQQIF5YECCWW
BAgzlgQIhZQECIWUBAiFlAQIhZQECIWUBAiFlAQIhZQECIWUBAhClgQIQpgECEKYBAhVmAQIZpgE
CHeYBAiImAQIyJQECJmYBAiqmAQIyJQECOyXBAjIlAQIMpgECMiUBAj6lwQICJgECBaYBAgkmAQI
AAAAAP////8AAAAA/////wAAAAAAAAAAAQAAABAAAAAMAAAA7IIECA0AAADkmwQIBAAAAEiBBAgF
AAAAEIIECAYAAACAgQQICgAAAGkAAAALAAAAEAAAABUAAAAAAAAAAwAAAADJBAgCAAAAMAAAABQA
AAARAAAAFwAAALyCBAgRAAAArIIECBIAAAAQAAAAEwAAAAgAAAD+//9vjIIECP///28BAAAA8P//
b3qCBAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
NMgECAAAAAAAAAAAGoMECCqDBAg6gwQISoMECFqDBAhqgwQIAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAALMgECAAAAAAAAAAAAAAAAAAAAAAAAAAALbAECDWwBAhHsAQIjKcECF2w
BAhlsAQIbbAECHWwBAh9sAQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJewBAiwpwQIsrAE
CM6wBAjqsAQI2KcECPinBAgcqAQIBLEECDyoBAgisQQIMrEECIyoBAhKsQQIsKgECNSoBAhhsQQI
CKkECCypBAh9sQQIl7EECKexBAhgqQQIurEECIipBAjEqQQI1bEECOyxBAj+sQQIFbIECCyyBAg8
sgQInrAECEC0BAi5sAQI1bAECPipBAgsqgQITLIECGqyBAgLsQQIgrIECIeyBAhYqgQIiKoECJWy
BAitsgQIyLIECOWyBAgAswQIHrMECCyzBAg6swQISLMECKyqBAhWswQIZ7MECHazBAiEswQIkrME
CKCzBAiuswQIvLMECNqzBAjtswQI9LMECAK0BAiesQQICLQECJ6xBAgOtAQInrEECBS0BAiesQQI
nrEECJ6xBAiesQQInrEECJ6xBAgbtAQIILQECDq0BAhYtAQIaLQECPGwBAjMqgQIdrQECGqyBAgL
sQQI9KoECIeyBAh6tAQIRKsECAKtBAiItAQIaKsECJa0BAiktAQIHrMECCyzBAg6swQISLMECLK0
BAhWswQIwLQECHazBAiEswQIkrMECKCzBAiuswQIzrQECAAAAAAgtAQIOrQECFi0BAhotAQI8bAE
CMyqBAh2tAQIarIECAuxBAj0qgQIh7IECHq0BAhEqwQI3LQECIi0BAhoqwQIlrQECKS0BAgeswQI
LLMECDqzBAhIswQIsrQECFazBAjAtAQIdrMECISzBAiSswQIoLMECK6zBAjOtAQIAAAAACC0BAg6
tAQIWLQECNWwBAjxsAQI9LQECHa0BAj+tAQIC7UECBa1BAgjtQQIMrUECEC1BAhFtQQIiLQECFS1
BAhQtQQIpLQECB6zBAgsswQIOrMECEizBAiytAQIYrUECFm1BAh2swQIhLMECJKzBAigswQIrrME
CM60BAjaswQIAEdDQzogKEdOVSkgNC4xLjIgMjAwNjExMTUgKHByZXJlbGVhc2UpIChEZWJpYW4g
NC4xLjEtMjEpAABHQ0M6IChHTlUpIDQuMS4yIDIwMDYxMTE1IChwcmVyZWxlYXNlKSAoRGViaWFu
IDQuMS4xLTIxKQAAR0NDOiAoR05VKSA0LjEuMiAyMDA2MTExNSAocHJlcmVsZWFzZSkgKERlYmlh
biA0LjEuMS0yMSkAAEdDQzogKEdOVSkgNC4xLjIgMjAwNjExMTUgKHByZXJlbGVhc2UpIChEZWJp
YW4gNC4xLjEtMjEpAABHQ0M6IChHTlUpIDQuMS4yIDIwMDYxMTE1IChwcmVyZWxlYXNlKSAoRGVi
aWFuIDQuMS4xLTIxKQAAR0NDOiAoR05VKSA0LjEuMiAyMDA2MTExNSAocHJlcmVsZWFzZSkgKERl
YmlhbiA0LjEuMS0yMSkAAEdDQzogKEdOVSkgNC4xLjIgMjAwNjExMTUgKHByZXJlbGVhc2UpIChE
ZWJpYW4gNC4xLjEtMjEpAAAAHAAAAAIAAAAAAAQAAAAAAICDBAgiAAAAAAAAAAAAAAAsAAAAAgAM
AQAABAAAAAAApIMECCYAAADsggQICwAAAOSbBAgTAAAAAAAAAAAAAAAkAAAAAgChAQAABAAAAAAA
AYMECAIAAAD8mwQIBAAAAAAAAAAAAAAAIQAAAAIAewAAAJEAAAB5AAAAX0lPX3N0ZGluX3VzZWQA
AAAAAHcAAAACAAAAAAAEAQAAAACAgwQIooMECC4uL3N5c2RlcHMvaTM4Ni9lbGYvc3RhcnQuUwAv
YnVpbGQvYnVpbGRkL2dsaWJjLTIuMy42LmRzMS9idWlsZC10cmVlL2dsaWJjLTIuMy42L2NzdQBH
TlUgQVMgMi4xNwABgI0AAAACABQAAAAEAVsAAACkgwQIpIMECAAAAAABNAAAAEUAAAACpAAAAAQH
AowAAAABCAKxAAAAAgcCnwAAAAQHAo4AAAABBgI7AAAAAgUDaW50AAQFAn4AAAAIBQKaAAAACAcC
gwAAAAQFAqQAAAAEBwKVAAAAAQYExAAAAAEZiwAAAAEFAwScBAgFTwAAAACRAAAAAgBWAAAABAGC
AAAAL2J1aWxkL2J1aWxkZC9nbGliYy0yLjMuNi5kczEvYnVpbGQtdHJlZS9pMzg2LWxpYmMvY3N1
L2NydGkuUwAvYnVpbGQvYnVpbGRkL2dsaWJjLTIuMy42LmRzMS9idWlsZC10cmVlL2dsaWJjLTIu
My42L2NzdQBHTlUgQVMgMi4xNwABgJEAAAACAGYAAAAEASQBAAAvYnVpbGQvYnVpbGRkL2dsaWJj
LTIuMy42LmRzMS9idWlsZC10cmVlL2kzODYtbGliYy9jc3UvY3J0bi5TAC9idWlsZC9idWlsZGQv
Z2xpYmMtMi4zLjYuZHMxL2J1aWxkLXRyZWUvZ2xpYmMtMi4zLjYvY3N1AEdOVSBBUyAyLjE3AAGA
AREAEAYRARIBAwgbCCUIEwUAAAABEQEQBhIBEQElDhMLAw4bDgAAAiQAAw4LCz4LAAADJAADCAsL
PgsAAAQ0AAMOOgs7C0kTPwwCCgAABSYASRMAAAABEQAQBgMIGwglCBMFAAAAAREAEAYDCBsIJQgT
BQAAAFcAAAACADIAAAABAfsODQABAQEBAAAAAQAAAS4uL3N5c2RlcHMvaTM4Ni9lbGYAAHN0YXJ0
LlMAAQAAAAAFAoCDBAgDwAABMyE0PSUiAxggWVohIlxbAgEAAQEjAAAAAgAdAAAAAQH7Dg0AAQEB
AQAAAAEAAAEAaW5pdC5jAAAAAACeAAAAAgBUAAAAAQH7Dg0AAQEBAQAAAAEAAAEvYnVpbGQvYnVp
bGRkL2dsaWJjLTIuMy42LmRzMS9idWlsZC10cmVlL2kzODYtbGliYy9jc3UAAGNydGkuUwABAAAA
AAUCpIMECAMLASEvIT1aIWdnLy9aISEhAgEAAQEABQLsggQIAyMBIS89AgUAAQEABQLkmwQIAzMB
IS8hPVohAgYAAQF8AAAAAgBUAAAAAQH7Dg0AAQEBAQAAAAEAAAEvYnVpbGQvYnVpbGRkL2dsaWJj
LTIuMy42LmRzMS9idWlsZC10cmVlL2kzODYtbGliYy9jc3UAAGNydG4uUwABAAAAAAUCAYMECAMJ
ASECAQABAQAFAvybBAgDEgEhISECAQABAUdOVSBDIDQuMS4yIDIwMDYxMTE1IChwcmVyZWxlYXNl
KSAoRGViaWFuIDQuMS4xLTIxKQBpbml0LmMAc2hvcnQgaW50AC9idWlsZC9idWlsZGQvZ2xpYmMt
Mi4zLjYuZHMxL2J1aWxkLXRyZWUvZ2xpYmMtMi4zLjYvY3N1AGxvbmcgbG9uZyBpbnQAdW5zaWdu
ZWQgY2hhcgBsb25nIGxvbmcgdW5zaWduZWQgaW50AHNob3J0IHVuc2lnbmVkIGludABfSU9fc3Rk
aW5fdXNlZAAALnN5bXRhYgAuc3RydGFiAC5zaHN0cnRhYgAuaW50ZXJwAC5ub3RlLkFCSS10YWcA
Lmhhc2gALmR5bnN5bQAuZHluc3RyAC5nbnUudmVyc2lvbgAuZ251LnZlcnNpb25fcgAucmVsLmR5
bgAucmVsLnBsdAAuaW5pdAAudGV4dAAuZmluaQAucm9kYXRhAC5laF9mcmFtZQAuY3RvcnMALmR0
b3JzAC5qY3IALmR5bmFtaWMALmdvdAAuZ290LnBsdAAuZGF0YQAuYnNzAC5jb21tZW50AC5kZWJ1
Z19hcmFuZ2VzAC5kZWJ1Z19wdWJuYW1lcwAuZGVidWdfaW5mbwAuZGVidWdfYWJicmV2AC5kZWJ1
Z19saW5lAC5kZWJ1Z19zdHIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAbAAAAAQAAAAIAAAAUgQQIFAEAABMAAAAAAAAAAAAAAAEAAAAAAAAAIwAAAAcAAAACAAAAKIEE
CCgBAAAgAAAAAAAAAAAAAAAEAAAAAAAAADEAAAAFAAAAAgAAAEiBBAhIAQAAOAAAAAQAAAAAAAAA
BAAAAAQAAAA3AAAACwAAAAIAAACAgQQIgAEAAJAAAAAFAAAAAQAAAAQAAAAQAAAAPwAAAAMAAAAC
AAAAEIIECBACAABpAAAAAAAAAAAAAAABAAAAAAAAAEcAAAD///9vAgAAAHqCBAh6AgAAEgAAAAQA
AAAAAAAAAgAAAAIAAABUAAAA/v//bwIAAACMggQIjAIAACAAAAAFAAAAAQAAAAQAAAAAAAAAYwAA
AAkAAAACAAAArIIECKwCAAAQAAAABAAAAAAAAAAEAAAACAAAAGwAAAAJAAAAAgAAALyCBAi8AgAA
MAAAAAQAAAALAAAABAAAAAgAAAB1AAAAAQAAAAYAAADsggQI7AIAABcAAAAAAAAAAAAAAAQAAAAA
AAAAcAAAAAEAAAAGAAAABIMECAQDAABwAAAAAAAAAAAAAAAEAAAABAAAAHsAAAABAAAABgAAAICD
BAiAAwAAZBgAAAAAAAAAAAAAEAAAAAAAAACBAAAAAQAAAAYAAADkmwQI5BsAABwAAAAAAAAAAAAA
AAQAAAAAAAAAhwAAAAEAAAACAAAAAJwECAAcAAAcHAAAAAAAAAAAAAAEAAAAAAAAAI8AAAABAAAA
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
LAIAAACcBAgEAAAAEQAOADMCAABghwQItgMAABIADAA7AgAARMkECAAAAAARAhYASAIAAACbBAhN
AAAAEgAMAFgCAAAAAAAA+gAAABIAAABrAgAAAAAAAH8BAAASAAAAewIAAOyCBAgAAAAAEgAKAIEC
AACgyQQIgAAAABEAFgCVAgAAYMwECAQAAAARABcApwIAAKDKBAhAAAAAEQAWAK0CAADwkQQI7QYA
ABIADAC1AgAAYIQECIcCAAASAAwAxgIAAICDBAgAAAAAEgAMAM0CAABQmwQIUwAAABIADADdAgAA
YMwECAAAAAAQAPH/6QIAAOCYBAggAgAAEgAMAO4CAAAgygQIgAAAABEAFgAAAwAAYMsECHwAAAAR
ABYAIgMAAAAAAADnAAAAEgAAAD8DAADgywQIgAAAABEAFgBcAwAAQMkECAAAAAAgABYAZwMAAAAA
AAA5AAAAEgAAAHkDAADkmwQIAAAAABIADQB/AwAAYMwECAAAAAAQAPH/hgMAAKObBAgAAAAAEgIM
AJ0DAAAAAAAA5wAAABIAAACxAwAAaMwECAAAAAAQAPH/tgMAACCLBAjHBgAAEgAMALwDAAAEnAQI
BAAAABEADgDLAwAAQMkECAAAAAAQABYA2AMAAAAAAAAAAAAAIAAAAOwDAAAAAAAAAAAAACAAAAAA
YWJpLW5vdGUuUwAuLi9zeXNkZXBzL2kzODYvZWxmL3N0YXJ0LlMAaW5pdC5jAGluaXRmaW5pLmMA
L2J1aWxkL2J1aWxkZC9nbGliYy0yLjMuNi5kczEvYnVpbGQtdHJlZS9pMzg2LWxpYmMvY3N1L2Ny
dGkuUwBjYWxsX2dtb25fc3RhcnQAY3J0c3R1ZmYuYwBfX0NUT1JfTElTVF9fAF9fRFRPUl9MSVNU
X18AX19KQ1JfTElTVF9fAGNvbXBsZXRlZC41NjIxAHAuNTYxOQBfX2RvX2dsb2JhbF9kdG9yc19h
dXgAZnJhbWVfZHVtbXkAX19DVE9SX0VORF9fAF9fRFRPUl9FTkRfXwBfX0ZSQU1FX0VORF9fAF9f
SkNSX0VORF9fAF9fZG9fZ2xvYmFsX2N0b3JzX2F1eAAvYnVpbGQvYnVpbGRkL2dsaWJjLTIuMy42
LmRzMS9idWlsZC10cmVlL2kzODYtbGliYy9jc3UvY3J0bi5TAGNwdWlkLmMAX0RZTkFNSUMAX19m
aW5pX2FycmF5X2VuZABfX2ZpbmlfYXJyYXlfc3RhcnQAX19pbml0X2FycmF5X2VuZABfR0xPQkFM
X09GRlNFVF9UQUJMRV8AX19pbml0X2FycmF5X3N0YXJ0AEN5cml4X3N0YW5kYXJkX2ZlYXR1cmVf
ZmxhZ3NfNQBkZWNvZGVfY3lyaXhfdGxiAEJyYW5kcwBwcmludHJlZ3MAX2ZwX2h3AGRvY3lyaXgA
X19kc29faGFuZGxlAF9fbGliY19jc3VfZmluaQBwdXRjaGFyQEBHTElCQ18yLjAAcHV0c0BAR0xJ
QkNfMi4wAF9pbml0AEludGVsX2ZlYXR1cmVfZmxhZ3MAc3Rkb3V0QEBHTElCQ18yLjAAQXNzb2MA
ZG9pbnRlbABkZWNvZGVfaW50ZWxfdGxiAF9zdGFydABfX2xpYmNfY3N1X2luaXQAX19ic3Nfc3Rh
cnQAbWFpbgBBTURfZmVhdHVyZV9mbGFncwBDeXJpeF9zdGFuZGFyZF9mZWF0dXJlX2ZsYWdzX25v
dDUAX19saWJjX3N0YXJ0X21haW5AQEdMSUJDXzIuMABDeXJpeF9leHRlbmRlZF9mZWF0dXJlX2Zs
YWdzAGRhdGFfc3RhcnQAcHJpbnRmQEBHTElCQ18yLjAAX2ZpbmkAX2VkYXRhAF9faTY4Ni5nZXRf
cGNfdGh1bmsuYngAX0lPX3B1dGNAQEdMSUJDXzIuMABfZW5kAGRvYW1kAF9JT19zdGRpbl91c2Vk
AF9fZGF0YV9zdGFydABfSnZfUmVnaXN0ZXJDbGFzc2VzAF9fZ21vbl9zdGFydF9fAA==
------=_Part_3305_11466360.1212615100237
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_3305_11466360.1212615100237--
