From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 08 Mar 2014 11:08:31 +0000
Subject: Re: [lm-sensors] 3.13.?: Strange / dangerous fan policy...
Message-Id: <20140308120831.328e0179@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <531A1EEE.9090101@netscape.net>
	<20140307205506.GA6870@roeck-us.net>
	<531A426D.6080100@netscape.net>
	<20140307225230.GA31135@roeck-us.net>
In-Reply-To: <20140307225230.GA31135@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel Krause <manuelkrause@netscape.net>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 7 Mar 2014 14:52:30 -0800, Guenter Roeck wrote:
> On Fri, Mar 07, 2014 at 11:04:29PM +0100, Manuel Krause wrote:
> > Hi, and thanks for the quick response!
> > No special fancy "fan control policy". 'fancontrol' isn't up or
> > running.
> > Vanilla kernels 3.11.* and 3.12.* had been working on here without
> > any extra work.
> > --
> > # sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +71.0=B0C  (crit =3D +256.0=B0C)
> > temp2:        +69.0=B0C  (crit =3D +110.0=B0C)
> > temp3:        +52.0=B0C  (crit =3D +105.0=B0C)
> > temp4:        +25.0=B0C  (crit =3D +110.0=B0C)
> > temp5:        +58.0=B0C  (crit =3D +110.0=B0C)
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:       +62.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
> > Core 1:       +60.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
> > --
> > My notebook (HP/Compaq 6730b) does not have a seperate fan sensor.
> > This is with 3.12.13 with my normal workload.
> >=20
> > Please, trust my above mentionned values of 94 =B0C vs. 74=B0C as I
> > don't like to boot 3.13.6 anymore, to avoid harm to the notebook's
> > casing.
>=20
> Understood. Unfortunately, we'll need to get information
> from the new kernel to be able to track down the problem.

Indeed. Not only the run-time temperatures, but also the high and crit
limits.

> > But I'd do to test any improvement-patch.
>=20
> So far I have no idea what is going on. I don't see anything in the
> drivers providing above data that would explain the behavior,
> but I might be missing something.

Looks like a regression in the acpi subsystem or in power management,
not hwmon. Hwmon is merely reporting the temperatures, it's not
responsible for the actual temperatures.

A bisection would certainly help, but of course that would require
booting to a bad kernel half of the time, which I understand Manual
wouldn't enjoy.

The only two components which I think can reach such high temperatures
in a laptop are the CPU and the GPU. I suppose that the "94 =B0C vs.
74=B0C" refers to acpitz's temp1? If the the temperatures reported by
coretemp remain the same, then I can only suppose that temp1 is the GPU
temperature. Please tell us which GPU is in this laptop, and which
driver you're using.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
