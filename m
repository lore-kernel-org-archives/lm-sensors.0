From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Dec 2007 22:42:15 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <20071209234215.748ed407@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com>
	<20071209000554.GF20441@stusta.de>
	<20071208212234.e00b74cd.mikeserv@bmts.com>
	<20071209105028.06ed52a6@hyperion.delvare>
	<E1J1TRp-0000ZF-6J@asgard.prans.org>
In-Reply-To: <E1J1TRp-0000ZF-6J@asgard.prans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Elvis Pranskevichus <el@prans.net>
Cc: Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>

Hi Elvis,

On Sun, 09 Dec 2007 16:12:25 -0500, Elvis Pranskevichus wrote:
> I have exactly the same problem here on a Gigabyte GA-965G-DS3 motherboard
> based box:

Same motherboard as Mike has.

> it87: Found IT8718F chip at 0x290, revision 1
> it87: in3 is VCC (+5V)
> it87 it87.656: Failed to request region 0x290-0x297
> it87: probe of it87.656 failed with error -16
> 
> git bisecting revealed the offending commit:
> 
> a7839e960675b54: PNP: increase the maximum number of resources
> 
> Happened between rc3 and rc4.
> 
> > Either way, the overlapping areas smell like a BIOS bug, meaning that
> > you should look for an updated BIOS for your system first.
> > 
> >> http://www.mikeserv.com/temp/config-2.6.24-rc4.txt
> > 
> 
> This indeed looks like a broken ACPI BIOS since the aforementioned commit
> touches only the PNP ACPI driver. I'm not sure how to work around this,
> though. Ideas?

Complaining to Gigabyte seems to be the best approach.

In the meantime, I guess that booting with pnpacpi=off should fix your
problem. But it might break something else; I'm not sure what the PNP
ACPI driver is good for in the first place.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
