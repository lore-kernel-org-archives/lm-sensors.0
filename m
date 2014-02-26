From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 26 Feb 2014 07:20:03 +0000
Subject: Re: [lm-sensors] HP ProLiant MicroServer
Message-Id: <20140226082003.70e990b6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL9G6WVNxpchDgqTkUS7ad-j0f-h20YCo0FtCrVL0ra8F-ttYw@mail.gmail.com>
In-Reply-To: <CAL9G6WVNxpchDgqTkUS7ad-j0f-h20YCo0FtCrVL0ra8F-ttYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Josu,

On Tue, 25 Feb 2014 22:18:14 +0100, Josu Lazkano wrote:
> Hello, I have a HP ProLiant MicroServer with Debian Wheezy (3.2 kernel).
>=20
> I want to get some hardware information such processor temperature, fan s=
peed...
>=20
> I execute "sensors-detect" and it load the "jc42" module, but I just
> have this information:
>=20
> # sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +32.5=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +100.0=B0C, hyst =3D +95.0=B0C)
>=20

The jc42 driver doesn't appear to be loaded. Beware that sensors-detect
only detects which drivers are needed, it doesn't load them by itself.
Read carefully what it says at the end, you probably need to add the
relevant drivers to /etc/modules, and then either reboot or load the
modules manually once (using modprobe.)

> Is it possible to get more information? disk temperature? fan speed?

That I can't say without seeing the complete output of sensors-detect.
If the hardware is recent, you may want to try the most recent version:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

The jc42 driver will tell you the temperature of the memory modules,
nothing else.

Disk temperature is not yet supported by the lm-sensors framework. If
you need it, check either hddtemp or smartctl (from smartmontools.)

It is possible that your system needs SMBus multiplexing or support for
extra SMBus channels, I seem to recall people mentioning that on the
ProLiant MicroServer N36L and maybe N40L and N54L too.

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
