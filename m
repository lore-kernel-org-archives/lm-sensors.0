From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Apr 2006 11:42:30 +0000
Subject: [lm-sensors] [PATCH] remove the fix_hstcfg from i2c-piix4
Message-Id: <20060402134230.e72b98a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <442F00B8.6010507@sh.cvut.cz>
In-Reply-To: <442F00B8.6010507@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

> This patch removes the fix_hstcfg option from the driver and related SMBus Interrupt Select register
> magic because now we know what are valid values for this register. This patch updates the documentation
> and adds new IRQ mode check so we are sure not to miss any new "unusual" value.
> 
> The PCI quirk for users of fix_hstcfg was not developed because the chipset lacks of subsystem ID registers
> and DMI is stated "To be filled". Impact to existing systems is minimal because the problem showed up
> on motherboards like 10 years back. On the other hand users of newer Serverworks and HT1000 systems won't
> be misleaded by the message suggesting to try the fix_hstcfg any more.

Agreed.

My comments on the patch:

> +If you have some rather strange SMBus problems, you may need to change the
> +SMBus Interrupt Select register as it is known solution for Force CPCI735
> +motherboard or other OSB4 based systems. Please contact us for further
> +assistance (lm-sensors at lm-sensors.org).

Oh, no. We don't want more support requests on this. Instead, please
explain how to get the register value using lspci and how to write back
the modified value using setpci.

Besides, are you sure that other OSB4 based systems did need this? I've
searched all my mails, and couldn't find anyone reporting success after
using fix_hstcfg, except Tom.

> -	if ((temp & 0x0E) = 8)
> +	if (((temp & 0x0E) = 8) || ((temp & 0x0E) = 2))

I think I understand that 8 is OK for non-Serverworks one and 2 is OK
for Serverworks one, right? So maybe we can improve this check and do:

if ((temp & 0x0E) = (id->vendor = PCI_VENDOR_ID_SERVERWORKS ? 2 : 8))

What do you think?

Thanks,
-- 
Jean Delvare

