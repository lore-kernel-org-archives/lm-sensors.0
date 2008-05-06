From: achim <achim@ag-web.biz>
Date: Tue, 06 May 2008 20:44:07 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1210106647.3428.12.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am Dienstag, den 06.05.2008, 16:11 +0200 schrieb Jean Delvare:
> Hi Achim,
>=20
> > >>    =20
> > >
> > > This isn't how I read the specification. Bit 3 set means that the SBI
> > > is _disabled_. But it your case, bit 3 is _not_ set, is it?
> > >
> > > I wonder where the 4 higher SMBus address bits are set.
> > >
> > >  =20
> > Yepp it's unset means SBI is enabled. Can be a bios issue that the=20
> > correct address does not shop up here.
>=20
> What makes you think it doesn't?=20

Simple answer, lack of basic knowledge about i2c/smbus here.
> If I read it correctly, the BKDG says:
> if the address is unset/unused then these bits are 0; it doesn't say:
> if these bits are 0 it means that the address is unset/unused. It is
> perfectly valid for the 3 low bits of an I2C address to be 0. Ideally
> you would find in the datasheet what the other address bits are (I
> guess they are hard-coded.) Note that we've seen a chip at 0x70 on your
> SMBus and we don't know what it is. That could be it, as its 3 low
> address bits at 0.

Now with that information i compared dumps of 0x70 at idle and load and
the really differ, even slightly in idle. It is a temperature sensor.=20
This interface is also there with the k8 cpu. However such an interface
is not mentioned in the BKDG for K8. Can be it's a sensor for the pwm
area.

I figured out that the interface at 0x4c is the svi interface. I
compared dumps with different cpu and northbridge voltages and both make
a difference.=20

> Given that we see a chip at 0x70, the bus has to be alive until then, so
> the i2cdetect probe breaking the bus must be with address >=3D 0x70. Some
> chips don't like the quick command we use by default for probing. You
> might try "i2cdetect -r" and see if it helps. You can also try the
> extra range parameters to probe the addresses one by one, that way you
> can find out which one exactly breaks the bus when probed.
Thanks I tried the range 0x71-0x77 and there where no other chips.
>=20
> > Today I wrote a long problem report for the sapphire support and asked =

> > them what chip they use at 0x2e. Hope they will shed some light on this=
=20
> > issue.
> > I'll post their response here.
>=20
A collegue of mine tried i2cdetect 0 on his Abit AX78 (770 chipset,
SB600, and a =EF=BB=BFw83627ehf sensor-chip. On his board it's the sensor c=
hip
at 0x2e if i read the log file correct.
He's using an Phenom 9850BE and does not get the interfaces at 0x4c,
0x57. Also he has no interface at 0x70.

> # sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)
> Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
> Client found at address 0x2e
> Probing for `SPD EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
> Probing for `SPD EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `VIA/Winbond/Fintek'... Yes
> Found `Winbond W83627DHG Super IO Sensors' Success!
> (address 0x290, driver `w83627ehf')
> AMD K10 thermal sensors... Success!
> (driver `to-be-written')
> Driver `w83627ehf' (should be inserted):
> Detects correctly:
> * ISA bus, address 0x290
> Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> Driver `to-be-written' (should be inserted):
> Detects correctly:
> * Chip `AMD K10 thermal sensors' (confidence: 9)
>=20
> $ i2cdetect -l
> Code:
> i2c-0	unknown   	SMBus PIIX4 adapter at 0b00     	N/A
> $ sudo i2cdetect 0
> Code:
> 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
> 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --=20
> 70: -- -- -- -- -- -- -- --
> $ sudo i2cdump 0 0x2e
> Code:
> 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: c5 0f 00 00 00 00 00 c0 14 62 ff ff ff ff ff ff    ??.....??b......
> 10: 02 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
