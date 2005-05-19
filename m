From: swl@ucs.co.za (stu)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <20040709120848.64f1735b@pegasus.ucs.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040708184144.4554439e@pegasus.ucs.co.za>
In-Reply-To: <20040708184144.4554439e@pegasus.ucs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 8 Jul 2004 22:54:11 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > I hope this is the correct forum to report bugs, and that this bug
> > hasn't been reported already. If it isn't the correct forum, please
> > let me know where I should report it.
> >=20
> > Just downloaded and installed lm_sensors-2.8.7 from source. I've
> > found a small bug. When I run mkdev.sh, it creates devices named
> > like so :
> >=20
> > /dev/i2c-0
> > etc
> >=20
> > However, sensors-detect looks for a device named /dev/i2c/0  and
> > can't find it. This causes sensors-detect to skip the probing of my
> > SMBus Via Pro adapter, and gives the error :
> >=20
> > Can't open /dev/i2c/0
>=20
> First of all, which version of lm_sensors are you using?

As above, version 2.8.7 . I downloaded it yesterday using :

http://www.lm-sensors.nu/archive/lm_sensors-2.8.7.tar.gz

> If the sensors-detect script searches for /dev/i2c/0, it means that it
> detected that your system uses devfs. Is it true?

*blush* yes, it does. (me hangs his head in shame for not reading the
instructions thoroughly)

> If you are using the latest version if sensors-detect AND you use
> devfs AND you have i2c-dev loaded AND sensors-detect still complains,
> then this is likely to be a problem with your bus driver (i2c-viapro).

When I insmod i2c-viapro, devfs doesn't create any new devices. However,
after reading your response this morning, I removed all the i2c devices
I created, rmmodded all i2c modules except i2c-core and i2c-dev and
reran sensors-detect. The same message appeared:

Can't open /dev/i2c/0

but I continued with the config process, ran sensors and voila! works
perfectly.=20

Now that I have it working, lm_sensors will be installed on all of a
client's servers (+- 200) and will be used to provide valuable, hitherto
inaccessible information about the state of their cpus and fans. If this
is successful, as I'm sure it will be, it is intended to roll out
lm_sensors to some of our other clients too.

Please accept an apology for my hasty assumption and thanks for a
great and essential tool!

- --=20
Stuart Logie
Programmer

UNIVERSAL COMPUTER SERVICES (PTY) LTD
  =20
Powered by Debian GNU/Linux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQCVAwUBQO5usOuEbVzzghHCAQLYQwP+N58iMkO3fOMXWAXF7EQgabxycOJ5HB+6
Td3TDV52AoSIQUFeCteWB1dodv6/3/kIsFYLWD7V/AhYpux5w0xtArW7ye0C+vUA
NPsCuMBVMW6xxU9PthjxdKu6cblF2XIyPLg5tk2tncTQ3MkN8ZpgAnWJMytIRK3G
ZQfbJIUJwsY=E7dH
-----END PGP SIGNATURE-----
