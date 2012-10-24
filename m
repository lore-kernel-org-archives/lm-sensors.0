From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Oct 2012 05:04:06 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <20121024050406.GA561@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Oct 21, 2012 at 01:41:26PM -0700, camden lindsay wrote:
> Thanks for the reply, Guenter--
> Does not work in 1, either. I had tested before, I was simply showing that
> i could write to all of those locations.  Just in case, let me re-do tho =
to
> double check and provide more information.
>=20
> In BIOS the available fan control options are
> "Full speed mode"
> "High Density Mode"
> "Generic Mode"
> "Whisper Mode"
>=20
Hi,

Please don't top-post.

If you set anything but full speed mode, do you see different pwm values ?

Also, please provide the output of

	sudo isadump -y 0x295 0x296 0
	sudo isadump -y 0x295 0x296 8
	sudo isadump -y 0x295 0x296 9
	sudo isadump -y 0x295 0x296 10
	sudo isadump -y 0x295 0x296 11

Thanks,
Guenter

> I have them set to 'Full speed mode"
> Here is what the pwm info looks like by default after changing to this
> setting (from whatever to "Full speed mode"
> BigBox device # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable
> ${i}_mode; done
> pwm1
> 255
> 1
> 0
> pwm2
> 255
> 2
> 1
> pwm3
> 255
> 1
> 1
>=20
>=20
> I change them to be 1:
> BigBox device # for i in $(seq 3); do echo 1 >pwm${i}_enable; done
> BigBox device # for i in $(seq 3); do echo 1 >pwm${i}_mode; done
>=20
> BigBox device # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable
> ${i}_mode; done
> pwm1
> 255
> 1
> 1
> pwm2
> 255
> 1
> 1
> pwm3
> 255
> 1
> 1
>=20
>=20
> I try to echo 200 into pwm1:
> BigBox device # echo 200 >pwm1
>=20
> But it doesn't stick..
> BigBox device # cat pwm1
> 255
>=20
>=20
> Additionally, all of these settings get wiped across reboot.
> (reboot)
> BigBox device # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable
> ${i}_mode; done
> pwm1
> 255
> 1
> 0
> pwm2
> 255
> 2
> 1
> pwm3
> 255
> 1
> 1
>=20
>=20
> I assume that bios sets them at boot time, and there is not 'off' for the
> fan control settings for bios :(.
> I figure i could set up a startup script to fix the _enable and _mode to
> begin with if only pwm{1..3} worked.
>=20
> take care..
>=20
>=20
>=20
>=20
>=20
> On Sun, Oct 21, 2012 at 1:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> > On Sun, Oct 21, 2012 at 11:18:56AM -0700, camden lindsay wrote:
> > > Hello-
> > > I've had this motherboard since January 2011 had never gotten fan con=
trol
> > > to work.  It seems to be either a driver or hardware implementation
> > issue.
> > >  It doesn't appear to have the atk0110 acpi methods of hardware contr=
ol.
> > >  When i try to echo any numbers into pwm_{1..3} they do not actually
> > write
> > > to the ?file?/?register?
> > >
> > > I hadn't looked too deeply into it, so as to understand the ACPI/ATK0=
110
> > vs
> > > legacy W83667HG-B  control until recently.  About as far as i had got=
ten
> > > previously was to read http://www.lm-sensors.org/wiki/AsusFormulaHack=
ing
> > .
> > > Recently started looking further into it for a variety of reasons;  I=
 am
> > > now sure that my board does not have any ATK0110 devices on it:
> > >
> > >
> > > Details:
> > > Kernel information
> > > Linux BigBox 3.4.9-gentoo #1 SMP Sat Oct 20 21:41:06 PDT 2012 x86_64
> > > Intel(R) Core(TM) i3 CPU 540 @ 3.07GHz GenuineIntel GNU/Linux
> > >
> > > Modprobe of atk shows nothing in dmesg
> > > BigBox w83627ehf.656 # modprobe asus-atk0110
> > >
> > > dylan@BigBox ~/My_Utils/acpi $ lsmod | grep asus
> > > asus_atk0110            8614  0
> > >
> > > BigBox w83627ehf.656 # dmesg | tail -3
> > > [   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
> > > [   57.806564] eth0: no IPv6 routers present
> > > [   69.009033] netlink: 12 bytes leftover after parsing attributes.
> > >
> > >
> > > dsdt.dsl does not have any of the 'key' atk stuff in it from the above
> > > mentioned webpage:
> > > dylan@BigBox ~/My_Utils/acpi $ grep -i -e asoc -e vbuf -e v500 -e v12v
> > > dsdt.dsl
> > > dylan@BigBox ~/My_Utils/acpi $
> > >
> > >
> > > I don't have no-apci on my kernel command line, there are no conflicts
> > > listed for acpi in dmesg, and the drivers for the sensor chip load
> > happily
> > > dylan@BigBox ~/My_Utils/acpi $ cat /proc/cmdline
> > > root=3D/dev/md3
> > >
> > > dylan@BigBox ~/My_Utils/acpi $ dmesg | grep w83627ehf
> > > [   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
> > > dylan@BigBox ~/My_Utils/acpi $
> > >
> > > dylan@BigBox ~/My_Utils/acpi $ dmesg | grep conflict
> > > dylan@BigBox ~/My_Utils/acpi $
> > >
> > >
> > > dylan@BigBox ~/My_Utils/acpi $ sensors w83667hg-isa-0290
> > > w83667hg-isa-0290
> > > Adapter: ISA adapter
> > > Vcore:         +0.89 V  (min =3D  +0.60 V, max =3D  +1.50 V)
> > > in1:           +1.73 V  (min =3D  +1.50 V, max =3D  +1.88 V)
> > > AVCC:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > +3.3V:         +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > in4:           +1.67 V  (min =3D  +1.50 V, max =3D  +1.83 V)
> > > in5:           +1.69 V  (min =3D  +1.76 V, max =3D  +2.04 V)  ALARM
> > > in6:           +1.49 V  (min =3D  +1.34 V, max =3D  +1.65 V)
> > > 3VSB:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> > > Rear_Fan:     3590 RPM  (min =3D  888 RPM, div =3D 8)
> > > CPU_Fan:      1854 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
> > > HD_Fan0:      3590 RPM  (min =3D 1298 RPM, div =3D 8)
> > > HD_Fan1:      3668 RPM  (min =3D  865 RPM, div =3D 8)
> > > fan5:            0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> > > PECI Agent 1:   +6.0=B0C  (high =3D +60.0=B0C, hyst =3D +58.0=B0C)  s=
ensor =3D Intel
> > > PECI
> > > PECI Agent 1:   +6.0=B0C  (high =3D +89.0=B0C, hyst =3D +88.0=B0C)  s=
ensor =3D Intel
> > > PECI
> > > SYSTIN:        +22.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  s=
ensor =3D
> > > thermistor
> > > CPUTIN:        -54.0=B0C
> > > cpu0_vid:     +0.000 V
> > > intrusion0:   OK
> > >
> > >
> > > In Bios the fans are set to 'no control / full speed' (i've tried in
> > other
> > > modes too)
> > >
> > > Now, as root.. i can change the settings in  pwm_enable (following doc
> > for
> > > kernel driver for values)
> > > BigBox w83627ehf.656 # head *_enable
> > > =3D=3D> pwm1_enable <=3D=3D
> > > 1
> > > =3D=3D> pwm2_enable <=3D=3D
> > > 1
> > > =3D=3D> pwm3_enable <=3D=3D
> > > 1
> > > BigBox w83627ehf.656 # for i in $(seq 3); do echo 2 >pwm${i}_enable; =
done
> > > BigBox w83627ehf.656 # head *_enable
> > > =3D=3D> pwm1_enable <=3D=3D
> > > 2
> > > =3D=3D> pwm2_enable <=3D=3D
> > > 2
> > > =3D=3D> pwm3_enable <=3D=3D
> > > 2
> > >
> > Should be 1 for manual mode. Supposedly this is the only mode where you=
 can
> > write into the pwm attribute.
> >
> > > As root I can also change the values for pwm_mode
> > > BigBox w83627ehf.656 # head *_mode
> > > =3D=3D> pwm1_mode <=3D=3D
> > > 1
> > > =3D=3D> pwm2_mode <=3D=3D
> > > 1
> > > =3D=3D> pwm3_mode <=3D=3D
> > > 1
> > > BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}_mode; do=
ne
> > > BigBox w83627ehf.656 # head *_mode
> > > =3D=3D> pwm1_mode <=3D=3D
> > > 0
> > > =3D=3D> pwm2_mode <=3D=3D
> > > 0
> > > =3D=3D> pwm3_mode <=3D=3D
> > > 0
> > >
> > In general you don't want to change pwmX_mode, since it changes the mode
> > from
> > pwm output (1) to DC output (0).
> >
> > >
> > > But i cannot change the pwm{1..3} values themselves..
> > > BigBox w83627ehf.656 # head pwm{1..3}
> > > =3D=3D> pwm1 <=3D=3D
> > > 255
> > > =3D=3D> pwm2 <=3D=3D
> > > 255
> > > =3D=3D> pwm3 <=3D=3D
> > > 255
> > > BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}; done
> > > BigBox w83627ehf.656 # head pwm{1..3}
> > > =3D=3D> pwm1 <=3D=3D
> > > 255
> > > =3D=3D> pwm2 <=3D=3D
> > > 255
> > > =3D=3D> pwm3 <=3D=3D
> > > 255
> > >
> > >
> > > There don't appear to be any errors, etc.
> > >
> > > According to some threads in a bug on speedfan, there are some major
> > > problem with the W83667HG-B datasheet -- but i can't figure out how to
> > > contact/ask for what the bugs were...
> > > http://www.bugtrack.almico.com/view.php?id=3D1528#c5586
> > >
> > Unfortunately, the datasheet problem is not explained in detail.
> >
> > Guenter
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
