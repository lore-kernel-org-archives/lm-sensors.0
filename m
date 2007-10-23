From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2007 12:22:08 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071023142208.6f03a703@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 21 Oct 2007 21:37:26 +0200, Jean Delvare wrote:
> Juergen,
>=20
> On Sat, 20 Oct 2007 21:39:32 +0200, Juergen Bausa wrote:
> > > Von: Jean Delvare <khali@linux-fr.org>
> > > Juergen, if you load the "thermal" driver and look
> > > in /proc/acpi/thermal_zone, do you see a temperature reported, with t=
he
> > > same value as one of the DME1737 temperature channels?
> >=20
> > Yes, I see a temperature, but its not the same.
> >=20
> > lisa:/home/jba# cat /proc/acpi/thermal_zone/THRM/temperature
> > temperature:             40 C
> > lisa:/home/jba# sensors
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:
> >              +44=B0C
> > Core0 Temp:
> >              +46=B0C
> > Core1 Temp:
> >              +52=B0C
> > Core1 Temp:
> >              +49=B0C
> >=20
> > dme1737-i2c-0-2e
> > Adapter: SMBus nForce2 adapter at 4c00
> > V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> > Vccp:      +1.09 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > V3.3:      +3.27 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > V5:        +4.93 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > V12:      +11.78 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > V3.3stby:  +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Int Temp:    +32=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > CPU Temp:    +30=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > CPU_Fan:     0 RPM  (min =3D    0 RPM)
> > ERROR: Can't get fan3 data!
> > ERROR: Can't get fan5 data!
> > ERROR: Can't get fan6 data!
> > CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> > ERROR: Can't get pwm5 data!
> > ERROR: Can't get pwm6 data!
> > cpu0_vid: +1.550 V  (VRM Version 2.4)
> >=20
> > lisa:/home/jba#                       =20
>=20
> OK. It doesn't mean that ACPI doesn't get the temperatures from the
> DME1737 chip though, it could be adding some arbitrary offset. Can you
> please send me your DSDT table in private? I'll take a look.

