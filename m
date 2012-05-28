From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2012 07:01:43 +0000
Subject: Re: [lm-sensors] Problems with SMSC EMC2103-2
Message-Id: <20120528090143.4a35441c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
In-Reply-To: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 May 2012 23:39:23 +0200, sebl@storm-clan.de wrote:
> Hi,
> 
> somehow lm-sensors does not seem to recognize the EMC2103-2 chip in my
> notebook (HP 2530p). When i run sensors-detect it says:
> 
> #Do you want to scan for Super I/O sensors? (YES/no): y
> #Probing for Super-I/O at 0x2e/0x2f
> #Trying family `National Semiconductor/ITE'... No
> !#Trying family `SMSC'... Yes
> !#Found unknown chip with ID 0x4501
> #Probing for Super-I/O at 0x4e/0x4f
> #Trying family `National Semiconductor/ITE'... No
> #Trying family `SMSC'... No
> #Trying family `VIA/Winbond/Nuvoton/Fintek'... No
> #Trying family `ITE'... No
> 
> "Found unknown chip with ID 0x4501" But I'm 100% certain that it is the
> EMC2103-2 chip which is described as support in the documentation.

How are you 100% certain? Did you read the top marking of the chip?

Me, I am 100% certain that the above is NOT an EMC2103-2, because it is
connected to the LPC bus while the EMC2103-2 is an SMBus chip. Can't be
the same chip.

The chip above is likely to be a HP-specific Super-I/O chip, maybe
Juerg (Cc'd) can identify it. There is no guarantee that it includes
hardware monitoring features though.

> I can
> load the driver with modprobe emc2103, but nothing happens.

This is expected for all SMBus-based drivers, devices can appear
afterward so drivers never refuse to load.

> lm-sensors
> only detects the temperature-sensors correctly, not the fan speed or
> anything else. Are there known problems with this chip? Or is somenone
> successfully running lm-sensors with EMC2103-2?

Driver was contributed by SMSC themselves (Steve Cc'd), I'm fairly
certain that they tested their code.

What could happen is that the SMBus controller to which the EMC2103-2
chip is connected, is not properly supported on your system. Maybe it
is a very recent chip we don't support yet, or maybe ACPI gets in the
way and prevents the driver from binding to the chip. I'd like to see
the complete output of sensors-detect and lspci.

Note BTW that it is very frequent for laptops to not include complete
hardware monitoring chips. Furthermore, the monitoring chip is usually
hidden behind ACPI so all you get is the limited ACPI thermal zone
interface, or some proprietary interface. You may want to give a try to
the hp_accel and hp-wmi modules for laptop-specific features support.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
