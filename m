From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Apr 2009 06:27:13 +0000
Subject: Re: [lm-sensors] Problem with MSI MS-7031
Message-Id: <20090425082713.3a37bcf1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090421181310.205493a9@nat.nasa.one.pl>
In-Reply-To: <20090421181310.205493a9@nat.nasa.one.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 21 Apr 2009 18:13:10 +0200, Schwarz wrote:
> Hi,
>=20
> I have problem reading sensors from MSI MS-7031 (or MSI RS350M) this is
> Fujitsu-Siemens OEM board, with Socekt 478 and integrated Radeon 9200
> Pro (IGA) CPU: Pentium 4 3GHz HT with 1GB ram.
> Chipset: ATI iXP300=20
> Sensors: w83627thf
> This board have smartfun control turned on. (slow down fans under 40C)
> My system is Gentoo x86 STABLE on Gentoo Hardened Kernel
> Profile: [Gentoo Server]
> lm_sensors 2.10.7
>=20
> My sensors output:
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.94 V  (min =3D  +1.94 V, max =3D  +1.94 V)       ALARM  (be=
ep)
> +12V:     +15.50 V  (min =3D +15.50 V, max =3D +15.50 V)       ALARM  (be=
ep)
> +3.3V:     +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (be=
ep)
> +5V:       +6.80 V  (min =3D  +6.80 V, max =3D  +6.80 V)       ALARM  (be=
ep)
> -12V:      +6.06 V  (min =3D  +6.06 V, max =3D  +6.06 V)       ALARM  (be=
ep)
> V5SB:      +6.85 V  (min =3D  +6.85 V, max =3D  +6.85 V)       ALARM  (be=
ep)
> VBat:      +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (be=
ep)
> fan1:        0 RPM  (min =3D    0 RPM, div =3D 128)              ALARM
> (beep) CPU Fan:     0 RPM  (min =3D    0 RPM, div =3D 128)
> ALARM  (beep) fan3:        0 RPM  (min =3D    0 RPM, div > 128)          =
    ALARM  (beep) M/B Temp:     -1=B0C  (high =3D    -1=B0C,
> hyst =3D    -1=B0C)   sensor =3D diode   ALARM   (beep) CPU Temp:   +0.0=
=B0C
> (high =3D    +0=B0C, hyst =3D    +0=B0C)   sensor =3D diode   ALARM   (be=
ep)
> temp3:      +0.0=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)   sensor =
=3D diode
> ALARM   (beep) alarms:   Chassis intrusion
> detection                      ALARM beep_enable: Sound alarm enabled
>=20
> Everything shows wrong value.
> Changing sensors type in /etc/sensors.conf does not help (I tried:
> 1,2,3,4)
> In BIOS I see that
> CPU have ~45C
> GPU: ~60C (Integrated ATI Radeon 9200 Pro)
> fan1: ~3000rpm (Pentagram 80x80mm 12V ~0.2mA)
> fan2: ~1200rpm (really big and slow 160x160mm 12V ~0.17mA)
> fan3: does not exist
>=20
> I attached sensors-detect output as s.log
>=20
> pls, help me get somthing from my sensors...=20

For reference, we investigated this on IRC, the W83627THF is
apparently not used for hardware monitoring, but no other monitoring
chip was found. There was a chip at 0x2f on the SMBus but it doesn't
look like anything we know. So we are stick for now, until we learn
from the board vendor where the BIOS gets its temperature and fan speed
readings.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
