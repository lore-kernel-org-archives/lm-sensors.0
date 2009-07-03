From: Niels <n.wassenberg@chello.nl>
Date: Fri, 03 Jul 2009 13:54:29 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <4A4E0D95.8080800@chello.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Niels,
>
> On Wed, 01 Jul 2009 19:22:04 +0200, Niels wrote:
>  =20
>> I'm having trouble with my pwmconfig.
>>
>> Code:
>> Found the following PWM controls:
>>    hwmon2/device/pwm1
>>    hwmon2/device/pwm2
>>    hwmon2/device/pwm3
>> There are no usable PWM outputs.
>>    =20
>
> Which version of lm-sensors (or pwmconfig) is this?
>
> I would like to see the full output of pwmconfig and not just the above
> summary.
>    =20
>  =20
nelis@nelis-desktop:~$ sensors -v
sensors version 3.1.1+SVN with libsensors version 3.1.1+SVN


nelis@nelis-desktop:~$ pwmconfig
# pwmconfig revision 5630 (2009-01-29)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
   hwmon0 is acpitz
   hwmon1/device is k8temp
   hwmon2/device is f71862fg

Found the following PWM controls:
   hwmon2/device/pwm1
   hwmon2/device/pwm2
   hwmon2/device/pwm3
There are no usable PWM outputs.



>> Though my sensors cleary reads out the fans
>>    =20
>
> Many boards can monitor the fans but not control them. What board is it?
>
>  =20
Jetway NC81-LF http://www.jetwaycomputer.com/NC81.html
>> Code:
>> nelis@nelis-desktop:~$ sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:       +41.0=B0C  (crit =3D +70.0=B0C)
>> k8temp-pci-00c3
>> Adapter: PCI adapter
>> Core0 Temp:  +36.0=B0C
>> Core1 Temp:  -49.0=B0C
>> f71862fg-isa-0220
>> Adapter: ISA adapter
>> in0:         +1.70 V
>> in1:         +2.04 V
>> in2:         +1.20 V
>> in3:         +2.04 V
>> in4:         +1.34 V
>> in5:         +1.18 V
>> in6:         +1.18 V
>> in7:         +1.68 V
>> in8:         +1.66 V
>> fan1:       2538 RPM
>> fan2:       2222 RPM
>> fan3:          0 RPM  ALARM
>> temp1:       +41.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
>>                       (crit =3D +70.0=B0C, hyst =3D +66.0=B0C)  sensor =
=3D transistor
>> temp2:       +89.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)  ALARM
>>                       (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D transistor
>> temp3:       +44.0=B0C  (high =3D +254.0=B0C, hyst =3D +252.0=B0C)
>>                       (crit =3D +254.0=B0C, hyst =3D +252.0=B0C)  sensor=
 =3D transistor
>>
>> Anyone got an idea on how to deal with this ?
>>    =20
>
> I would be interested in the output of the following commands:
>
> grep -H . /sys/class/hwmon/hwmon*/device/name
> grep -H . /sys/class/hwmon/hwmon*/device/pwm*
> ls -l /sys/class/hwmon/hwmon*/device/pwm*
>
>  =20
nelis@nelis-desktop:~$ grep -H . /sys/class/hwmon/hwmon*/device/name
/sys/class/hwmon/hwmon1/device/name:k8temp
/sys/class/hwmon/hwmon2/device/name:f71862fg

nelis@nelis-desktop:~$ grep -H . /sys/class/hwmon/hwmon*/device/pwm*
/sys/class/hwmon/hwmon2/device/pwm1:81
/sys/class/hwmon/hwmon2/device/pwm1_auto_channels_temp:1
/sys/class/hwmon/hwmon2/device/pwm1_auto_point1_pwm:90
/sys/class/hwmon/hwmon2/device/pwm1_auto_point1_temp:60000
/sys/class/hwmon/hwmon2/device/pwm1_auto_point1_temp_hyst:56000
/sys/class/hwmon/hwmon2/device/pwm1_auto_point2_pwm:80
/sys/class/hwmon/hwmon2/device/pwm1_auto_point2_temp:35000
/sys/class/hwmon/hwmon2/device/pwm1_auto_point2_temp_hyst:31000
/sys/class/hwmon/hwmon2/device/pwm1_enable:2
/sys/class/hwmon/hwmon2/device/pwm1_interpolate:1
/sys/class/hwmon/hwmon2/device/pwm2:255
/sys/class/hwmon/hwmon2/device/pwm2_auto_channels_temp:2
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_pwm:217
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp:60000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp_hyst:56000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_pwm:128
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp:30000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp_hyst:26000
/sys/class/hwmon/hwmon2/device/pwm2_enable:2
/sys/class/hwmon/hwmon2/device/pwm2_interpolate:1
/sys/class/hwmon/hwmon2/device/pwm3:155
/sys/class/hwmon/hwmon2/device/pwm3_auto_channels_temp:4
/sys/class/hwmon/hwmon2/device/pwm3_auto_point1_pwm:217
/sys/class/hwmon/hwmon2/device/pwm3_auto_point1_temp:60000
/sys/class/hwmon/hwmon2/device/pwm3_auto_point1_temp_hyst:58000
/sys/class/hwmon/hwmon2/device/pwm3_auto_point2_pwm:128
/sys/class/hwmon/hwmon2/device/pwm3_auto_point2_temp:30000
/sys/class/hwmon/hwmon2/device/pwm3_auto_point2_temp_hyst:28000
/sys/class/hwmon/hwmon2/device/pwm3_enable:2
/sys/class/hwmon/hwmon2/device/pwm3_interpolate:1

nelis@nelis-desktop:~$ ls -l /sys/class/hwmon/hwmon*/device/pwm*
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_channels_temp
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_point1_pwm
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_point1_temp
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_point1_temp_hyst
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_point2_pwm
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_point2_temp
-r--r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_auto_point2_temp_hyst
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_enable
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm1_interpolate
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_channels_temp
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_pwm
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp_hyst
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_pwm
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp
-r--r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp_hyst
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_enable
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm2_interpolate
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_channels_temp
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_point1_pwm
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_point1_temp
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_point1_temp_hyst
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_point2_pwm
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_point2_temp
-r--r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_auto_point2_temp_hyst
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_enable
-rw-r--r-- 1 root root 4096 2009-07-03 15:44=20
/sys/class/hwmon/hwmon2/device/pwm3_interpolate


I hope this helps,
Thanks for looking in to this.

Niels




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
