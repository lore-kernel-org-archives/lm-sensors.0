From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Sep 2010 13:54:05 +0000
Subject: Re: [lm-sensors] i2c-i801 module conflict with 3400 Series Chipset
Message-Id: <20100901155405.06b119a7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C7934CC.4020902@fidit.com>
In-Reply-To: <4C7934CC.4020902@fidit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 01 Sep 2010 15:07:50 +0200, support RG wrote:
> as i read in Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
> 
> i launch latest release from svn
> pass one step more than ever
> 
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series (PCH)
> 
> as before
> _>Do you want to probe the I2C/SMBus adapters now? (YES/no):
>  >Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3._
>  >Sorry, no supported PCI bus adapters found.
> 
> but sensors view no more and dmesg already says conflict
> 
> fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ dmesg | grep conflict
> [   17.201490] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts 
> with ACPI region SMBI [0xf000-0xf00f]
> 
> could you help me ?

Poster avec un nom bidon, ça n'aide pas à avoir des réponses. La
prochaine fois, postez avec un vrai nom...

Your problem is that the ACPI BIOS requested the I/O ports of the SMBus
control, so they are no longer available for native Linux drivers. What
the BIOS uses the ports for, I can't tell without disassembling the
DSDT table of the machine.

> finaly, _with or without i2c-i801_ and//or k8temp load at startup
> sensors return only

Why the hell would you load the k8temp driver on an Intel system?

If anything, you would load the coretemp driver, which is meant for
Intel CPUs.

> fidit@de100816A:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +39.5°C  (crit = +100.0°C)

This is quite possibly why the ACPI BIOS needed access the SMBus.

> under everest on seven, 6 temp are detect.

This is awfully vague. Which temperatures? From what devices?

It is entirely possible that Everest decided to bypass the ACPI
resource conflict. Something you definitely don't want to do on a
production machine, at least not before a complete analysis of the DSDT.

If you aren't happy with the situation, I suggest that you contact the
hardware vendor and ask they how you are supposed to do hardware
monitoring on that model.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
