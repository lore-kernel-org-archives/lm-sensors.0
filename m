From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 28 Apr 2008 20:35:39 +0000
Subject: Re: [lm-sensors] VIA VT1211
Message-Id: <191fb4ca0804281335j6e3e4238g1810d417b33bee6b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
In-Reply-To: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alessandro,


>  > Hi Alessandro,
>
>  Hi Juerg,
>
>
>  >  >  1) the CPU temperature isn't realistic (~ -70 =B0C). I tried the v=
arious
>  >  >  computation available in the configuration file but my CPU isn't in
>  >  >  the list!
>  >
>  >  What's wrong with 70C? :-) That's still within spec. Does the board
>  >  have a CPU fan?
>
>  I guess you missed the minus before the "70"... ;)

Uh-huh, yeah, I guess I missed the minus sign. You must live in a very
cold place :-)


>
>  >  There is no info available for Esther from VIA. Or I couldn't find it.
>
>  Do you mean technical info? The presentation of my CPU is at
>  http://www.via.com.tw/en/products/processors/c7-d/index.jsp
>
>  Unfortunately I wasn't able to retrieve much more information. It
>  seems like VIA provides data sheet for its product only on request. :(

That's what I meant, no datasheet with thermal diode specs.



>
>  >  Can you please send the output of 'grep ""
>  >  /sys/devices/platform/vt1211*/*' and the full output of 'sensors'?
>
>  Of course:
>
>  # grep "" /sys/devices/platform/vt1211*/*
>  /sys/devices/platform/vt1211.24576/alarms:4106
>  /sys/devices/platform/vt1211.24576/cpu0_vid:1212
>  /sys/devices/platform/vt1211.24576/fan1_alarm:0
>  /sys/devices/platform/vt1211.24576/fan1_div:2
>  /sys/devices/platform/vt1211.24576/fan1_input:5649
>  /sys/devices/platform/vt1211.24576/fan1_min:2580
>  /sys/devices/platform/vt1211.24576/fan2_alarm:0
>  /sys/devices/platform/vt1211.24576/fan2_div:2
>  /sys/devices/platform/vt1211.24576/fan2_input:4369
>  /sys/devices/platform/vt1211.24576/fan2_min:3006
>  /sys/devices/platform/vt1211.24576/in2_alarm:1
>  /sys/devices/platform/vt1211.24576/in2_input:1065
>  /sys/devices/platform/vt1211.24576/in2_max:1033
>  /sys/devices/platform/vt1211.24576/in2_min:971
>  /sys/devices/platform/vt1211.24576/in3_alarm:1
>  /sys/devices/platform/vt1211.24576/in3_input:1962
>  /sys/devices/platform/vt1211.24576/in3_max:2192
>  /sys/devices/platform/vt1211.24576/in3_min:1983
>  /sys/devices/platform/vt1211.24576/in4_alarm:0
>  /sys/devices/platform/vt1211.24576/in4_input:2140
>  /sys/devices/platform/vt1211.24576/in4_max:2317
>  /sys/devices/platform/vt1211.24576/in4_min:1889
>  /sys/devices/platform/vt1211.24576/in5_alarm:0
>  /sys/devices/platform/vt1211.24576/in5_input:3283
>  /sys/devices/platform/vt1211.24576/in5_max:3465
>  /sys/devices/platform/vt1211.24576/in5_min:3133
>  /sys/devices/platform/vt1211.24576/modalias:platform:vt1211
>  /sys/devices/platform/vt1211.24576/name:vt1211
>  /sys/devices/platform/vt1211.24576/pwm1:255
>  /sys/devices/platform/vt1211.24576/pwm1_auto_channels_temp:1
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point1_pwm:0
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point1_temp:0
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point2_pwm:255
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point2_temp:0
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point3_pwm:255
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point3_temp:0
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point4_pwm:255
>  /sys/devices/platform/vt1211.24576/pwm1_auto_point4_temp:0
>  /sys/devices/platform/vt1211.24576/pwm1_enable:0
>  /sys/devices/platform/vt1211.24576/pwm1_freq:45000
>  /sys/devices/platform/vt1211.24576/pwm2:255
>  /sys/devices/platform/vt1211.24576/pwm2_auto_channels_temp:1
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point1_pwm:0
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point1_temp:0
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point2_pwm:255
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point2_temp:0
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point3_pwm:255
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point3_temp:0
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point4_pwm:255
>  /sys/devices/platform/vt1211.24576/pwm2_auto_point4_temp:0
>  /sys/devices/platform/vt1211.24576/pwm2_enable:0
>  /sys/devices/platform/vt1211.24576/pwm2_freq:45000
>  /sys/devices/platform/vt1211.24576/temp1_alarm:0
>
> /sys/devices/platform/vt1211.24576/temp1_input:39000
>  /sys/devices/platform/vt1211.24576/temp1_max:85000
>  /sys/devices/platform/vt1211.24576/temp1_max_hyst:80000
>  /sys/devices/platform/vt1211.24576/temp2_alarm:0
>  /sys/devices/platform/vt1211.24576/temp2_input:50000
>  /sys/devices/platform/vt1211.24576/temp2_max:65000
>  /sys/devices/platform/vt1211.24576/temp2_max_hyst:60000
>  /sys/devices/platform/vt1211.24576/temp3_alarm:0
>  /sys/devices/platform/vt1211.24576/temp3_input:2064
>  /sys/devices/platform/vt1211.24576/temp3_max:-20
>  /sys/devices/platform/vt1211.24576/temp3_max_hyst:2650
>  /sys/devices/platform/vt1211.24576/temp4_alarm:0
>  /sys/devices/platform/vt1211.24576/temp4_input:2064
>  /sys/devices/platform/vt1211.24576/temp4_max:-20
>  /sys/devices/platform/vt1211.24576/temp4_max_hyst:2650
>  /sys/devices/platform/vt1211.24576/uevent:DRIVER=3Dvt1211
>  /sys/devices/platform/vt1211.24576/uevent:MODALIAS=3Dplatform:vt1211
>  /sys/devices/platform/vt1211.24576/vrm:13
>
>  # sensors
>  vt1211-isa-6000
>  Adapter: ISA adapter
>  VCore:       +1.06 V  (min =3D  +0.97 V, max =3D  +1.03 V)   ALARM
>  +5V:         +4.71 V  (min =3D  +4.76 V, max =3D  +5.26 V)   ALARM
>  +12V:       +12.20 V  (min =3D +10.77 V, max =3D +13.21 V)
>  +3.3V:       +3.28 V  (min =3D  +3.13 V, max =3D  +3.46 V)
>  Case Fan:   5649 RPM  (min =3D 2580 RPM, div =3D 2)
>  CPU Fan:    4369 RPM  (min =3D 3006 RPM, div =3D 2)
>  CPU Temp:    -36.6 C  (high =3D +11.7 C, hyst =3D  +6.4 C)
>  Int Temp:    +50.0 C  (high =3D +65.0 C, hyst =3D +60.0 C)
>  cpu0_vid:   +1.212 V
>
>  I disabled the temp[3-4] in /etc/sensors3.conf because they seem to be g=
rounded.

You can try to do a crude temp calibration if you want. For that, you
need to set the CPU at different frequencies, run a stress tool (like
cpuburn from http://users.bigpond.net.au/CPUBURN/), take snapshots of
the vt1211 registers at each frequency and do some math to come up
with the right values that go into sensors.conf.

1) load the cpufreq drivers:
modprobe longhaul
modprobe cpufreq_ondemand

2) set the scaling governor and determine available frequencies
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
Determine the lowest, medium and highest frequencies (Fmin, Fmed, Fmax).

3) Set the frequency
echo <Freq value from previous step> >
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
cat /proc/cpuinfo to check that the frequency indeed did change.

4) Run cpuburn for a couple of minutes until the CPU temperature
settles and the temp1_input value doesn't change anymore.

5) dump the following info into a file
sensors >> log
cat /proc/cpuinfo >> log
grep "" /sys/devices/platform/vt1211*/* >> log
grep "" /sys/devices/system/cpu/cpu0/cpufreq/* >> log

Repeat steps 3)-5) for all three frequencies Fmin, Fmed, and Fmax. Zip
up the log file and send it to me (in private if you don't want to
share the data with the whole list).


>
>  >  VIA is known to not use the fan control feature of the VT1211 on its
>  >  EPIA boards. You might be out of luck. But send the requested info and
>  >  we'll go from there.
>
>  OK, thank you very much.

Let's do the temp first and tackle fan control next.

...juerg



>  >  ...juerg
>
>  Bye, Alessandro.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
