From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Sat, 11 Dec 2010 10:16:07 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <53627.75.142.173.238.1292062567.squirrel@webmail.myamigos.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_20101211041607_63218"
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
To: lm-sensors@vger.kernel.org

------=_20101211041607_63218
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Juerg,

> Hi Jeff,
>
>>> Ah. I just realized that the SCH5127 has another voltage input that
>>> the other dme1737 clones don't have but which isn't exposed through
>>> the driver. Register 0x1f, nominal 1.5V, max 2.0V.
>>
>> Ah ah! Very interesting. It could be where Jeff's mysterious +1.5V is
>> connected! Could you write a patch adding support?
>
> Attached is a modified driver with support for Vtrip monitoring (1.5V,
> in7). Could you give it a try and let me know how it goes? The new
> driver should expose the following new sysfs files: in7_input,
> in7_min, in7_max, in7_alarm. No user-level scaling is required. The
> nominal voltage is 1.5V.
>
> Thanks
> ...Juerg
>

See attached text file for output of "/sys/devices/platform/dme1737.2160".
It confirms what you coded. I should have sent this along earlier.

For the record:
CPU: Intel Atom 230 Stepping 2 (Family 6, Model 28, Stepping 2)
RAM: 2GB
OS: Fedora Core 14  2.6.35.9-64.fc14.x86_64

Please look at the "min" and "max" values for "in7". They look reversed.

[root@anas-01 ~]# sensors
sch5127-isa-0870
Adapter: ISA adapter
in0:         +1.78 V  (min =3D  +0.00 V, max =3D  +3.32 V)
Vccp:        +1.19 V  (min =3D  +1.08 V, max =3D  +1.32 V)
VCC:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
in3:         +1.13 V  (min =3D  +0.00 V, max =3D  +1.49 V)
in4:         +1.48 V  (min =3D  +0.00 V, max =3D  +1.49 V)
VTR:         +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
VBAT:        +3.24 V  (min =3D  +2.70 V, max =3D  +3.30 V)
in7:         +0.72 V  (min =3D  +1.99 V, max =3D  +1.75 V)
Side Fan:   1863 RPM  (min =3D  700 RPM)
MCH Fan:    5023 RPM  (min =3D 4500 RPM)
CPU Temp:    +39.9=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
SYS Temp:    +32.4=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)

I do not have any settings in my "/etc/sensors.d/local.conf" file for
"in7" that would cause this. My "/etc/sensors3.conf" file is "as
delivered" by LM_Sensors:

[root@anas-01 ~]# sensors -v
sensors version 3.2.0 with libsensors version 3.2.0

[root@anas-01 ~]# yum list installed | grep -i "sensors"
lm_sensors.x86_64 3.2.0-1.fc14  =20
@anaconda-InstallationRepo-201010211827.x86_64
lm_sensors-libs.x86_64


------=_20101211041607_63218
Content-Type: text/plain; name="updated_dme1737_sysfs.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="updated_dme1737_sysfs.txt"

[root@anas-01 ~]# ls /sys/devices/platform/dme1737.2160    
driver      fan3_alarm  in1_alarm  in3_input  in5_max    in7_min                  pwm1_freq                pwm3                     temp1_fault  temp3_alarm               zone1_auto_point3_temp
fan1_alarm  fan3_input  in1_input  in3_max    in5_min    modalias                 pwm1_ramp_rate           pwm3_auto_channels_zone  temp1_input  temp3_fault               zone2_auto_channels_temp
fan1_input  fan3_min    in1_max    in3_min    in6_alarm  name                     pwm2                     pwm3_auto_point1_pwm     temp1_max    temp3_input               zone2_auto_point1_temp
fan1_min    fan3_type   in1_min    in4_alarm  in6_input  power                    pwm2_auto_channels_zone  pwm3_auto_point2_pwm     temp1_min    temp3_max                 zone2_auto_point2_temp
fan1_type   hwmon       in2_alarm  in4_input  in6_max    pwm1                     pwm2_auto_point1_pwm     pwm3_enable              temp2_alarm  temp3_min                 zone2_auto_point3_temp
fan2_alarm  in0_alarm   in2_input  in4_max    in6_min    pwm1_auto_channels_zone  pwm2_auto_point2_pwm     pwm3_freq                temp2_fault  uevent
fan2_input  in0_input   in2_max    in4_min    in7_alarm  pwm1_auto_point1_pwm     pwm2_enable              pwm3_ramp_rate           temp2_input  zone1_auto_channels_temp
fan2_min    in0_max     in2_min    in5_alarm  in7_input  pwm1_auto_point2_pwm     pwm2_freq                subsystem                temp2_max    zone1_auto_point1_temp
fan2_type   in0_min     in3_alarm  in5_input  in7_max    pwm1_enable              pwm2_ramp_rate           temp1_alarm              temp2_min    zone1_auto_point2_temp
[root@anas-01 ~]# ls /sys/devices/platform/dme1737.2160/in7_min
/sys/devices/platform/dme1737.2160/in7_min
[root@anas-01 ~]# cat /sys/devices/platform/dme1737.2160/in7_min
1992
[root@anas-01 ~]# cat /sys/devices/platform/dme1737.2160/in7_max
1750
[root@anas-01 ~]# cat /sys/devices/platform/dme1737.2160/in7_input
719
[root@anas-01 ~]# cat /sys/devices/platform/dme1737.2160/in7_alarm
0

------=_20101211041607_63218
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_20101211041607_63218--


