From: "Peter Mahlknecht" <mali100@gmx.net>
Date: Sun, 02 Nov 2008 11:25:25 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081102112525.316060@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

HI,
> On Sat, 01 Nov 2008 23:16:56 +0100, Peter Mahlknecht wrote:
> > I got the new kernel (2.6.27.4) running, here is what it outputs during
> boot:
> > Nov  1 22:48:30 laptop-mali kernel: [    9.670886] i801_smbus
> 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> > Nov  1 22:48:30 laptop-mali kernel: [    9.670946] ACPI: I/O resource
> 0000:00:1f.3 [0x18e0-0x18ff] conflicts with ACPI region SMBI [0x18e0-0x18=
ef]
> > Nov  1 22:48:30 laptop-mali kernel: [    9.671002] ACPI: Device needs an
> ACPI driver
>=20
> OK. This confirms that ACPI is using the SMBus so we shouldn't. With
> kernels >=3D 2.6.27, you can boot with parameter
> acpi_enforce_resources=3Dstrict and the i2c-i801 driver will decline
> attaching to the SMBus.

Has this the same effect as just not loading the i2c-i801 driver? Or what o=
ther functions then attaching to the SMBus has the i2c-i801?

> Another test I'd like you to do is:
>=20
> # rmmod em28xx_cx25843
> # rmmod lm90
> # modprobe i2c-i801
> # modprobe i2c-dev
> # i2cdetect -l
> (find the i2c bus number for "SMBus I801 adapter at 18e0")
> # i2cdetect n
> (where n is the bus number in question)
>=20
> I wonder if this will confuse ACPI the same way loading em28xx_cx25843
> does.

It does:
laptop-mali:/home/mali# i2cdetect -l
i2c-0	smbus     	SMBus I801 adapter at 18e0      	SMBus adapter
laptop-mali:/home/mali# cat /proc/acpi/thermal_zone/THRM/temperature=20
temperature:             41 C
laptop-mali:/home/mali# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: 30 -- 32 -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- -- -- 44 -- -- -- -- -- -- -- 4c -- -- --=20
50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --=20
laptop-mali:/home/mali# cat /proc/acpi/thermal_zone/THRM/temperature=20
temperature:             65535 C


Peter
--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit allen: =
http://www.gmx.net/de/go/multimessenger

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
