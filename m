From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Sep 2012 15:14:49 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120917151449.GA1636@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Sep 17, 2012 at 11:51:08AM +0100, MrNice wrote:
> On Sun, Sep 16, 2012 at 09:03:17PM +0100, Jean-Pierre Thibert wrote:
> >On 16/09/12 19:53, Guenter Roeck wrote:
> >>On Sun, Sep 16, 2012 at 07:44:58AM +0100, Jean-Pierre Thibert wrote:
> >>[ ... ]
> >>>>
> >>>I have an ASRock 970 Extreme4 UEFI version P2.00
> >>>In the H/W Monitor page of the UEFI/BIOS, I have the following:
> >>>CPU Temperature :    36.5 =B0C
> >>>M/B Temperature :    28.0 =B0C
> >>>
> >>>CPU Fan 1 Speed :    1065 RPM (this is a pwm connector with 4 pins.
> >>>I have a pwm fan) called CPU_FAN1 on the motherboard
> >>>CPU Fan 2 Speed :    N/A (this is a 3 pins connector. No connected
> >>>fan) called CPU_FAN2 on the motherboard
> >>>Chassis Fan 1 Speed :    N/A (this is a pwm connector with 4 pins.
> >>>No connected fan) called CHA_FAN1 on the motherboard
> >>>Chassis Fan 2 Speed :    730 RPM (this is a 3 pins connector. I have
> >>>a 3 pins connected fan) called CHA_FAN2 on the motherboard
> >>>Chassis Fan 3 Speed :    760 RPM (this is a 3 pins connector. I have
> >>>a 3 pins connected fan) called CHA_FAN3 on the motherboard
> >>>Power Fan Speed :    N/A (this is a 3 pins connector. No connected
> >>>fan) called PWR_FAN1 on the motherboard
> >>>
> >>>Vcore :    +1.328 V
> >>>+ 12.00V :    +12.144 V
> >>>+ 5.00V :    +5.136 V
> >>>+ 3.30V :    +3.280 V
> >>>
> >>>lm-sensors has almost all the values but no fan speed.
> >>>I don't know why I had the CPU_FAN2 for a short time and it disappeare=
d.
> >>>I can't understand what you suggest to have the value back. Could
> >>I did not suggest anything.
> >>
> >>I found some information about the board. The chassis fans are connecte=
d to
> >>memory mapped IO, so there is nothing we can do there. There are two CP=
U fans,
> >>multiplexed to the SuperIO chip through GPIO pins. It _might be possibl=
e that
> >>we can manually set those pins.
> >>
> >>Please send the output of the following commands:
> >>	isadump -y -k 0x87,0x87 0x2e 0x2f
> >>	isadump -y -k 0x87,0x87 0x2e 0x2f 8
> >>	dmidecode
> >>
> >>Thanks,
> >>Guenter
> >>
> >>
> >>
> >>
> >sudo isadump -y -k 0x87,0x87 0x2e 0x2f
> >     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> >00: ff ff 00 ff ff ff ff 0b ff ff ff ff ff ff ff ff
> >10: ff ff ff ff ff ff ff ff ff ff f8 ce 00 00 ff ff
> >20: c3 33 ff 00 5c 00 00 90 00 ff 60 04 81 00 00 01
> >30: e1 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >60: 02 90 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
> >70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >e0: 7f 7f ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >f0: 00 00 00 a4 ff 10 00 87 47 00 00 ff ff ff ff ff
> >
> >
> >sudo isadump -y -k 0x87,0x87 0x2e 0x2f 8
> >     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> >00: ff ff 00 ff ff ff ff 08 ff ff ff ff ff ff ff ff
> >10: ff ff ff ff ff ff ff ff ff ff f8 ce 00 00 ff ff
> >20: c3 33 ff 00 5c 00 00 90 00 ff 60 04 81 00 00 01
> >30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >60: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >f0: f3 f3 00 ff 00 00 00 00 ff ff ff ff ff ff ff ff
> >
>=20
> I just noticed that you dropped the mailing list in your reply.
> Please don't do that; others may need the information later on,
> and I myself use it for searches.
>=20
> I initially thought the above does not help, but it kind of makes sense.
>=20
> You can try the following command sequence (at your own risk):
>=20
> isaset -y -f 0x2e 0x87
> isaset -y -f 0x2e 0x87
> isaset -y 0x2e 0x2f 0x7 0x8
> isaset -y 0x2e 0x2f 0xf0 0xb2
> isaset -y 0x2e 0x2f 0xf1 0xb3
>=20
> The 0xb3 in the last command should select CPUFANIN. Replace it with 0xf2=
 to
> select CPUFANIN2.
>=20
> You'll have to copy the commands into a file and execute it as shell scri=
pt.
>=20
> Do _not_ play with other settings of register 0xf0 or 0xf1. The informati=
on
> in the ASRock tool suggests that one of the bits is used to control the D=
DR3
> voltage.
>=20
> Guenter
>=20
> I am a bit afraid with "(at your own risk):"
> Do I really need to do that?

Only if you want to see the CPU fan speed.

> Could you check again the hexa values to be sure.

You are welcome to check yourself. You can find the ASRock board parameters=
 in
the Conf subdirectory of the ASRock performance tuning utility. The file for
your board is named 970E4.xml. The datasheet for the SuperIO chip is availa=
ble
from Nuvoton's web site. The datasheet for NCT6776F is marked as "Request",
but you can download and use the datasheet for NCT5577D instead; it is most=
ly
the same.

> The last command I have to add should be:
> isaset -y 0x2e 0x2f 0xf1 0xf2
> yes?

If your fan is connected to CPUFANIN2, yes. Otherwise it would be "isaset -y
0x2e 0x2f 0xf1 0xb3".

> What will I to do after that? directly run sensors or something else?
>=20
Yes, if you run the sensors command, you should see the CPUFAN speed.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
