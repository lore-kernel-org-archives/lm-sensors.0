From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Thu, 15 Nov 2007 06:26:10 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alexander,

> I'm not in the kernel mailing list and I assume that you are the
> w83627ehf maintainer.

I am one of them. I have CC'ed your email to the lm-sensors mailing
list. Can you kindly include the CC in your future replies? That is
the correct mailing list to post this discussion on.

> I have a Asus P5B Deluxe running a fresh Ubuntu 7.10 with kernel
> 2.6.22-14-generic and all latest software. lm-sensors is at version
> 2.10.4, pwmconfig at v0.8.
>
> I run sensors-detect and can read all values without any problem.
> sensors:
>
> ----------------------------------------------------------------
> w83627dhg-isa-0290
> Adapter: ISA adapter
> VCore:     +1.57 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:      +12.14 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> AVCC:      +3.33 V  (min =3D  +0.26 V, max =3D  +2.58 V) ALARM
> 3VCC:      +3.33 V  (min =3D  +0.51 V, max =3D  +1.41 V) ALARM
> in4:       +1.34 V  (min =3D  +0.00 V, max =3D  +0.10 V) ALARM
> in5:       +1.59 V  (min =3D  +0.13 V, max =3D  +0.13 V) ALARM
> in6:       +4.15 V  (min =3D  +0.61 V, max =3D  +0.00 V) ALARM
> VSB:       +3.31 V  (min =3D  +0.00 V, max =3D  +0.13 V) ALARM
> VBAT:      +1.28 V  (min =3D  +0.30 V, max =3D  +2.37 V)
> Case Fan:    0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
> CPU Fan:     0 RPM  (min =3D  104 RPM, div =3D 128) ALARM
> Aux Fan:  1318 RPM  (min =3D 10546 RPM, div =3D 8) ALARM
> fan4:        0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
> fan5:     2934 RPM  (min =3D 3515 RPM, div =3D 2) ALARM
> Sys Temp:    +38=B0C  (high =3D    +2=B0C, hyst =3D   +68=B0C)
> CPU Temp:  +33.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> AUX Temp: +127.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)   ALARM
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +30=B0C  (high =3D   +85=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +31=B0C  (high =3D   +85=B0C)
> -------------------------------------------------------------------------=
--
>
> But if I run pwmconfig, I get the following:
>
> -------------------------------------------------------------------------=
---
> This program will search your sensors for pulse width modulation (pwm)
> controls, and test each one to see if it controls a fan on
> your motherboard. Note that many motherboards do not have pwm
> circuitry installed, even if your sensor chip supports pwm.
>
> We will attempt to briefly stop each fan using the pwm controls.
> The program will attempt to restore each fan to full speed
> after testing. However, it is ** very important ** that you
> physically verify that the fans have been to full speed
> after the program has completed.
>
> Found the following devices:
>    hwmon0/device is w83627dhg
>    hwmon1/device is coretemp
>    hwmon2/device is coretemp
>
> Found the following PWM controls:
>    hwmon0/device/pwm1
> hwmon0/device/pwm1_enable stuck to 1
> Failed to set pwmhwmon0/device/pwm1 to full speed
> Something's wrong, check your fans!
> --------------------------------------------------------------------------
>
> Direct sys access:
>
> -------------------------------------------------------------------------
> akiel@alex:~$ ll /sys/bus/i2c/devices/9191-0290/pwm1*
> -rw-r--r-- 1 root root    0 2007-11-14
> 17:00 /sys/bus/i2c/devices/9191-0290/pwm1
> -rw-r--r-- 1 root root    0 2007-11-14
> 17:00 /sys/bus/i2c/devices/9191-0290/pwm1_enable
> -rw-r--r-- 1 root root 4096 2007-11-14
> 17:03 /sys/bus/i2c/devices/9191-0290/pwm1_min_output
> -rw-r--r-- 1 root root 4096 2007-11-14
> 17:03 /sys/bus/i2c/devices/9191-0290/pwm1_mode
> -rw-r--r-- 1 root root 4096 2007-11-14
> 17:03 /sys/bus/i2c/devices/9191-0290/pwm1_stop_time
> -rw-r--r-- 1 root root 4096 2007-11-14
> 17:03 /sys/bus/i2c/devices/9191-0290/pwm1_target
> -rw-r--r-- 1 root root 4096 2007-11-14
> 17:03 /sys/bus/i2c/devices/9191-0290/pwm1_tolerance
> akiel@alex:~$ cat /sys/bus/i2c/devices/9191-0290/pwm1*
> 0
> 1
> 1
> 0
> 24000
> 0
> 0
> akiel@alex:~$ sudo echo 100 > /sys/bus/i2c/devices/9191-0290/pwm1
> bash: /sys/bus/i2c/devices/9191-0290/pwm1: Permission denied
> ---------------------------------------------------------------------
>
> Asus Q-Fan Control was off. I switched it on but does not make any
> difference.
>
> Best Regards
> Alexander Kiel
> http://alexk.homeip.net

I recall seeing this problem before. The list archives have a similar
problem for an MSI 975x board:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019545.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019566.html

For that board, the solution was that the Intel ICH7 chip controlled
the fan using a GPIO pin. But he wasn't getting a "Permission denied"
error. Can you please double-check that you have permission to write
to the files? I'm not going to quiz you on your setup (SELinux? or a
problem in /etc/sudoers?) -- but I'll take your word for it that it's
a driver error and not a sysfs permissions error.

I'm going to check through the driver code and look for a possible
reason. I'll get back to you.

Cheers,
David

P.S. Don't forget to CC the lm-sensors list, as I have done.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
