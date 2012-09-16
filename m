From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Sep 2012 18:53:08 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120916185308.GA25960@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Sep 16, 2012 at 07:44:58AM +0100, Jean-Pierre Thibert wrote:
[ ... ]
> >
> >
> I have an ASRock 970 Extreme4 UEFI version P2.00
> In the H/W Monitor page of the UEFI/BIOS, I have the following:
> CPU Temperature :    36.5 =B0C
> M/B Temperature :    28.0 =B0C
>=20
> CPU Fan 1 Speed :    1065 RPM (this is a pwm connector with 4 pins.
> I have a pwm fan) called CPU_FAN1 on the motherboard
> CPU Fan 2 Speed :    N/A (this is a 3 pins connector. No connected
> fan) called CPU_FAN2 on the motherboard
> Chassis Fan 1 Speed :    N/A (this is a pwm connector with 4 pins.
> No connected fan) called CHA_FAN1 on the motherboard
> Chassis Fan 2 Speed :    730 RPM (this is a 3 pins connector. I have
> a 3 pins connected fan) called CHA_FAN2 on the motherboard
> Chassis Fan 3 Speed :    760 RPM (this is a 3 pins connector. I have
> a 3 pins connected fan) called CHA_FAN3 on the motherboard
> Power Fan Speed :    N/A (this is a 3 pins connector. No connected
> fan) called PWR_FAN1 on the motherboard
>=20
> Vcore :    +1.328 V
> + 12.00V :    +12.144 V
> + 5.00V :    +5.136 V
> + 3.30V :    +3.280 V
>=20
> lm-sensors has almost all the values but no fan speed.
> I don't know why I had the CPU_FAN2 for a short time and it disappeared.
> I can't understand what you suggest to have the value back. Could

I did not suggest anything.

I found some information about the board. The chassis fans are connected to
memory mapped IO, so there is nothing we can do there. There are two CPU fa=
ns,
multiplexed to the SuperIO chip through GPIO pins. It _might be possible th=
at
we can manually set those pins.

Please send the output of the following commands:
	isadump -y -k 0x87,0x87 0x2e 0x2f
	isadump -y -k 0x87,0x87 0x2e 0x2f 8
	dmidecode

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
