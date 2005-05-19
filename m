From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: No sensors dtected on Toshiba m35-s320 laptop
Message-Id: <20041017203656.672f4d78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1098011964.21400.87.camel@Proteus.spacenetltd.com>
In-Reply-To: <1098011964.21400.87.camel@Proteus.spacenetltd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I will appreciate some help with my system. It is a centrino machine.
> Could it be that there are no drivers for my sensor chips. The full
> output from sensors -detect is attached. I'm running Fedora core 2
> kernel 2.6.5-1.358
> (...)
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.

It's very unlikely that you don't have a PCI SMBus. It must have been
hidden by the BIOS. In 2.6 the code for re-enabling such PCI devices is
in drivers/pci/quirks.c. Some times ago, someone posted a patch for a
Toshiba laptop. You might give it a try and/or use it as a base to tweak
the code for your own use.

http://archives.andrew.net.au/lm-sensors/msg18756.html

You may also want to read the documentation in lm_sensors/prog/hotplug,
and use lspci and setpci to find the correct values for the patch.

> Do you want to scan for Super I/O sensors? (YES/no): 
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0x3c)

You also have a Super-I/O chip, most probably from National
Semiconductor. Consult the technical docs that come with your laptop
and/or contact the support and/or open the laptop and see by yourself.
It may or may not include hardware monitoring functions.

-- 
Jean Delvare
http://khali.linux-fr.org/
