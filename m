From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Jun 2007 15:06:11 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <20070611170611.323f77ca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Sat, 9 Jun 2007 13:56:43 +0200, Ivo Manca wrote:
> Sensors gives a temprature after removing & loading the module:
>=20
> [root@localhost ~]# sensors -c /dev/null
> sis5595-isa-0290
> Adapter: ISA adapter
> in0:       +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in1:       +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in2:       +2.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in3:       +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
> fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
> temp:       +158=B0C  (high =3D   +52=B0C, hyst =3D   +52=B0C)
> alarms:   Board temperature input (usually LM75 chips) ALARM

Not exactly a good temperature though. According to the driver source,
158=B0C corresponds to a register value of 127 degree C - which means
saturation. So it's no good.

One possibility that I am only thinking of now, is that the temperature
might be provided by a thermistor and not a diode. In which case it
would make sense that the BIOS leaves in4 as a voltage input. So can
you please revert the PCI configuration change:

setpci -d 1039:0008 7a.b=00:80

Then reload the driver, check the voltage values, then put some load on
the CPU (e.g. md5sum /dev/zero) for several minutes and check if any of
the voltages changed significantly. If one did, then this input might
be connected to a thermistor. Unfortunately, without technical
information from the manufacturer, it will be difficult to find out how
to translate the voltage into a temperature.

> > For fans, do you have 3-wire fans? Are they connected to headers on
> > the motherboard? If they are relatively slow, maybe we need to increase
> > the divider to get a reading.
>
> As far as I can remember (I'll have to look into it tomorrow), my fan is =

> connected directly to the PSU, bypassing the motherboard.

OK, then it's no surprise that you get no reading, neither in the BIOS
no in "sensors". You need a 3-wire fan plugged into the motherboard fan
header to get a speed reading.

> [root@localhost ivo]# sensors -c sensors-PCChips -s
> [root@localhost ivo]# sensors -c sensors-PCChips
> sis5595-isa-0290
> Adapter: ISA adapter
> +2.5V:     +2.96 V  (min =3D  +2.26 V, max =3D  +2.75 V)   ALARM
> +3.3V:     +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +5.0V:     +5.09 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> Vcore:     +2.05 V  (min =3D  +1.90 V, max =3D  +2.10 V)
> fan1:        0 RPM  (min =3D  998 RPM, div =3D 8)          ALARM
> fan2:        0 RPM  (min =3D  998 RPM, div =3D 8)          ALARM
> CPU Temp:   +158=C2=B0C  (high =3D   +52=C2=B0C, hyst =3D   +52=C2=B0C)
>=20
> It seems like the +5,0V actually makes complete sense now!

Well, I crafted the configuration file to make it look good, so it
doesn't mean much ;)

> However, what's=20
> up with the Temp? The default sensors.conf speaks about a vendor.ini. I=20
> suppose this should be coming with AMI's utility?
> I''m not really sure if I understand what's ment with all the computing=20
> stuff standing there ;)

No idea what vendor.ini they're talking about. The computing stuff is
there to account for different thermal diode types, but as I said
above, I don't think you have a thermal diode, so no amount of
computing will give you a temperature value while in4 is in temperature
mode.

> > What's your CPU? Do you happen to know its nominal vcore?
> It's an Intel Celeron 366. According to this page=20
> (http://www.intel.com/support/processors/celeron/sb/CS-007435.htm#Voltage=
%20Requirements),=20
> it is 2,00V.

Good, exactly what I put in the config file :)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
