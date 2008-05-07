From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 May 2008 12:14:35 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080507141435.6f18c049@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 06 May 2008 22:44:07 +0200, achim wrote:
> Now with that information i compared dumps of 0x70 at idle and load and
> the really differ, even slightly in idle. It is a temperature sensor.=20
> This interface is also there with the k8 cpu. However such an interface
> is not mentioned in the BKDG for K8. Can be it's a sensor for the pwm
> area.

There are lots of things which can change between idle and load, not
just temperature.

> I figured out that the interface at 0x4c is the svi interface. I
> compared dumps with different cpu and northbridge voltages and both make
> a difference.=20

Ah, I get it now. Apparently address bit 2 is inverted, so 000b in the
register, means that the I2C address ends up in 100b. Which is the case
of 0x4c (1001100b). This suggests that the hard-coded part of the
address is 1001b for the 4 most-significant bits.

> A collegue of mine tried i2cdetect 0 on his Abit AX78 (770 chipset,
> SB600, and a =EF=BB=BFw83627ehf sensor-chip. On his board it's the sensor=
 chip
> at 0x2e if i read the log file correct.
> He's using an Phenom 9850BE and does not get the interfaces at 0x4c,
> 0x57. Also he has no interface at 0x70.
>=20
> > # sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)
> > Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
> > Client found at address 0x2e
> > Probing for `SPD EEPROM'... Yes
> > (confidence 8, not a hardware monitoring chip)
> > Probing for `SPD EEPROM'... Yes
> > (confidence 8, not a hardware monitoring chip)
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `VIA/Winbond/Fintek'... Yes
> > Found `Winbond W83627DHG Super IO Sensors' Success!
> > (address 0x290, driver `w83627ehf')
> > AMD K10 thermal sensors... Success!
> > (driver `to-be-written')
> > Driver `w83627ehf' (should be inserted):
> > Detects correctly:
> > * ISA bus, address 0x290
> > Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> > Driver `to-be-written' (should be inserted):
> > Detects correctly:
> > * Chip `AMD K10 thermal sensors' (confidence: 9)

This is incomplete so it is impossible to say if there's a sensor chip
or something else at SMBus address 0x2e. While it is a common address
for sensor chips, we've seen on your board that other chips can live
there. But I doubt it, as the Super-I/O chips has sensors, too.

> >=20
> > $ i2cdetect -l
> > Code:
> > i2c-0	unknown   	SMBus PIIX4 adapter at 0b00     	N/A
> > $ sudo i2cdetect 0
> > Code:
> > 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
> > 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
> > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> > 50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> > 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --=20
> > 70: -- -- -- -- -- -- -- --
> > $ sudo i2cdump 0 0x2e
> > Code:
> > 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: c5 0f 00 00 00 00 00 c0 14 62 ff ff ff ff ff ff    ??.....??b......
> > 10: 02 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

Doesn't look like anything I know. But it also doesn't seem to be the
same chip as you have on your own boards.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
