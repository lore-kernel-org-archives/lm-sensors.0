From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 May 2007 12:08:02 +0000
Subject: Re: [lm-sensors] Negative values after fan replacement
Message-Id: <20070513140802.61c196c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1178141638.9629.47.camel@camposuperbo>
In-Reply-To: <1178141638.9629.47.camel@camposuperbo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rouven,

Please always reply to the list, not to me only. Only the DSDT file I
wanted you to send in private.

On Tue, 08 May 2007 10:58:49 +0000, Rouven Sacha wrote:
> Am Dienstag, den 08.05.2007, 11:55 +0200 schrieb Jean Delvare:
>=20
> > > May  2 18:41:43 blinkenmail kernel: ACPI: Unable to turn cooling devi=
ce
> > > [c1b17dec] 'on'
> >=20
> > You may want to report this to the ACPI folks and/or your hardware
> > vendor, as this looks like a bug either in the Linux acpi code, or in
> > your system's BIOS.
>=20
> thanks for your kind reply. What makes you think it is a bug, i.e. how
> do I know that "Unable to turn cooling device on" isn't a proper error
> message from the acpi subsystem due to a broken fan?

Because lm_sensors shows two spinning fans.

> Unfortunately I forgot to mention that the system had a 3.0 load for
> about half an hour or so, which it never had before, so this incident
> doesn't look too random to me ...

Of course. I never meant to imply that it was random. The message you
got from ACPI makes it pretty clear that your system was really getting
hot.

> > I guess that you didn't power-off the system, and that it isn't really
> > an option?
>=20
> I can only guess. If the support guy really changed the fan, he would of
> course have been forced to do a cold boot after that. If he only
> switched of the sensors in the servers bios, it might as well have been
> a warm reboot. If you think a cold reboot would help, i can try to make
> the support initiate one tonight.

I don't really think it will help. But I just can't tell what happened
to your temperature reading, so I was suggesting a cold boot just in
case.

> > Does the ACPI temperature look reasonable ("acpi -t" or look directly
> > in /proc/acpi/thermal_zone/*/temperature)? It could be a conflict
> > between ACPI and the w83627hf driver. Can you please send me (in
> > private) a copy of /proc/acpi/dsdt?
>=20
> I unloaded w83627hf, modprobed thermal, with the following output:
>=20
> > 12:43:41 blinkenmail:/ # acpi -t
> > No support for device type: battery
> >      Thermal 1: ok, 0.0 degrees C

Not exactly correct.

> sensors gives constant values of -93,5 =B0C, regardless if thermal.ko is
> loaded alongside with w83627hf or not.
>=20
> You'll find the dsdt attached.

It seems to be corrupted, possibly because you named it "dsdt.txt"
while it is actually a binary file.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
