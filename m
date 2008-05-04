From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 16:05:42 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080504180542.1cf39a6b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 04 May 2008 15:23:23 +0200, achim wrote:
> The odd thing is the Sapphire board uses the same clock chip as the M3A
> but does not show that chip at 0x69.

Note that there's a chip at 0x70 on the Sapphire motherboard, I've
already seen mux chips at this address. So maybe the clock chip at 0x69
is there but on a branch of the mux which isn't currently active.

As a side note, I think it would have been really great if whatever
chip at 0x2e was behind a gate or mux so that it can't be accessed by
default. This would have avoided all the trouble.

> I must use nolapci and irqpoll to boot the 2.6.24 kernel on that
> machine, does this have an impact?

Shouldn't, as the i2c-piix4 driver doesn't use interrupts.

> Maybe it is the voltage regulator chip, on the M3A it's this one
>=20
> ISL6559
> http://www.st.com/stonline/products/literature/ds/13605.pdf

This one is using Send Byte, which is a write transaction that starts
the same as a Read Byte transaction. sensors-detect would effectively
write to this chips while probing it. To make things worse, it
apparently acks all addresses from 0x60 to 0x6f. The good news is that
senors-detect no longer probes these addresses, so we're safe.

I can only imagine that whatever chip at 0x2e is causing trouble, it
also uses Send Byte transactions. It will see basically random writes
from the sensors-detect script, resulting in random VID codes and in
turn random Vcore to be applied to the CPU. No good.

Unfortunately it can't be helped. Such chips could live at virtually
any address and be found on any motherboard, so the only safe solution
would be to plain stop probing for chips on the SMBus.

> on the GBt board it's a ISL6323
> http://www.intersil.com/data/fn/fn9278.pdf

Couldn't find how this one is accessed.

> The sapphire board has digital PWM and no voltage regulator chip.
>=20
> The DFI Lanparty NF4 has an voltage regulator chip at the right bottom
> http://www.techpowerup.com/reviews/DFI/LPNF4Expert/images/board.jpg
>=20
> http://www.techpowerup.com/reviews/DFI/LPNF4Expert/images/cpuarea.jpg
> ISL6559CB
>=20
> All those voltage regulator chips seem to have no smbus interface so the
> chip at 0x2e and 0x4e must be something different.
>=20
> At 0x6e i'd expect the clock generator. I'll switch back to the sapphire
> board now and will do some ref HT modifications there. Is there a simple
> way to skip the reading at 0x9e?

Starting with i2c-tools version 3.0.1, you can provide a range or
registers to read from, with -r. If you choose -r 0-0x9d, I guess you
will avoid the lockup.

> I found the part number of chip number four. :)
> It's an ICS9DB403DGLF
>=20
> http://www.idt.com/?genID=9DB403
>=20
> I just skimmed over the specs, that chip is related to the pcie and has
> an smbus interface.

And lives at address 0x6e.

> How did you find out the address of the 690G clock chips by looking at
> the specs?

Search for "slave address". The datasheet says it sends byte D2 to
write to slave and D3 to read from it. The address byte is the 7-bit
slave address + 1 read/write bit (0 for write, 1 for read). So you get
the slave address by shifting address byte by 1 to the right (i.e.
dividing it by 2): 0xD2/2 =3D 0x69.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
