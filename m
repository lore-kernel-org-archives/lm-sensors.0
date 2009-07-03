From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 03 Jul 2009 07:46:53 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <20090703094653.0283c525@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Niels,

On Wed, 01 Jul 2009 19:22:04 +0200, Niels wrote:
> I'm having trouble with my pwmconfig.
>=20
> Code:
> Found the following PWM controls:
>    hwmon2/device/pwm1
>    hwmon2/device/pwm2
>    hwmon2/device/pwm3
> There are no usable PWM outputs.

Which version of lm-sensors (or pwmconfig) is this?

I would like to see the full output of pwmconfig and not just the above
summary.

> Though my sensors cleary reads out the fans

Many boards can monitor the fans but not control them. What board is it?

>=20
> Code:
> nelis@nelis-desktop:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +41.0=B0C  (crit =3D +70.0=B0C)
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +36.0=B0C
> Core1 Temp:  -49.0=B0C
> f71862fg-isa-0220
> Adapter: ISA adapter
> in0:         +1.70 V
> in1:         +2.04 V
> in2:         +1.20 V
> in3:         +2.04 V
> in4:         +1.34 V
> in5:         +1.18 V
> in6:         +1.18 V
> in7:         +1.68 V
> in8:         +1.66 V
> fan1:       2538 RPM
> fan2:       2222 RPM
> fan3:          0 RPM  ALARM
> temp1:       +41.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
>                       (crit =3D +70.0=B0C, hyst =3D +66.0=B0C)  sensor =
=3D transistor
> temp2:       +89.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)  ALARM
>                       (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D transistor
> temp3:       +44.0=B0C  (high =3D +254.0=B0C, hyst =3D +252.0=B0C)
>                       (crit =3D +254.0=B0C, hyst =3D +252.0=B0C)  sensor =
=3D transistor
>=20
> Anyone got an idea on how to deal with this ?

I would be interested in the output of the following commands:

grep -H . /sys/class/hwmon/hwmon*/device/name
grep -H . /sys/class/hwmon/hwmon*/device/pwm*
ls -l /sys/class/hwmon/hwmon*/device/pwm*

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
