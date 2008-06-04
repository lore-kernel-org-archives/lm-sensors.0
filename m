From: Sergio Bruder <sergio@bruder.com.br>
Date: Wed, 04 Jun 2008 22:58:13 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <2AD7AEC8-3E29-49EB-93A8-BA194A9FAAA0@bruder.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Em 04/06/2008, =E0s 18:31, Juerg Haefliger escreveu:

> Hi Sergio,
>
> yes, but I dont understand which temperature governs the autocontrol.
>
> pwmX controls fanX. pwmX_auto_channels_temp is used to map a temp =20
> input to a pwm output for the auto controller. It's a bit map i.e.:
> pwmX_auto_channels_temp =3D 1 -> temp1 controls pwmX
> pwmX_auto_channels_temp =3D 2 -> temp2 controls pwmX
> pwmX_auto_channels_temp =3D 4 -> temp3 controls pwmX
> pwmX_auto_channels_temp =3D 8 -> temp4 controls pwmX

I see!

> Now a couple of things:
> 1) The temp conversion for the C7 is currently not correct as you =20
> might have guessed from the -35C output :-) The only valid temp is =20
> temp2 (vt1211 internal) as the conversion is always the same and =20
> done by the driver itself. The C7 is supposed to have another =20
> internal temp diode that can be read via SW which I'm hopping we can =20
> use to determine the somewhat correct formula for the vt1211 CPU =20
> temp reading. Can you run the attached cpuid program and send me the =20
> output?

root@nimbus:~# ~sergio/cpuid
  eax in    eax      ebx      ecx      edx
00000000 00000001 746e6543 736c7561 48727561
00000001 000006a9 00010800 00000181 a7c9bbff
80000000 80000006 00000000 00000000 00000000
80000001 00000000 00000000 00000000 00100000
80000002 20202020 20202020 20202020 20202020
80000003 56202020 45204149 65687473 72702072
80000004 7365636f 20726f73 30303031 007a484d
80000005 00000000 08800880 40040140 40040140
80000006 00000000 00000000 0080a140 00000000
c0000000 c0000002 00000000 00000000 00000000
c0000001 00000000 00000000 00000000 00003fcc
c0000002 00003b00 080c0810 08100a13 42000000

Vendor ID: "CentaurHauls"; CPUID level 1

Unknown vendor

> 2) Can you turn the fan on and send another output of 'grep "" /sys/=20
> class/hwmon/hwmon*/device/*' so that I can see where the Fan is =20
> connected to?

It appears as 'CPU FAN' to sensors, and sensors3.conf has label fan2 =20
"CPU Fan".

# grep "" /sys/class/hwmon/hwmon*/device/*
/sys/class/hwmon/hwmon0/device/alarms:4608
/sys/class/hwmon/hwmon0/device/cpu0_vid:1212
/sys/class/hwmon/hwmon0/device/fan1_alarm:0
/sys/class/hwmon/hwmon0/device/fan1_div:2
/sys/class/hwmon/hwmon0/device/fan1_input:0
/sys/class/hwmon/hwmon0/device/fan1_min:0
/sys/class/hwmon/hwmon0/device/fan2_alarm:0
/sys/class/hwmon/hwmon0/device/fan2_div:2
/sys/class/hwmon/hwmon0/device/fan2_input:3309 << here
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
/sys/class/hwmon/hwmon0/device/in4_input:2046
/sys/class/hwmon/hwmon0/device/in4_max:2630
/sys/class/hwmon/hwmon0/device/in4_min:0
/sys/class/hwmon/hwmon0/device/in5_alarm:0
/sys/class/hwmon/hwmon0/device/in5_input:3233
/sys/class/hwmon/hwmon0/device/in5_max:3465
/sys/class/hwmon/hwmon0/device/in5_min:3133
/sys/class/hwmon/hwmon0/device/modalias:platform:vt1211
/sys/class/hwmon/hwmon0/device/name:vt1211
/sys/class/hwmon/hwmon0/device/pwm1:0
/sys/class/hwmon/hwmon0/device/pwm1_auto_channels_temp:1
/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm:0
/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp:40000
/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm:100
/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_temp:40000
/sys/class/hwmon/hwmon0/device/pwm1_auto_point3_pwm:200
/sys/class/hwmon/hwmon0/device/pwm1_auto_point3_temp:40000
/sys/class/hwmon/hwmon0/device/pwm1_auto_point4_pwm:255
/sys/class/hwmon/hwmon0/device/pwm1_auto_point4_temp:40000
/sys/class/hwmon/hwmon0/device/pwm1_enable:0
/sys/class/hwmon/hwmon0/device/pwm1_freq:45000
/sys/class/hwmon/hwmon0/device/pwm2:0
/sys/class/hwmon/hwmon0/device/pwm2_auto_channels_temp:1
/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm:0
/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_temp:40000
/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_pwm:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_temp:40000
/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_pwm:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_point3_temp:40000
/sys/class/hwmon/hwmon0/device/pwm2_auto_point4_pwm:255
/sys/class/hwmon/hwmon0/device/pwm2_auto_point4_temp:40000
/sys/class/hwmon/hwmon0/device/pwm2_enable:0
/sys/class/hwmon/hwmon0/device/pwm2_freq:45000
/sys/class/hwmon/hwmon0/device/temp1_alarm:0
/sys/class/hwmon/hwmon0/device/temp1_input:40000
/sys/class/hwmon/hwmon0/device/temp1_max:255000
/sys/class/hwmon/hwmon0/device/temp1_max_hyst:0
/sys/class/hwmon/hwmon0/device/temp2_alarm:0
/sys/class/hwmon/hwmon0/device/temp2_input:50000
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


> 3) What is the rev of your vt1211? It's printed in the kernel log =20
> during module load. Your board is the first that I see that actually =20
> has the vt1211 controlling the Fans. Interesting.

# dmesg | grep vt1211
[   91.562775] vt1211: Found VT1211 chip at 0x6000, revision 2

> 4) Can you try to manually control the fans? Write 1 to pwmX_enable =20
> (where X is the number of the pwm controller that controls the CPU =20
> fan). And then try writing different values in the range 0-255 to =20
> pwmX. The fan RPMs hopefully change accordingly.

# echo 1 > pwm2_enable
-su: echo: write error: Invalid argument
# cat pwm2_enable
0

Ive just verified that pwm1_enable and pwm2_enable controls the same =20
fan, fan2 in my case (cpu fan).

echo 2 > pwm2_enable and echo 1 > pwm1_enable turn that fan off.


> Let's try to get the temp readings somewhat correct before we dive =20
> into PWM auto control.
> 1

Ok, glad to help in any way.

> Thanks
> ...juerg


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
