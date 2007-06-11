From: "Ivo Manca" <pinkel@gmail.com>
Date: Mon, 11 Jun 2007 16:21:13 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <00a901c7ac44$89360180$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hey Jean,

> Not exactly a good temperature though. According to the driver source,
> 158=B0C corresponds to a register value of 127 degree C - which means
> saturation. So it's no good.

> One possibility that I am only thinking of now, is that the temperature
> might be provided by a thermistor and not a diode. In which case it
> would make sense that the BIOS leaves in4 as a voltage input. So can
> you please revert the PCI configuration change:

> setpci -d 1039:0008 7a.b=00:80
Done

> Then reload the driver, check the voltage values, then put some load on
> the CPU (e.g. md5sum /dev/zero) for several minutes and check if any of
> the voltages changed significantly. If one did, then this input might
> be connected to a thermistor. Unfortunately, without technical
> information from the manufacturer, it will be difficult to find out how
> to translate the voltage into a temperature.
[root@localhost ivo]# sensors -c sensors-PCChips
sis5595-isa-0290
Adapter: ISA adapter
+2.5V:     +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+3.3V:     +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+5.0V:     +5.09 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
Vcore:     +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:       +3.55 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM

after md5sum:
[root@localhost ivo]# sensors -c sensors-PCChips
sis5595-isa-0290
Adapter: ISA adapter
+2.5V:     +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+3.3V:     +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+5.0V:     +5.15 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
Vcore:     +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:       +0.19 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM

Seems like in4 dropped completely?
Wait: it seemed like a flatcable dropped on the fan, and stopped it=20
spinning. So I guess +0,19V is suppose to say "Way to hot: you're burning=20
your fingers!"? (Since I actually did burn my finger)

But one minute after the fan started spinning again...
[root@localhost ivo]# sensors -c sensors-PCChips
sis5595-isa-0290
Adapter: ISA adapter
+2.5V:     +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+3.3V:     +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+5.0V:     +5.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
Vcore:     +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM

And 30 seconds later:
[root@localhost ivo]# sensors -c sensors-PCChips
sis5595-isa-0290
Adapter: ISA adapter
+2.5V:     +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+3.3V:     +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+5.0V:     +5.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
Vcore:     +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:       +4.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM

After a complete cooldown period (30 mins idling)
[root@localhost ivo]# sensors -c sensors-PCChips
sis5595-isa-0290
Adapter: ISA adapter
+2.5V:     +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+3.3V:     +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+5.0V:     +5.09 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
Vcore:     +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:       +3.42 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM


Is there any way to get information from PCCHIPS, or is it just a waste of =

time to request information from them?

> OK, then it's no surprise that you get no reading, neither in the BIOS
> no in "sensors". You need a 3-wire fan plugged into the motherboard fan
> header to get a speed reading.
They are indeed connected directly, so no wonder it's not showing up. I=20
don't have any 3-wire fan available anymore, so I can't test that.

> Well, I crafted the configuration file to make it look good, so it
> doesn't mean much ;)
Is there actually any way to see if it is correct, not involving to use a=20
multimeter? I lost mine, so I should buy a new one ;p

> No idea what vendor.ini they're talking about. The computing stuff is
> there to account for different thermal diode types, but as I said
> above, I don't think you have a thermal diode, so no amount of
> computing will give you a temperature value while in4 is in temperature
> mode.
True. However, I suppose their AMI utitly _does_ give temperature=20
information to windows, however, this is only a guess. I will look through =

all the CD's I own to find if I didnt' accidently overlookad the CD. Have n=
o=20
luck yet. However, I was able to download the app for a different=20
motherboard, which has mainly refferences to the LM75 chip... I wonder what=
=20
kind of output it will give. Trying to find a windows 98 installation now ;)


> Good, exactly what I put in the config file :)

Thanks,
Ivo=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
