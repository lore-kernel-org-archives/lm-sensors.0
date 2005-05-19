From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: Forcing the it87 chip with i2c-isa driver for sis630
Message-Id: <3CEC0B7E.F27E3D4D@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1021643436.5208.20.camel@debian>
In-Reply-To: <1021643436.5208.20.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

that doesn't look very good.
Perhaps the base address is not 0x290 or the sensors are not enabled.
You can see if things look interesting with 'isadump 0x295 0x296',
for example, to look at things at address 0x290.
This will probably return all ff's.
You may be able to find a 950 datasheet and find out how
to set or read the base address, or enable the sensors in it.

Pere Casta?er wrote:
>=20
> First of all I want to say thanks for your effort to do a great linux
> software!
>=20
> Well I own a laptop clevo 2200 with sis630 integrated mainboard. I have
> installed Debian Sid on it and I wanted to have the sensors up&runing
> because this laptop is running to hot.
>=20
> I installed the lm_sensors 2.6.3 and I wasted a lot of time and effort
> to configure any driver and any chip sensor for this motherboard.
> First of all Sis630 has a sis950 Chip for sensor detection because of it
> I force the it87 to go with i2c-isa driver.
>=20
> I do this:
> modprobe i2c-isa [done]
> modprobe it87 force_it87=9191,0x290[done!]
>=20
> and the message for command sensors:
>=20
> debian:~# sensors
> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
> VCore 2:   +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
> +3.3V:     +8.16 V  (min =3D  +8.16 V, max =3D  +8.16 V)   ALARM
> +5V:       +6.85 V  (min =3D  +6.85 V, max =3D  +6.85 V)   ALARM
> +12V:     +16.32 V  (min =3D +16.32 V, max =3D +16.32 V)   ALARM
> -12V:      +3.93 V  (min =3D  +3.93 V, max =3D  +3.93 V)   ALARM
> -5V:       +4.03 V  (min =3D  +4.03 V, max =3D  +4.03 V)   ALARM
> Stdby:     +6.85 V  (min =3D  +6.85 V, max =3D  +6.85 V)   ALARM
> VBat:      +4.08 V
> fan1:        0 RPM  (min =3D    0 RPM, div =3D 128)          ALARM
> fan2:        0 RPM  (min =3D    0 RPM, div =3D 128)          ALARM
> fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)          ALARM
> Temp1/MB:     -1?C  (min =3D   -1?C, max =3D   -1?C) ALARM
> Temp2/CPU:    -1?C  (min =3D   -1?C, max =3D   -1?C) ALARM
> Temp3:        -1?C  (min =3D   -1?C, max =3D   -1?C) ALARM
>=20
> is this correct? I forced the it87 but all the sensors are blank?
> I need more configuration for know the cpu temp?
>=20
> The problem is that I don't know if I'm doing it correctly...isn't it?
> thanks for your time.
>=20
> --
> Pere Casta?er Sard?
> Linux Registered user #232073
> Linux Debian GNU User-http://www.debian.org
> Computer Science Engineering of Management student on UOC -
> http://www.uoc.edu
> -------------------------------------------------------------------------=
----|
> GnuPG Fingerprint: D3D1 ABD8 E63A 3E02 0B03  997E C07B 1C68 C80C D044
> http://www.gnupg.org
> -------------------------------------------------------------------------=
----|
>=20
>   -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------------------------
>                        Name: signature.asc
>    signature.asc       Type: application/pgp-signature
>                 Description: Esta parte del mensaje esta firmada digitalm=
ente
