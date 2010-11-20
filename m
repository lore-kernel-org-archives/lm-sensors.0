From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Nov 2010 19:40:01 +0000
Subject: Re: [lm-sensors] it8726 chip?
Message-Id: <20101120204001.66ce151a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinP-Bk2MQugbyCz03uwEnLv3si5nvnYX1o-bJae@mail.gmail.com>
In-Reply-To: <AANLkTinP-Bk2MQugbyCz03uwEnLv3si5nvnYX1o-bJae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Sat, 20 Nov 2010 09:33:07 -0800, David Mathog wrote:
> > This is the old default section, which apparently doesn't apply to your
> > board at all, so you should forget about it and start again from
> > scratch. The new default section for that chip is almost empty and
> > reads:
> >
> > chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*"
> >
> > =A0 =A0label in8 "Vbat"
> >
> >> Kernel is from ubuntu 8.10, 2.6.27-11-generic. =A0Sensors is 3.0.2
> >>
> >> Any suggestions for improving these readings?
> >
> > Reboot, enter the BIOS setup screen, write down everything that's
> > printed in the hardware monitoring section, including multiple values
> > when a given entry oscillates between 2 or more values. The run sensors
> > without a configuration file (sensors -c /dev/null), and report all the
> > values here.
>=20
> The BIOS reports very little.  Here it is:
>=20
> CPU Vcore 1.24V
> VDimm 1.87V
> CPU Tcontrol 40C
> System Temp 32C
> CPU Fan Speed 3479, 3461 (alternating)
> System Fan 0

This could explain the wrong values. Maybe your chip has only a few
pins wired for monitoring.

>=20
> and
>=20
> %sensors -c /dev/null
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +15.0=C2=B0C  (crit =3D +75.0=C2=B0C)
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +16.0=C2=B0C
> temp2:        +7.0=C2=B0C
> temp3:        +4.0=C2=B0C
> temp4:       +10.0=C2=B0C
>=20
> it8716-isa-0228
> Adapter: ISA adapter
> in0:         +1.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +1.23 V  (min =3D  +1.28 V, max =3D  +1.68 V)   ALARM

Either of these could be Vcore. Try putting some load on the CPU and
see if any of them jumps to a greater value. That would be Vcore
(assuming you have cpufreq enabled.)

> in2:         +1.87 V  (min =3D  +2.78 V, max =3D  +3.78 V)   ALARM

This could be Vdimm.

> in3:         +2.91 V  (min =3D  +2.67 V, max =3D  +3.26 V)
> in4:         +1.22 V  (min =3D  +2.50 V, max =3D  +3.49 V)   ALARM
> in5:         +2.48 V  (min =3D  +0.58 V, max =3D  +1.34 V)   ALARM
> in6:         +1.81 V  (min =3D  +1.04 V, max =3D  +1.36 V)   ALARM
> in7:         +2.82 V  (min =3D  +2.67 V, max =3D  +3.26 V)
> in8:         +2.99 V

That one is Vbat, it's internal.

For the other voltages, please check the kernel log when you load the
it87 driver. Some voltage inputs can be routed internally, in which
case the driver will tell you.

> fan1:       3461 RPM  (min =3D   10 RPM)

This is CPU Fan.

> fan2:          0 RPM  (min =3D   10 RPM)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM)

Either of these is System Fan. Given the min of fan2 set to 10 RPM as
for the CPU Fan, I'd guess fan2 is System Fan.

> temp1:       +15.0=B0C  (low  =3D +127.0=B0C, high =3D +75.0=B0C)  sensor=
 =3D thermal diode

Seem a little low. Could be the CPU temperature, requiring some offset
to be meaningful. The AMD K8 is reputed for its horrible thermal diode
accuracy...

> temp2:       +34.0=B0C  (low  =3D +127.0=B0C, high =3D +75.0=B0C)  sensor=
 =3D transistor

System Temp, certainly.

> temp3:        -8.0=B0C  (low  =3D +127.0=B0C, high =3D +75.0=B0C)  sensor=
 =3D transistor

This one is obviously not used.

> cpu0_vid:   +1.000 V

Not sure what do to with this... it should match Vcore at some point in
time.

>=20
> (Ignore the =C2 characters, that's a unicode side effect on a terminal
> emulator that doesn't do unicode.)

You know you can edit the text before you send the mail, right? ;) As I
just did.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
