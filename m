From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: W83697HF or VT8233 (or not?)
Message-Id: <3BDF51E2.164F4C23@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3BDECF1E.1060900@md.prestige.net>
In-Reply-To: <3BDECF1E.1060900@md.prestige.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Your 83697 must be on the isa bus so you don't need
the CVS version of i2c-viapro to access it.
To force on the isa bus use the special bus number 9191:
'modprobe w83781d force_w83697hf=9191,0xXXX' where
XXX is probably 290 but check the output of sensors-detect
to see where it found it.

mds


Bruce Miller wrote:
>=20
> Hi Sensor Guys;
>=20
> Sorry to bother you with what is probably a trivial question, but
> I haven't entirely got the sensors & bus concept, yet.
>=20
> I've got an EPOX 8KHA mobo runnng VT8366 and VT8233 chipset.
> I've installed the 2.4.12 kernel, as patched by
> the i2c and lm_sensors 2.6.1, hopefully the appropriate modules
> compiled.
>=20
> sensors-detect recognizes the Winbond W83697HF, but suggests
> the driver "Unwritten", which curiously enough, I dont have :>
>=20
> The newdrivers page suggests forcing the w83781d to pretend it's
> a w83627hf chip, but I need to run i2cdetect to get the parameters.
>=20
> After I explicitly modprobe i2c-isa (I think), i2cdetect
> will detect that there is a bus 0, but "i2cdetect 0"
> tells me:
> =3D> prog/detect/i2cdetect  0
> Error: Can't use SMBus Quick Write command on this bus (ISA bus?)
>=20
> I'm unclear if I have to explicitly specify a driver for the
> i2c bus (or smb ?), as well as for the sensor.  I tried
>      modprobe i2c-via
> and
>      modprobe i2c-viapro
> but both tell me "No such device"
>=20
> Finally, I noticed the News item that VT8233 support through viapro
> is in CVS. It sounds like what I might need to get sensors to work,
> but I'm a little reluctant to patch my kernel from CVS code....
> Not that I don't trust you work, or anything :> ...
> but if I'm entirely on the wrong track, anyway, I'd just as soon
> not do it :>
>=20
> Is the CVS version of viapro what I need?
>=20
> Thanks in advance; and thanks for a nice project!
>=20
> --
> Bruce Miller
> docmad@md.prestige.net
