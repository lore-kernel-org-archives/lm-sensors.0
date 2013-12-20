From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Dec 2013 23:18:33 +0000
Subject: Re: [lm-sensors] how to adjust properties?
Message-Id: <20131220231833.GA8784@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384981512.39249.YahooMailNeo@web122905.mail.ne1.yahoo.com>
In-Reply-To: <1384981512.39249.YahooMailNeo@web122905.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Dec 20, 2013 at 02:31:18AM -0800, jonathan stewart wrote:
>=20
> # sensors-detect revision 6031 (2012-03-07 17:14:01 +0100)
> # Board: Micro-Star International Co., Ltd. MS-1761
>=20
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>=20
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): yes
> Module cpuid loaded successfully.
> Silicon Integrated Systems
>  SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No
> VIA VT82C686 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD K8 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 10h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
>  No
> AMD Family 11h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 12h and 14h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 15h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 15h power sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Intel digital thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
>  Success!
> =A0=A0=A0 (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA Nano thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
>=20
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): yes
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National
>  Semiconductor/ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Trying family `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family
>  `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
>=20
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no): yes
> Probing for `National Semiconductor LM78' at
>  0x290...=A0=A0=A0=A0=A0=A0 No
> Probing for `National Semiconductor LM79' at 0x290...=A0=A0=A0=A0=A0=A0 No
> Probing for `Winbond W83781D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `Winbond W83782D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No
>=20
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): yes
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH)
> Module i2c-i801 loaded successfully.
> Module i2c-dev loaded successfully.
>=20
> Next adapter: NVIDIA i2c adapter 0 at
>  1:00.0 (i2c-0)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-1)
> Do you want to scan it? (YES/no/selectively): yes
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `Analog Devices ADM1034'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `SPD EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `EDID
>  EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes
> =A0=A0=A0 (confidence 8, not a hardware monitoring chip)
>=20
> Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-2)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 3 at 1:00.0 (i2c-3)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 5 at 1:00.0 (i2c-4)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 8 at 1:00.0 (i2c-5)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:=20
>=20
> Driver `coretemp':
> =A0 * Chip `Intel digital thermal sensor' (confidence: 9)
>=20
>=20
> it is a laptop, its from xoticpc.com its a force1761 based on the msi gt7=
90dxr it has an i7-2670qm, 4gb patriot ddr3 1600mhz, nvidia gtx570m, corsai=
r performance pro 128gb ssd, 750gb seagate 7200 rpm hdd (? on actual speed =
but its not the 5k version), and a dvd burner
>=20
> it says in synaptic=20
>=20
>=20
> sorry if this still isnt enough information i am good at building pc's an=
d judging their performance but i've just started learning about the softwa=
re/os side of things
>=20
>=20
That doesn't look very promising. Laptop fans are usually not controllable =
at
all, or controlled through the BIOS. I don't see anything that would lead m=
e to
believe that this one can be controlled from the OS.

If the BIOS of your system doesn't let you set fan controls, I don't think =
there
is anything you (or we) can do.

Guenter

>=20
> On Wednesday, November 20, 2013 5:02 PM, Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> =20
> On Wed, Nov 20, 2013 at 01:05:12PM -0800, jonathan stewart wrote:
>=20
> > i have
>  downloaded/installed the lm sensors (and related packages) and fancontro=
l through the synaptic package manager. i was wondering if you could tell m=
e how to adjust the fan speed. i am using ubuntu 13.04 64bit and i only ask=
 because my temps get up to the low 90C's and my fan doesnt spin up much. i=
 have a button that sets fan speed at 100% then temps drop to 50C's but its=
 way to noisy. sorry if this is confusing i'm not entirely sure on how to s=
tate my problem.
> > _______________________________________________
>=20
> Hi,
>=20
> you do not really provide enough information to enable us to help.
> Output from "sensors" command might be helpful, as well as
> some more information about your hardware.
> PC ? Laptop ? CPU type ? Super-IO chip ? fancontrol configuration ?
>=20
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
