From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Oct 2012 20:09:36 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <20121021200936.GA6070@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Oct 21, 2012 at 11:18:56AM -0700, camden lindsay wrote:
> Hello-
> I've had this motherboard since January 2011 had never gotten fan control
> to work.  It seems to be either a driver or hardware implementation issue.
>  It doesn't appear to have the atk0110 acpi methods of hardware control.
>  When i try to echo any numbers into pwm_{1..3} they do not actually write
> to the ?file?/?register?
>=20
> I hadn't looked too deeply into it, so as to understand the ACPI/ATK0110 =
vs
> legacy W83667HG-B  control until recently.  About as far as i had gotten
> previously was to read http://www.lm-sensors.org/wiki/AsusFormulaHacking.
> Recently started looking further into it for a variety of reasons;  I am
> now sure that my board does not have any ATK0110 devices on it:
>=20
>=20
> Details:
> Kernel information
> Linux BigBox 3.4.9-gentoo #1 SMP Sat Oct 20 21:41:06 PDT 2012 x86_64
> Intel(R) Core(TM) i3 CPU 540 @ 3.07GHz GenuineIntel GNU/Linux
>=20
> Modprobe of atk shows nothing in dmesg
> BigBox w83627ehf.656 # modprobe asus-atk0110
>=20
> dylan@BigBox ~/My_Utils/acpi $ lsmod | grep asus
> asus_atk0110            8614  0
>=20
> BigBox w83627ehf.656 # dmesg | tail -3
> [   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
> [   57.806564] eth0: no IPv6 routers present
> [   69.009033] netlink: 12 bytes leftover after parsing attributes.
>=20
>=20
> dsdt.dsl does not have any of the 'key' atk stuff in it from the above
> mentioned webpage:
> dylan@BigBox ~/My_Utils/acpi $ grep -i -e asoc -e vbuf -e v500 -e v12v
> dsdt.dsl
> dylan@BigBox ~/My_Utils/acpi $
>=20
>=20
> I don't have no-apci on my kernel command line, there are no conflicts
> listed for acpi in dmesg, and the drivers for the sensor chip load happily
> dylan@BigBox ~/My_Utils/acpi $ cat /proc/cmdline
> root=3D/dev/md3
>=20
> dylan@BigBox ~/My_Utils/acpi $ dmesg | grep w83627ehf
> [   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
> dylan@BigBox ~/My_Utils/acpi $
>=20
> dylan@BigBox ~/My_Utils/acpi $ dmesg | grep conflict
> dylan@BigBox ~/My_Utils/acpi $
>=20
>=20
> dylan@BigBox ~/My_Utils/acpi $ sensors w83667hg-isa-0290
> w83667hg-isa-0290
> Adapter: ISA adapter
> Vcore:         +0.89 V  (min =3D  +0.60 V, max =3D  +1.50 V)
> in1:           +1.73 V  (min =3D  +1.50 V, max =3D  +1.88 V)
> AVCC:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:         +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:           +1.67 V  (min =3D  +1.50 V, max =3D  +1.83 V)
> in5:           +1.69 V  (min =3D  +1.76 V, max =3D  +2.04 V)  ALARM
> in6:           +1.49 V  (min =3D  +1.34 V, max =3D  +1.65 V)
> 3VSB:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> Rear_Fan:     3590 RPM  (min =3D  888 RPM, div =3D 8)
> CPU_Fan:      1854 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
> HD_Fan0:      3590 RPM  (min =3D 1298 RPM, div =3D 8)
> HD_Fan1:      3668 RPM  (min =3D  865 RPM, div =3D 8)
> fan5:            0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> PECI Agent 1:   +6.0=B0C  (high =3D +60.0=B0C, hyst =3D +58.0=B0C)  senso=
r =3D Intel
> PECI
> PECI Agent 1:   +6.0=B0C  (high =3D +89.0=B0C, hyst =3D +88.0=B0C)  senso=
r =3D Intel
> PECI
> SYSTIN:        +22.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D
> thermistor
> CPUTIN:        -54.0=B0C
> cpu0_vid:     +0.000 V
> intrusion0:   OK
>=20
>=20
> In Bios the fans are set to 'no control / full speed' (i've tried in other
> modes too)
>=20
> Now, as root.. i can change the settings in  pwm_enable (following doc for
> kernel driver for values)
> BigBox w83627ehf.656 # head *_enable
> =3D=3D> pwm1_enable <=3D=3D
> 1
> =3D=3D> pwm2_enable <=3D=3D
> 1
> =3D=3D> pwm3_enable <=3D=3D
> 1
> BigBox w83627ehf.656 # for i in $(seq 3); do echo 2 >pwm${i}_enable; done
> BigBox w83627ehf.656 # head *_enable
> =3D=3D> pwm1_enable <=3D=3D
> 2
> =3D=3D> pwm2_enable <=3D=3D
> 2
> =3D=3D> pwm3_enable <=3D=3D
> 2
>=20
Should be 1 for manual mode. Supposedly this is the only mode where you can
write into the pwm attribute.

> As root I can also change the values for pwm_mode
> BigBox w83627ehf.656 # head *_mode
> =3D=3D> pwm1_mode <=3D=3D
> 1
> =3D=3D> pwm2_mode <=3D=3D
> 1
> =3D=3D> pwm3_mode <=3D=3D
> 1
> BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}_mode; done
> BigBox w83627ehf.656 # head *_mode
> =3D=3D> pwm1_mode <=3D=3D
> 0
> =3D=3D> pwm2_mode <=3D=3D
> 0
> =3D=3D> pwm3_mode <=3D=3D
> 0
>=20
In general you don't want to change pwmX_mode, since it changes the mode fr=
om
pwm output (1) to DC output (0).

>=20
> But i cannot change the pwm{1..3} values themselves..
> BigBox w83627ehf.656 # head pwm{1..3}
> =3D=3D> pwm1 <=3D=3D
> 255
> =3D=3D> pwm2 <=3D=3D
> 255
> =3D=3D> pwm3 <=3D=3D
> 255
> BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}; done
> BigBox w83627ehf.656 # head pwm{1..3}
> =3D=3D> pwm1 <=3D=3D
> 255
> =3D=3D> pwm2 <=3D=3D
> 255
> =3D=3D> pwm3 <=3D=3D
> 255
>=20
>=20
> There don't appear to be any errors, etc.
>=20
> According to some threads in a bug on speedfan, there are some major
> problem with the W83667HG-B datasheet -- but i can't figure out how to
> contact/ask for what the bugs were...
> http://www.bugtrack.almico.com/view.php?id=3D1528#c5586
>=20
Unfortunately, the datasheet problem is not explained in detail.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
