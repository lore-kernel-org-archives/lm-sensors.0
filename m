From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Sat, 27 Oct 2012 05:48:09 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <CABkW7JPxYL5sJB8qyOWUJgML0J0ZRbE5Tx3AAPOtGxdvO74h4Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4902717831699442407=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4902717831699442407==
Content-Type: multipart/alternative; boundary=e89a8ff1c7de69f6aa04cd03fcab

--e89a8ff1c7de69f6aa04cd03fcab
Content-Type: text/plain; charset=ISO-8859-1

>
> Please download and install the driver from
> https://github.com/groeck/w83627ehf.
> This is an experimental version which adds a couple of new features and,
> specifically for you chip, a missing fan control mode. If we are lucky that
> might solve your problem.
>
> Thanks,
> Guenter
>


Thank you, Guenter.
No the fans never seemed to change speed with load or cpu use, or for that
matter temperature- although i'm in a pretty cold environment and don't
ever really see more than 30c on the chips.

The newer driver does indeed allow _some_ control of the fans! - albeit
with slightly odd results;
All case fans and CPU fans seem to hang off of one output, but the cpu fan
does not stop when 0 is entered, while the other fans do.

pwm1 and pwm3 have control of none of the fans plugged into the board

pwm2 at 255 has all fans at full speed:
BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i}
${i}_enable ${i}_mode; done
pwm1
0
1
1
pwm2
255
1
1
pwm3
0
1
1
Rear_Fan:     3515 RPM  (min =  958 RPM, div = 128)
CPU_Fan:      1795 RPM  (min = 2678 RPM, div = 8)  ALARM
HD_Fan0:      3515 RPM  (min = 1318 RPM, div = 128)
HD_Fan1:      3515 RPM  (min =  878 RPM, div = 128)


pwm2 at 0 has all case fans stopped and cpu fan at partial speed.
BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i}
${i}_enable ${i}_mode; done
pwm1
0
1
1
pwm2
0
1
1
pwm3
0
1
1
BigBox w83627ehf.656 # sensors | grep Fan
Rear_Fan:        0 RPM  (min =  958 RPM, div = 128)  ALARM
CPU_Fan:      1048 RPM  (min = 2678 RPM, div = 8)  ALARM
HD_Fan0:         0 RPM  (min = 1318 RPM, div = 128)  ALARM
HD_Fan1:         0 RPM  (min =  878 RPM, div = 128)  ALARM
Take care--


P.S. Here are all of the pwm related values:

dylan@BigBox /usr/src/linux/drivers/hwmon $ head
/sys/class/hwmon/hwmon2/device/pwm*
==> /sys/class/hwmon/hwmon2/device/pwm1 <==
0
==> /sys/class/hwmon/hwmon2/device/pwm1_enable <==
1
==> /sys/class/hwmon/hwmon2/device/pwm1_max_output <==
255
==> /sys/class/hwmon/hwmon2/device/pwm1_mode <==
1
==> /sys/class/hwmon/hwmon2/device/pwm1_start_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm1_step_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm1_stop_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm1_stop_time <==
6000
==> /sys/class/hwmon/hwmon2/device/pwm1_target <==
0
==> /sys/class/hwmon/hwmon2/device/pwm1_tolerance <==
0
==> /sys/class/hwmon/hwmon2/device/pwm2 <==
255
==> /sys/class/hwmon/hwmon2/device/pwm2_enable <==
1
==> /sys/class/hwmon/hwmon2/device/pwm2_max_output <==
255
==> /sys/class/hwmon/hwmon2/device/pwm2_mode <==
1
==> /sys/class/hwmon/hwmon2/device/pwm2_start_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm2_step_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm2_stop_output <==
128
==> /sys/class/hwmon/hwmon2/device/pwm2_stop_time <==
6000
==> /sys/class/hwmon/hwmon2/device/pwm2_target <==
0
==> /sys/class/hwmon/hwmon2/device/pwm2_tolerance <==
2000
==> /sys/class/hwmon/hwmon2/device/pwm3 <==
0
==> /sys/class/hwmon/hwmon2/device/pwm3_enable <==
1
==> /sys/class/hwmon/hwmon2/device/pwm3_max_output <==
255
==> /sys/class/hwmon/hwmon2/device/pwm3_mode <==
1
==> /sys/class/hwmon/hwmon2/device/pwm3_start_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm3_step_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm3_stop_output <==
1
==> /sys/class/hwmon/hwmon2/device/pwm3_stop_time <==
6000
==> /sys/class/hwmon/hwmon2/device/pwm3_target <==
0
==> /sys/class/hwmon/hwmon2/device/pwm3_tolerance <==
4000

--e89a8ff1c7de69f6aa04cd03fcab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Please downl=
oad and install the driver from <a href=3D"https://github.com/groeck/w83627=
ehf" target=3D"_blank">https://github.com/groeck/w83627ehf</a>.<br>


This is an experimental version which adds a couple of new features and,<br=
>
specifically for you chip, a missing fan control mode. If we are lucky that=
<br>
might solve your problem.<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br></div><div><br></div><div><div>Thank you, Guenter.</=
div><div>No the fans never seemed to change speed with load or cpu use, or =
for that matter temperature- although i&#39;m in a pretty cold environment =
and don&#39;t ever really see more than 30c on the chips.</div>

