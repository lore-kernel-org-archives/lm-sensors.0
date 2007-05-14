From: "Hans Edgington" <hans@edgington.nl>
Date: Mon, 14 May 2007 19:34:14 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with non
Message-Id: <000201c7965e$db763d80$20140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c793d8$678c3790$20140a0a@EA002>
In-Reply-To: <000301c793d8$678c3790$20140a0a@EA002>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan & Hans


> Do you have more details on the MSI mobo's? Type? BIOS version? And the
> memory configuration (how many MB's / GB's)

One of the testers just sent me his the info on his mobo, he has a MSI P965
Platinum mobo. American Megatrends bios version 1.4 with 4GB of ram
installed. The American Megatrend setup utility(v2.61) is reporting a total
system memory of 3328MB.

> Maybe the PAE - Physical Address Extension is messing up the memory-mapped
> I/O on these mobo's. If that's the case, it's very likely that the only 
> data your driver gets is rubbish data.
> PAE could reserve certain regions for PCI/pnp addressing. But normally 
> that only happens on 4Gb systems where the top 512Mb is reserved for 
> PCI/pnp addressing.

How do we then test if this is the case and is there a way of dealing with
it?

> Good to see you working on this! Can you explain the "It seems that the 
> region is reserved for pnp", a bit more?

When checking /proc/ioports this is what you see after loading the driver

0a00-0adf : pnp 00:0d
  0a00-0a01 : f71882fg

> Are you talking about the IO-address used by the sensors logical device of
> the super/io chip, or about ... ?

When the logical device is set to hwmon you can read the base address from
the registers. Which should contain the sensors data.

> Does your driver need to enable the sensors part on those MSI mobo's? Then

> maybe it also needs to search for a free io-space and program that into to

> superio config registers for the sensors logical device, before enabling 
> it.

On some of the test systems it does need to select the correct logical
device, but not on all. I'm not sure if it does need to enable the sensors.

Thanks,
Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
