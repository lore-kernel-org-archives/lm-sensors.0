From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 20:58:15 +0000
Subject: Re: [lm-sensors] ITE IT8721F, IT8758E it87 standalone driver report
Message-Id: <20110407225815.334823dc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2610648201.20110407001722@mail.ru>
In-Reply-To: <2610648201.20110407001722@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Please always reply to the list when a discussion started on said list.
People who read the beginning of a story are often interested in its
end too.

On Thu, 7 Apr 2011 23:29:11 +0400, Rebel wrote:
> > On Thu, 7 Apr 2011 00:17:22 +0400, atr_temp@mail.ru wrote:
> >> Hello, Lm-sensors.
> >>=20
> >> Sending  report  about using standalone driver for IT8721F, IT8758E at
> >> Ubuntu 9.10 with kernel 2.6.31.12 with motherboard Foxconn D42S.
> >>=20
> >> I  was  unable  to build just driver from sources, so i put it into my
>=20
> > Can you please report what the problem was? I would like to fix it.
>=20
> When  i  run "make" in it87 driver folder, it was unable to find some .o
> files,  so  i had to build kernel. And now, when i already have kernel
> built there is no errors. So it is not a problem :)

Yes, standalone drivers need a configured kernel tree to build. So they
aren't completely standalone.

> >> kernel sources: replace original drivers/hwmon/it87.c with new one.
> >> Next i compile and install kernel and found a problem:
> >> > # modprobe it87
> >> > FATAL: Error inserting it87 (/lib/modules/***/drivers/hwmon/it87.ko)=
: Device or resource busy
> >> But found a solution:
> >> > Basically, you need to add a new kernel line in your menu.lst to fix
> >> > this behavior.
> >> > acpi_enforce_resources=3Dlax
> >> And it was good for me.
> >> Now the sensors give me correct output, but without names (temp1, fan1
> >> and  so  on), so i had to edit /etc/sensors.conf and now the output is
> >> correct for me (temp and fans)
> >> > # sensors
> >> > acpitz-virtual-0
> >> > Adapter: Virtual device
> >> > temp1: +55.0=B0C (crit =3D +85.0=B0C)
> >> >
> >> > it8721-isa-0a10
> >> > Adapter: ISA adapter
> >> > in0: +2.76 V (min =3D +1.38 V, max =3D +2.05 V) ALARM
> >> > in1: +2.80 V (min =3D +1.30 V, max =3D +3.05 V)
> >> > in2: +2.06 V (min =3D +0.66 V, max =3D +2.98 V)
> >> > +3.3V: +3.41 V (min =3D +5.66 V, max =3D +1.87 V) ALARM
> >> > in4: +1.87 V (min =3D +2.82 V, max =3D +2.60 V) ALARM
> >> > in5: +1.04 V (min =3D +1.68 V, max =3D +1.02 V) ALARM
> >> > in6: +2.23 V (min =3D +1.43 V, max =3D +1.48 V) ALARM
> >> > 3VSB: +3.24 V (min =3D +4.37 V, max =3D +0.72 V) ALARM
> >> > Vbat: +3.05 V
>=20
> > If you want help to figure out the labels and scaling factors of the
> > remaining voltage inputs, please go to your BIOS, find the hardware
> > monitoring menu, and write down all voltage values it reports. If a
> > given item oscillates between different values, write them all down.
>=20
> Here is my bios output:
>=20
> CPU Core 1.044 V

This is a little surprising but that would be in5.

> DRAM Voltage 1.827 V

Maybe in4, although the value is slightly different.

> +3.30V 3.401V

in3, already labeled as it is an internal voltage for the IT8721F chip.

> +5.00V 4.988V
> +12.0V 11.816V

For these two, we would need more values from the BIOS to conclude, as
we have 4 candidates (in0, in1, in2 and in6.)

>=20
> >> > CPU Fan: 903 RPM (min =3D 14 RPM)
> >> > Sys Fan: 0 RPM (min =3D 12 RPM) ALARM
>=20
> > Are these correct?
>=20
> Yes  it is. CPU fan is controlled by pwm in bios, system fan is absent
> (but there is 4-pin connector for it).
>=20
> >> > CPU Temp: +54.0=B0C (low =3D -107.0=B0C, high =3D +80.0=B0C) sensor =
=3D thermal diode
> >> > temp2: -56.0=B0C (low =3D -10.0=B0C, high =3D +127.0=B0C) sensor =3D=
 thermal diode
> >> > M/B   Temp:   +35.0=B0C   (low  =3D  -61.0=B0C,  high =3D +127.0=B0C=
) sensor =3D thermal diode
>=20
> > Apparently temp2 isn't connected so you can add:
>=20
> >    ignore temp2
>=20
> > to your configuration file. You could also adjust the temperature
> > limits for temp1 and temp3.
>=20
> > If you come up with a good configuration file, please post it and I'll
> > add it to the wiki.
>=20
> This output i made by adding chip and labels to sensors.conf
> chip "it8721-*"
> label temp1 "CPU Temp"
> label temp3 "M/B Temp"
> label fan1 "CPU Fan"
> label fan2 "Sys Fan"
> After this  i  run  sensors  but  it  outputs  temp1, temp2 and so on (no=
 my
> labels).  Next  i  run  "sensors  -c /etc/sensors.conf"  and  output  was
> correct.  And after deleting chip and labels from configuration file too.

This is simply not possible. "sensors" reads the configuration files
again each time to run it.

> All  next  times  running  sensors without -c the output was
> correct, why?

Not sure what you did exactly, but /etc/sensors.conf is not used by
lm-sensors 3.x if /etc/sensors3.conf is present. /etc/sensors3.conf is
always checked first, to make it possible to have both lm-sensors 2 and
lm-sensors 3 installed on a given machine (although nobody should be
doing this any longer.)

The preferred approach these days is to leave /etc/sensors3.conf
untouched, and create a dedicated configuration file for your mainboard
in directory /etc/sensors.d.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