<div><br></div><div>The newer driver does indeed allow _some_ control of th=
e fans! - albeit with slightly odd results;</div><div>All case fans and CPU=
 fans seem to hang off of one output, but the cpu fan does not stop when 0 =
is entered, while the other fans do.</div>

<div><br></div><div>pwm1 and pwm3 have control of none of the fans plugged =
into the board</div><div><br></div><div>pwm2 at 255 has all fans at full sp=
eed:</div><div>BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do echo $i; =
cat ${i} ${i}_enable ${i}_mode; done</div>

<div>pwm1</div><div>0</div><div>1</div><div>1</div><div>pwm2</div><div>255<=
/div><div>1</div><div>1</div><div>pwm3</div><div>0</div><div>1</div><div>1<=
/div><div>Rear_Fan: =A0 =A0 3515 RPM =A0(min =3D =A0958 RPM, div =3D 128)</=
div><div>

CPU_Fan: =A0 =A0 =A01795 RPM =A0(min =3D 2678 RPM, div =3D 8) =A0ALARM</div=
><div>HD_Fan0: =A0 =A0 =A03515 RPM =A0(min =3D 1318 RPM, div =3D 128)</div>=
<div>HD_Fan1: =A0 =A0 =A03515 RPM =A0(min =3D =A0878 RPM, div =3D 128)</div=
><div><br></div><div><br></div><div>

pwm2 at 0 has all case fans stopped and cpu fan at partial speed.</div><div=
>BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_=
enable ${i}_mode; done</div><div>pwm1</div><div>0</div><div>1</div><div>

1</div><div>pwm2</div><div>0</div><div>1</div><div>1</div><div>pwm3</div><d=
iv>0</div><div>1</div><div>1</div><div>BigBox w83627ehf.656 # sensors | gre=
p Fan</div><div>Rear_Fan: =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0958 RPM, div =
=3D 128) =A0ALARM</div>

<div>CPU_Fan: =A0 =A0 =A01048 RPM =A0(min =3D 2678 RPM, div =3D 8) =A0ALARM=
</div><div>HD_Fan0: =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 1318 RPM, div =3D 128=
) =A0ALARM</div><div>HD_Fan1: =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0878 RPM,=
 div =3D 128) =A0ALARM</div><div>Take care--</div>

<div><br></div><div><br></div><div>P.S. Here are all of the pwm related val=
ues:</div><div><br></div><div>dylan@BigBox /usr/src/linux/drivers/hwmon $ h=
ead /sys/class/hwmon/hwmon2/device/pwm*=A0</div><div>=3D=3D&gt; /sys/class/=
hwmon/hwmon2/device/pwm1 &lt;=3D=3D</div>

<div>0</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm1_enable &lt;=
=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm1=
_max_output &lt;=3D=3D</div><div>255</div><div>=3D=3D&gt; /sys/class/hwmon/=
hwmon2/device/pwm1_mode &lt;=3D=3D</div>

<div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm1_start_outpu=
t &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/devic=
e/pwm1_step_output &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/h=
wmon/hwmon2/device/pwm1_stop_output &lt;=3D=3D</div>

<div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm1_stop_time &=
lt;=3D=3D</div><div>6000</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/devic=
e/pwm1_target &lt;=3D=3D</div><div>0</div><div>=3D=3D&gt; /sys/class/hwmon/=
hwmon2/device/pwm1_tolerance &lt;=3D=3D</div>

<div>0</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm2 &lt;=3D=3D<=
/div><div>255</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm2_enab=
le &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/devi=
ce/pwm2_max_output &lt;=3D=3D</div>

<div>255</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm2_mode &lt;=
=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm2=
_start_output &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/=
hwmon2/device/pwm2_step_output &lt;=3D=3D</div>

<div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm2_stop_output=
 &lt;=3D=3D</div><div>128</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/devi=
ce/pwm2_stop_time &lt;=3D=3D</div><div>6000</div><div>=3D=3D&gt; /sys/class=
/hwmon/hwmon2/device/pwm2_target &lt;=3D=3D</div>

<div>0</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm2_tolerance &=
lt;=3D=3D</div><div>2000</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/devic=
e/pwm3 &lt;=3D=3D</div><div>0</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/=
device/pwm3_enable &lt;=3D=3D</div>

<div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm3_max_output =
&lt;=3D=3D</div><div>255</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/devic=
e/pwm3_mode &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hw=
mon2/device/pwm3_start_output &lt;=3D=3D</div>

<div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm3_step_output=
 &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device=
/pwm3_stop_output &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; /sys/class/hw=
mon/hwmon2/device/pwm3_stop_time &lt;=3D=3D</div>

<div>6000</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/pwm3_target &=
lt;=3D=3D</div><div>0</div><div>=3D=3D&gt; /sys/class/hwmon/hwmon2/device/p=
wm3_tolerance &lt;=3D=3D</div><div>4000</div><div><br></div><div><br></div>=
</div>

--e89a8ff1c7de69f6aa04cd03fcab--


--===============4902717831699442407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4902717831699442407==--
