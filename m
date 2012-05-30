From: "Sebl" <sebl@storm-clan.de>
Date: Wed, 30 May 2012 18:41:20 +0000
Subject: Re: [lm-sensors] Problems with SMSC EMC2103-2
Message-Id: <005e01cd3e93$cebb52f0$6c31f8d0$@storm-clan.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
In-Reply-To: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Yes I'm 100% certain because I can read the top marking. It says: SMSC
EMC2103. So there is no! doubt. But I can send you pictures, if you want.
Hardwaremonitoring (Vcore, fan, ...) is possible with windows, so there
should be the possibility to monitor it with linux, too.
I can send you lspci later, but as far as I remember it only listed the
intel chipset drivers.
hp_wmi and hp_accel modules are automatically loaded @ startup.



-----Urspr=FCngliche Nachricht-----
Von: Jean Delvare [mailto:khali@linux-fr.org]
Gesendet: Montag, 28. Mai 2012 09:02
An: sebl@storm-clan.de
Cc: lm-sensors@lm-sensors.org; Steve Glendinning; Juerg Haefliger
Betreff: Re: [lm-sensors] Problems with SMSC EMC2103-2

On Sun, 27 May 2012 23:39:23 +0200, sebl@storm-clan.de wrote:
> Hi,
>=20
> somehow lm-sensors does not seem to recognize the EMC2103-2 chip in my=20
> notebook (HP 2530p). When i run sensors-detect it says:
>=20
> #Do you want to scan for Super I/O sensors? (YES/no): y #Probing for=20
> Super-I/O at 0x2e/0x2f #Trying family `National Semiconductor/ITE'...
> No !#Trying family `SMSC'... Yes !#Found unknown chip with ID 0x4501=20
> #Probing for Super-I/O at 0x4e/0x4f #Trying family `National=20
> Semiconductor/ITE'... No #Trying family `SMSC'... No #Trying family=20
> `VIA/Winbond/Nuvoton/Fintek'... No #Trying family `ITE'... No
>=20
> "Found unknown chip with ID 0x4501" But I'm 100% certain that it is=20
> the
> EMC2103-2 chip which is described as support in the documentation.

How are you 100% certain? Did you read the top marking of the chip?

Me, I am 100% certain that the above is NOT an EMC2103-2, because it is
connected to the LPC bus while the EMC2103-2 is an SMBus chip. Can't be the
same chip.

The chip above is likely to be a HP-specific Super-I/O chip, maybe Juerg
(Cc'd) can identify it. There is no guarantee that it includes hardware
monitoring features though.

> I can
> load the driver with modprobe emc2103, but nothing happens.

This is expected for all SMBus-based drivers, devices can appear afterward
so drivers never refuse to load.

> lm-sensors
> only detects the temperature-sensors correctly, not the fan speed or=20
> anything else. Are there known problems with this chip? Or is somenone=20
> successfully running lm-sensors with EMC2103-2?

Driver was contributed by SMSC themselves (Steve Cc'd), I'm fairly certain
that they tested their code.

What could happen is that the SMBus controller to which the EMC2103-2 chip
is connected, is not properly supported on your system. Maybe it is a very
recent chip we don't support yet, or maybe ACPI gets in the way and prevents
the driver from binding to the chip. I'd like to see the complete output of
sensors-detect and lspci.

Note BTW that it is very frequent for laptops to not include complete
hardware monitoring chips. Furthermore, the monitoring chip is usually
hidden behind ACPI so all you get is the limited ACPI thermal zone
interface, or some proprietary interface. You may want to give a try to the
hp_accel and hp-wmi modules for laptop-specific features support.

--
Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