OK, I've taken a look at the DSDT and it includes references to
hardware monitoring features all around the place:

            Device (ASOC)
            {
                Name (_HID, "ATK0110")
                Name (_UID, 0x01010110)
                Name (MBIF, Package (0x08)
                {
                    0x01,=20
                    "M2N8L",=20
                    0x01010101,=20
                    0x01010101,=20
                    0xC0010002,=20
                    0x01,=20
                    0x00,=20
                    0x00
                })
                Name (VBUF, Package (0x05)
                {
                    0x04,=20
                    VCRE,=20
                    V333,=20
                    V500,=20
                    V120
                })
                Name (VCRE, Package (0x05)
                {
                    0x06020000,=20
                    "Vcore Voltage",=20
                    0x05AA,=20
                    0x06D6,=20
                    0x01
                })
                Name (V333, Package (0x05)
                {
                    0x06020001,=20
                    " +3.3 Voltage",=20
                    0x0BB8,=20
                    0x0E10,=20
                    0x01
                })
                Name (V500, Package (0x05)
                {
                    0x06020002,=20
                    " +5.0 Voltage",=20
                    0x1194,=20
                    0x157C,=20
                    0x01
                })
                Name (V120, Package (0x05)
                {
                    0x06020003,=20
                    "+12.0 Voltage",=20
                    0x2BC0,=20
                    0x3390,=20
                    0x01
                })
                Name (TBUF, Package (0x03)
                {
                    0x02,=20
                    CPUT,=20
                    MBTP
                })
                Name (CPUT, Package (0x05)
                {
                    0x06030000,=20
                    "CPU Temperature",=20
                    0x0384,=20
                    0x04E2,=20
                    0x00010001
                })
                Name (MBTP, Package (0x05)
                {
                    0x06030001,=20
                    "MB Temperature",=20
                    0x02BC,=20
                    0x04E2,=20
                    0x00010001
                })
                Name (FBUF, Package (0x06)
                {
                    0x03,=20
                    CPUF,=20
                    CHAF,=20
                    PWRF,=20
                    CHPF,=20
                    CH2F
                })
                Name (CPUF, Package (0x05)
                {
                    0x06040000,=20
                    "CPU FAN Speed",=20
                    0x00,=20
                    0x0708,=20
                    0x00010001
                })
                Name (CHAF, Package (0x05)
                {
                    0x06040001,=20
                    "CHASSIS FAN Speed",=20
                    0x00,=20
                    0x0708,=20
                    0x01
                })
                Name (PWRF, Package (0x05)
                {
                    0x06040002,=20
                    "POWER FAN Speed",=20
                    0x00,=20
                    0x0708,=20
                    0x00
                })
                Name (CHPF, Package (0x05)
                {
                    0x06040005,=20
                    "CHIPSET FAN Speed",=20
                    0x00,=20
                    0x0708,=20
                    0x00
                })
                Name (CH2F, Package (0x05)
                {
                    0x06040006,=20
                    "CHASSIS2 FAN Speed",=20
                    0x00,=20
                    0x0708,=20
                    0x00
                })
                Name (QFAN, Package (0x05)
                {
                    0x04060003,=20
                    "CPU Q-Fan Control",=20
                    0x00,=20
                    0x01,=20
                    0x01
                })
                Name (QFRO, Package (0x05)
                {
                    0x04050004,=20
                    "CPU Q-Fan Ratio",=20
                    0x3C,=20
                    0x5A,=20
                    0x00
                })
                Name (QFTP, Package (0x05)
                {
                    0x04030005,=20
                    "Temperature Range",=20
                    0x02,=20
                    0x50,=20
                    0x00010001
                })
                Name (QCFN, Package (0x05)
                {
                    0x04060006,=20
                    "Chassis Q-Fan Control",=20
                    0x00,=20
                    0x01,=20
                    0x00
                })
                Name (QFCR, Package (0x05)
                {
                    0x04050007,=20
                    "Chassis Q-Fan Ratio",=20
                    0x38,=20
                    0x64,=20
                    0x00
                })

etc etc. This appears to be the half-standard ATK0110 implementation
for which a driver was posted to the lm-sensors list a few months ago.
Maybe for this motherboard you should use this driver rather than the
dme1737 driver. Adding Rudolf in Cc, I think he knows more about this
driver's status.

The DSDT also includes references to the nforce2's SMBus:

            Device (SMB0)
            {
                Name (_ADR, 0x000A0001)
                OperationRegion (SMCF, PCI_Config, 0x48, 0x10)
                Field (SMCF, DWordAcc, NoLock, Preserve)
                {
                    SMPM,   4,=20
                    SMT1,   28,=20
                    SMT2,   32
                }

                OperationRegion (SMCA, PCI_Config, 0x20, 0x08)
                Field (SMCA, DWordAcc, NoLock, Preserve)
                {
                    SB1,    32,=20
                    SB2,    32
                }

                OperationRegion (PDEV, PCI_Config, 0xE8, 0x04)
                Scope (\)
                {
                    Field (\_SB.PCI0.SMB0.PDEV, AnyAcc, NoLock, Preserve)
                    {
                            ,   12,=20
                        ACIE,   1
                    }
                }

                Method (SMBB, 0, NotSerialized)
                {
                    If (PCIA)
                    {
                        And (SB1, 0xFFFE, Local0)
                    }
                    Else
                    {
                        Store (0x4C00, Local0)
                    }

                    Return (Local0)
                }
            }

So at the very least I'd say it's not safe to use the i2c-nforce2 and
dme1737 drivers when the fan and thermal ACPI drivers are in use. But
it may even not be safe when these ACPI drivers aren't loaded, I don't
know.

That being said, I can't guarantee that the I/O errors you've seen are
related to this. There may _also_ be a second master on the SMBus
talking to whatever chip is at address 0x0d. So adding a retry
mechanism to i2c-nforce2 may still be a good idea.

> I also have an experimental (but safe) patch detecting possible
> conflicts between ACPI and hwmon drivers. Do you want to test it?

Hopefully the patch in question will also detect the conflict.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
